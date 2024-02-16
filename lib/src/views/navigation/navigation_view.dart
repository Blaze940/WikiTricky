import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wiki_tricky/src/views/post/current_user_post_list_view.dart';
import 'package:wiki_tricky/src/widgets/create_post_widget.dart';
import 'package:wiki_tricky/src/widgets/custom_app_bar.dart';
import '../../blocs/auth_bloc/auth_bloc.dart';
import '../../blocs/posts_bloc/post_bloc.dart';
import '../../widgets/custom_bottom_nav_bar.dart';
import '../post/community_post_list_view.dart';

class NavigationView extends StatefulWidget {
  static const String routeName = '/';

  const NavigationView({Key? key}) : super(key: key);

  @override
  NavigationViewState createState() => NavigationViewState();
}

class NavigationViewState extends State<NavigationView> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = [
      CommunityPostListView(),
      BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state.status == AuthStatus.success) {
            return CurrentUserPostListView(user_id: state.user!.id);
          } else {
            return Center(child: Text("Please login to view this page."));
          }
        },
      ),
    ];

    void _onItemTapped(int index) {
      if (index == 1 && !(BlocProvider.of<AuthBloc>(context).state.status == AuthStatus.success)) {
        BlocProvider.of<PostBloc>(context, listen: false).add(GetItems());
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You need to be logged in to access the profile.")));
        return;
      }
      setState(() {
        _selectedIndex = index;
      });
    }

    return SafeArea(
      child: Scaffold(
        appBar: CustomAppBar(titleText: 'WikiTwiki'),
        body: IndexedStack(index: _selectedIndex, children: _widgetOptions),
        bottomNavigationBar: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return CustomBottomNavBar(
              currentIndex: _selectedIndex,
              onItemSelected: _onItemTapped,
              isProfileEnabled: state.status == AuthStatus.success, // Active ou désactive l'onglet Profile basé sur l'état d'authentification
            );
          },
        ),
        floatingActionButton: CreatePostWidget(),
      ),
    );
  }
}
