import 'package:flutter/material.dart';

import 'package:habitoz_fitness_app/ui/Screens/home/home_page.dart';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'package:provider/provider.dart';
import 'bloc/authentication_bloc/authentication_bloc.dart';
import 'repositories/user_repo.dart';
import 'ui/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
/*
  final UserRepository userRepository = UserRepository();
*/

  runApp(
    const App(),
    /* MultiBlocProvider(
      providers: [
       */ /* BlocProvider(
            create: (context) =>
            AuthenticationBloc(userRepository: userRepository)
              ..add(AuthenticationStarted())),*/ /*
      ],
      child: App(
        userRepository: userRepository,
      ),
    ),*/
  );
}

class App extends StatelessWidget {
/*
  final UserRepository _userRepository;
*/

  const App({
    Key? key,
  }) : super(key: key) /*_userRepository = userRepository*/;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Constants.appTitle,
      theme: ThemeData(
        primaryColor: const Color(0xff05BC7F),
        appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(color: Colors.white),
            textTheme: TextTheme(headline6: TextStyle(color: Colors.white)),
            titleTextStyle: TextStyle(
                color: Color(0xffFFFFFF),
                fontWeight: FontWeight.w700,
                fontSize: 16)),
        secondaryHeaderColor: Colors.black,
        dividerColor: const Color(0xff707070),
        fontFamily: "Barlow",
        inputDecorationTheme: const InputDecorationTheme(),
        disabledColor: const Color(0xffF2F2F2),
        backgroundColor: const Color(0xffFFFFFF),
        buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.normal, buttonColor: Color(0xffFFFFFF)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomePage(),
    );
  }
}
/*home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        buildWhen: (previous, current) => (previous != current),
        builder: (context, state) {
          if (state is AuthenticationSuccess) {
          }
          if (state is AuthenticationNewUserOnBoarding) {

          }
          if (state is AuthenticationSkipped) {

          }
          if (state is UnAuthenticated) {

          }
          if (state is AuthenticationFailure) {

          }
          if (state is AuthenticationRetrying) {

          }
          return const SplashScreen();
        },
      ),
    );
  }
}*/
