import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_tricky/src/blocs/posts_bloc/post_bloc.dart';
import 'package:wiki_tricky/src/widgets/post_widget.dart';

class CommunityPostListView extends StatefulWidget {
  const CommunityPostListView({Key? key}) : super(key: key);

  @override
  State<CommunityPostListView> createState() => _CommunityPostListViewState();
}

class _CommunityPostListViewState extends State<CommunityPostListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialPosts();
  }

  void _loadInitialPosts() {
    BlocProvider.of<PostBloc>(context, listen: false).add(GetItems());
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * 0.6) {
      final postBloc = BlocProvider.of<PostBloc>(context, listen: false);
      if (postBloc.state.currentPost?.nextPage != null && postBloc.state.status != PostStatus.loadingGetItems) {
        postBloc.add(GetNextItems(postBloc.state.currentPost!.nextPage!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<PostBloc>(context, listen: false).add(GetItems());
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          final items = state.items;
          if (items.isEmpty && state.status == PostStatus.loadingGetItems) {
            return ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) => const Center(child: CircularProgressIndicator()),
            );
          } else if (items.isEmpty && state.status == PostStatus.successGetItems) {
            return ListView(
              children: const [Center(child: Text("No post yet"))],
            );
          } else {
            return ListView.builder(
              controller: _scrollController,
              itemCount: items.length + (state.currentPost?.nextPage != null ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < items.length) {
                  return PostWidget(item: items[index]);
                } else {
                  return state.currentPost?.nextPage != null
                      ? const Center(child: CircularProgressIndicator())
                      : Container(); // Retourne un conteneur vide si pas de nextPage
                }
              },
            );
          }
        },
      ),
    );
  }
}
