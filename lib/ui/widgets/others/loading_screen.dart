import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/color_loader.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Center(
            child: ColorLoader5(),
          ),
        ),
      ),
    );
  }
}
