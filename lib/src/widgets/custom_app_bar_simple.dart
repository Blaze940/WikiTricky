import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBarSimple extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;

  const CustomAppBarSimple({
    Key? key,
    //if titleText is null, set default value to 'WikiTwiki'
    this.titleText = 'WikiTwiki',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF8B0000),
      elevation: 4,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
      title: Text(
        titleText,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
