import 'package:flutter/material.dart';
import 'package:wiki_tricky/src/widgets/create_post_widget.dart';
import 'package:wiki_tricky/src/widgets/custom_app_bar.dart';
import 'package:wiki_tricky/src/widgets/custom_nav_bar.dart';
import '../post/community_post_list_view.dart';

class NavigationView extends StatelessWidget {
  static const String routeName = '/';

  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(
          titleText: 'WikiTwiki',
        ),
        body: CommunityPostListView(),
        bottomNavigationBar: CustomBottomNavBar(),
        floatingActionButton: CreatePostWidget(),
      ),
    );
  }


}
