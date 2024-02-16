import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wiki_tricky/src/blocs/posts_bloc/post_bloc.dart';

import 'package:wiki_tricky/src/widgets/custom_app_bar_simple.dart';
import 'package:wiki_tricky/src/widgets/comment_widget.dart';

import '../../widgets/create_comment_widget.dart';

class PostDetailView extends StatefulWidget {
  final int id;

  const PostDetailView({Key? key, required this.id}) : super(key: key);

  @override
  _PostDetailViewState createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<PostDetailView> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostBloc>(context, listen: false).add(GetDetailsPost(widget.id));
  }

  Future<void> _refreshPostDetails() async {
    BlocProvider.of<PostBloc>(context, listen: false).add(GetDetailsPost(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarSimple(titleText: "Details"),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          if (state.status == PostStatus.loadingGetDetailsPost) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == PostStatus.successLoadingGetDetailsPost && state.currentPostDetails != null) {
            return RefreshIndicator(
              onRefresh: _refreshPostDetails,
              child: ListView(
                children: [
                  if (state.currentPostDetails!.image != null)
                    Image.network(
                      state.currentPostDetails!.image!.url,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 200,
                    ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.currentPostDetails!.content,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${state.currentPostDetails!.author.name}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Posted on ${DateFormat('dd/MM/yyyy at HH:mm').format(DateTime.fromMillisecondsSinceEpoch(state.currentPostDetails!.createdAt))}',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  ...state.currentPostDetails!.comments.map(
                        (comment) => CommentWidget(comment: comment),
                  ),
                ],
              ),
            );
          } else if (state.status == PostStatus.error) {
            return Center(child: Text(state.error?.toString() ?? 'Error loading post details'));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: CreateCommentWidget(post_id: widget.id),
    );
  }
}
