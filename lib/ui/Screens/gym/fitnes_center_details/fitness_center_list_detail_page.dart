import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/ui/Screens/gym/fitnes_center_details/components/gym_detail_container.dart';
import 'package:habitoz_fitness_app/ui/Screens/gym/fitnes_center_details/components/gym_image_container.dart';

class FitnessCenterListDetailPage extends StatefulWidget {
  final String gymName;

  const FitnessCenterListDetailPage({Key? key, required this.gymName})
      : super(key: key);

  @override
  State<FitnessCenterListDetailPage> createState() =>
      _FitnessCenterListDetailPageState();
}

class _FitnessCenterListDetailPageState
    extends State<FitnessCenterListDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GymImageContainer(),
            GymDetailContainer(gymName: widget.gymName)
          ],
        ),
      ),
    );
  }
}
