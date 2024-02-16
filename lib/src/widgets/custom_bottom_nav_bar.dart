import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:wiki_tricky/src/services/toast_service.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onItemSelected;
  final bool isProfileEnabled;

  const CustomBottomNavBar({
    Key? key,
    required this.currentIndex,
    required this.onItemSelected,
    this.isProfileEnabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 0,
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomAppBar(
          color: const Color(0xFF8B0000),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              if (index == 1 && !isProfileEnabled) {
                // Si l'onglet Profile est sélectionné et désactivé, ne faites rien (ou affichez un message)
                showCustomToast(context, type: ToastificationType.warning, title: "No access", description: "You need to be logged first to access the Profile tab.");
                return;
              }
              onItemSelected(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home, size: 20), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.person, size: 20), label: 'Profile'),
            ],
            backgroundColor: Colors.transparent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
          ),
        ),
      ),
    );
  }
}
