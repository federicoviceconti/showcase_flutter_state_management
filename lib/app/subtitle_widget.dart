import 'package:flutter/material.dart';

class SubtitleWidget extends StatelessWidget {
  const SubtitleWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Let's get something!",
      style: TextStyle(
        fontWeight: FontWeight.w200,
        fontSize: 18,
      ),
    );
  }
}
