import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_tricky/src/blocs/posts_bloc/post_bloc.dart';
import 'package:wiki_tricky/src/views/post/community_post_list_view.dart';
import 'package:wiki_tricky/src/widgets/custom_app_bar.dart';
import 'package:wiki_tricky/src/widgets/custom_nav_bar.dart';
import 'package:wiki_tricky/src/widgets/post_card.dart';

class NavigationView extends StatefulWidget {
  static const String routeName = '/home';
  final double PRELOAD_LIMIT = 0.6;

  const NavigationView({Key? key}) : super(key: key);

  @override
  _NavigationViewState createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<PostBloc>(context, listen: false).add(GetItems());
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent * widget.PRELOAD_LIMIT) {
      final postBloc = BlocProvider.of<PostBloc>(context, listen: false);
      if (postBloc.state.currentPost?.nextPage != null && postBloc.state.status != PostStatus.loading) {
        postBloc.add(GetNextItems(postBloc.state.currentPost!.nextPage!));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          titleText: 'WikiTwiki',
        ),
        body: CommunityPostListView(scrollController: _scrollController),
        bottomNavigationBar: const CustomBottomNavBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Action pour créer un nouveau post
          },
          backgroundColor: const Color(0xFF8B0000),
          child: const Icon(Icons.edit_note, color: Colors.white),
        ),
      ),
    );
  }
}
