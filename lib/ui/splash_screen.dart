import 'package:flutter/material.dart';

import '../utils/size_config.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: SizeConfig.blockSizeHorizontal * 48,
          width: SizeConfig.blockSizeHorizontal * 50,
          decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                  image: AssetImage('assets/images/png/logo.png'),
                  fit: BoxFit.fitWidth)),
        ),
      ),
    );
  }
}
