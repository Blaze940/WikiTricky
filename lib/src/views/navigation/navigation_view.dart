import 'package:flutter/material.dart';
import 'package:wiki_tricky/src/widgets/custom_app_bar.dart';
import 'package:wiki_tricky/src/widgets/custom_nav_bar.dart';

import '../post/community_post_list_view.dart';

class NavigationView extends StatelessWidget {
  static const String routeName = '/home';

  const NavigationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          titleText: 'WikiTwiki',
        ),
        body: const CommunityPostListView(),
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
