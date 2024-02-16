import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/posts_bloc/post_bloc.dart';
import '../../widgets/post_widget.dart';
import '../../widgets/user_profile_header.dart';

class CurrentUserPostListView extends StatefulWidget {
  final int user_id;
  const CurrentUserPostListView({Key? key, required this.user_id}) : super(key: key);

  @override
  CurrentUserPostListViewState createState() => CurrentUserPostListViewState();
}

class CurrentUserPostListViewState extends State<CurrentUserPostListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _loadInitialPosts(int userId) {
    BlocProvider.of<PostBloc>(context, listen: false).add(GetItemsByUser(userId));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.6) {
      final postBloc = BlocProvider.of<PostBloc>(context, listen: false);
      if (postBloc.state.currentPost?.nextPage != null && postBloc.state.status != PostStatus.loadingGetItems) {
        postBloc.add(GetNextItemsByUser(widget.user_id, postBloc.state.currentPost!.nextPage!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState.status == AuthStatus.success) {
          _loadInitialPosts(authState.user!.id);

          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () async {
                _loadInitialPosts(authState.user!.id);
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: UserProfileHeader(
                      user: authState.user!,
                      totalPosts: 0, // Ceci devrait être mis à jour en fonction de l'état du PostBloc
                    ),
                  ),
                  BlocBuilder<PostBloc, PostState>(
                    builder: (context, postState) {
                      if (postState.status == PostStatus.loadingGetItems && postState.items.isEmpty) {
                        return SliverFillRemaining(child: Center(child: CircularProgressIndicator()));
                      } else if (postState.items.isEmpty && postState.status == PostStatus.successGetItems) {
                        return SliverFillRemaining(child: Center(child: Text("No posts yet")));
                      } else {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              if (index < postState.items.length) {
                                return PostWidget(item: postState.items[index]);
                              } else if (postState.currentPost?.nextPage != null) {
                                return Center(child: CircularProgressIndicator());
                              } else {
                                return Container();
                              }
                            },
                            childCount: postState.items.length + (postState.currentPost?.nextPage != null ? 1 : 0),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
              child: Text("You need to be logged to see your profile", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          );
        }
      },
    );
  }
}
