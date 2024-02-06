import 'package:flutter/material.dart';
import 'package:wiki_tricky/src/widgets/custom_app_bar.dart';

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
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
            ],
          backgroundColor: const Color(0xFF8B0000),
          selectedItemColor: Colors.white,
        ),
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
