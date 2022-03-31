import 'package:rive/rive.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key, animationName="Animation 1"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Loading"),),
      body: Center(
              child: const RiveAnimation.asset(
              'assets/rive/cube.riv',
                fit: BoxFit.contain,
        ),
      ),
    );
  }
}
