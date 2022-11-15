import 'package:flutter/material.dart';

class GymDetailContainer extends StatelessWidget {
  final String gymName;

  const GymDetailContainer({Key? key, required this.gymName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Text(gymName),
        ],
      ),
    );
  }
}
