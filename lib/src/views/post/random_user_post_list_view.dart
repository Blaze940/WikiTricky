import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_tricky/src/widgets/custom_app_bar_simple.dart';
import '../../blocs/posts_bloc/post_bloc.dart';
import '../../models/users/user.dart';
import '../../widgets/post_widget.dart';
import '../../widgets/user_profile_header.dart';

class RandomUserPostListView extends StatefulWidget {
  final int user_id;
  final String name;
  final int created_at;

  const RandomUserPostListView({
    Key? key,
    required this.user_id,
    required this.name,
    required this.created_at,
  }) : super(key: key);

  @override
  RandomUserPostListViewState createState() => RandomUserPostListViewState();
}

class RandomUserPostListViewState extends State<RandomUserPostListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialPosts(widget.user_id);
  }

  void _loadInitialPosts(int userId) {
    BlocProvider.of<PostBloc>(context, listen: false)
        .add(GetItemsByUser(userId));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.6) {
      final postBloc = BlocProvider.of<PostBloc>(context, listen: false);
      if (postBloc.state.currentPost?.nextPage != null &&
          postBloc.state.status != PostStatus.loadingGetItems) {
        postBloc.add(GetNextItemsByUser(
            widget.user_id, postBloc.state.currentPost!.nextPage!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final postBloc = BlocProvider.of<PostBloc>(context);

    return Scaffold(
      appBar: CustomAppBarSimple(titleText: widget.name),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadInitialPosts(widget.user_id);
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: UserProfileHeader(
                user: User(
                  id: widget.user_id,
                  name: widget.name,
                  created_at: widget.created_at,
                ),
                totalPosts: postBloc.state.currentPost!.itemsTotal,
              ),
            ),
            BlocBuilder<PostBloc, PostState>(
              builder: (context, postState) {
                if (postState.status == PostStatus.loadingGetItems &&
                    postState.items.isEmpty) {
                  return SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()));
                } else if (postState.items.isEmpty &&
                    postState.status == PostStatus.successGetItems) {
                  return SliverFillRemaining(
                      child: Center(child: Text("No posts yet")));
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
                      childCount: postState.items.length +
                          (postState.currentPost?.nextPage != null ? 1 : 0),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
