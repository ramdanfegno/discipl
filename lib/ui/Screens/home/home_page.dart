import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/ui/Screens/gym/fitness_center_list/fitness_center_list_view.dart';
import 'package:habitoz_fitness_app/ui/screens/feed/feed_page_view.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FitnessCenterListView()));
                },
                child: Container(
                  height: SizeConfig.blockSizeHorizontal * 13,
                  width: SizeConfig.blockSizeHorizontal * 35,
                  color: Colors.red,
                  child: const Center(child: Text('Gym List Page')),
                ),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 4,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FeedListViewPage()));
                },
                child: Container(
                  height: SizeConfig.blockSizeHorizontal * 13,
                  width: SizeConfig.blockSizeHorizontal * 35,
                  color: Colors.red,
                  child: const Center(child: Text('Feed Page')),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
