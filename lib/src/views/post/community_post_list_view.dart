import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_tricky/src/blocs/posts_bloc/post_bloc.dart';
import 'package:wiki_tricky/src/widgets/post_card.dart';

class CommunityPostListView extends StatelessWidget {
  final ScrollController scrollController;

  const CommunityPostListView({Key? key, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<PostBloc>(context).add(GetItems()); // Rafraîchir les éléments
      },
      child: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          final items = state.items;
          if (items.isEmpty && state.status == PostStatus.loading) {
            // Si vous voulez afficher le chargement initial sans le RefreshIndicator
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: const Center(
                  child: CircularProgressIndicator(color: Color(0xFF8B0000)),
                ),
              ),
            );
          }
          if (items.isEmpty && state.status == PostStatus.success) {
            return const Center(child: Text("No post yet"));
          }
          final isLoadingNextPage = state.status == PostStatus.loading && items.isNotEmpty;

          return ListView.builder(
            controller: scrollController,
            itemCount: items.length + (isLoadingNextPage ? 1 : 0),
            itemBuilder: (context, index) {
              if (index < items.length) {
                final item = items[index];
                return PostCard(item: item);
              } else {

                return const Center(child: CircularProgressIndicator());
              }
            },
          );
        },
      ),
    );
  }
}
