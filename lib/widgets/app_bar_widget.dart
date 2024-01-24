// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarFnc extends StatelessWidget {
  const AppBarFnc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("AppBar",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Builder(
        builder: (context) => IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 24,
            margin: const EdgeInsets.all(16),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color(0xffF7F7F7),
                borderRadius: BorderRadius.circular(8)),
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
            ),
          ),
        )
      ],
    );
  }
}
