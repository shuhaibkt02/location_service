import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: Colors.orange.shade900,
          child:
              const Center(child: Icon(Icons.flutter_dash_outlined, size: 85))),
    );
  }
}
