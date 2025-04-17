import 'package:blablacar/Bottom_Navigationbar/bottom_scr.dart';
import 'package:flutter/material.dart';

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BottomScr(),
    );
  }
}
