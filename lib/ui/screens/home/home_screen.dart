import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/ui/screens/bmi/profile_screen.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ProfileScreen();
                  }));
                },
                child: Container(
                  width: 150,
                  height: 40,
                  color: Colors.red,
                  alignment: Alignment.center,
                  child: const Text(
                      'Profile'
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
