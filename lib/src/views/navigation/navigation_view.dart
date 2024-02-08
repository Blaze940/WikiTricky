import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_tricky/src/blocs/posts_bloc/post_bloc.dart';
import 'package:wiki_tricky/src/widgets/custom_app_bar.dart';
import 'package:wiki_tricky/src/widgets/custom_nav_bar.dart';

class NavigationView extends StatefulWidget {
  static const String routeName = '/home';

  const NavigationView({Key? key}) : super(key: key);

  @override
  _NavigationViewState createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView> {
  @override
  void initState() {
    super.initState();
    // Charger les posts initiaux dès le lancement
    BlocProvider.of<PostBloc>(context, listen: false).add(GetItems());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          titleText: 'WikiTwiki',
        ),
        body: BlocBuilder<PostBloc, PostState>(
          builder: (context, state) {
            final items = state.items;
            final isLoadingNextPage = state.status == PostStatus.loading && items.isNotEmpty;

            return ListView.builder(
              itemCount: items.length + (state.currentPost?.nextPage != null ? 1 : 0),
              itemBuilder: (context, index) {
                if (index < items.length) {
                  final item = items[index];
                  return Card(
                    margin: const EdgeInsets.all(8),
                    child: ListTile(
                      title: Text(item.content, style: TextStyle(color: Colors.black)),
                      subtitle: Text('Item ID: ${item.id}'),
                      trailing: const Icon(Icons.favorite_border, color: Color(0xFF8B0000)),
                    ),
                  );
                } else {
                  return isLoadingNextPage
                      ? Center(child: CircularProgressIndicator())
                      : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () => BlocProvider.of<PostBloc>(context).add(GetNextItems(state.currentPost!.nextPage!)),
                        child: Text('Charger items suivants'),
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
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
