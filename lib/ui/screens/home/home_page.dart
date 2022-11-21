import 'package:flutter/material.dart';
import 'package:habitoz_fitness_app/ui/Screens/gym/fitness_center_list/fitness_center_list_view.dart';
import 'package:habitoz_fitness_app/ui/screens/feed/feed_page_view.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/app_bar.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/drawer.dart';
import 'package:habitoz_fitness_app/utils/size_config.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: CustomDrawer(
        isGuest: false,
        userName: 'Ramdan Salim',
      ),
      appBar: CustomAppBar(
        drawerClicked: (){
          _scaffoldKey.currentState!.openDrawer();
        },
        appBarTitle: '',
        isHomeAppBar: true,
      ),
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
