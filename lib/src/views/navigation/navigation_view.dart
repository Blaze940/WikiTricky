import 'package:flutter/material.dart';
import 'package:wiki_tricky/src/widgets/custom_app_bar.dart';
import 'package:wiki_tricky/src/widgets/custom_nav_bar.dart';

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
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title:
                    Text('Post $index', style: TextStyle(color: Colors.black)),
                subtitle: Text('Description du post $index'),
                trailing:
                    const Icon(Icons.favorite_border, color: Color(0xFF8B0000)),
              ),
            );
          },
        ),
        bottomNavigationBar: const CustomBottomNavBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //Todo: Action to create post
          },
          backgroundColor: const Color(0xFF8B0000),
          child: const Icon(Icons.edit_note, color: Colors.white),
        ),
      ),
    );
  }
}
