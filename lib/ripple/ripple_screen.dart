import 'package:awesome_ripple_animation/awesome_ripple_animation.dart';
import 'package:flutter/material.dart';

class RippleScreen extends StatelessWidget {
  const RippleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          RippleAnimation(
            size: const Size(150, 150),
            repeat: true,
            color: Colors.blue,
            minRadius: 90,
            ripplesCount: 6,
            child: Container(),
          )
        ],
      ),
    );
  }
}
