import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habitoz_fitness_app/ui/screens/home/home_screen.dart';
import 'package:habitoz_fitness_app/ui/widgets/others/loading_screen.dart';
import 'package:habitoz_fitness_app/utils/constants.dart';
import 'bloc/authentication_bloc/authentication_bloc.dart';
import 'repositories/user_repo.dart';
import 'ui/screens/auth/login/login_screen.dart';
import 'ui/screens/bmi/fill_profile.dart';
import 'ui/screens/bmi/result_display.dart';
import 'ui/splash_screen.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  final UserRepository userRepository = UserRepository();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
            AuthenticationBloc(userRepository: userRepository)
              ..add(AuthenticationStarted())),
      ],
      child: App(
        userRepository: userRepository,
      ),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  const App({super.key, required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
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
        fontFamily: "Inter",
        inputDecorationTheme: const InputDecorationTheme(),
        disabledColor: const Color(0xffF2F2F2),
        backgroundColor: const Color(0xffFFFFFF),
        buttonTheme: const ButtonThemeData(
            textTheme: ButtonTextTheme.normal,
            buttonColor: Color(0xffFFFFFF)),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/fillProfile': (context) => const FillProfileDetails(),
      },
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        buildWhen: (previous, current) => (previous != current),
        builder: (context, state) {
          if (state is AuthenticationSuccess) {
            // go to home screen
            return const HomeScreen();
          }
          if (state is AuthenticationFailure) {
            // logged out user - redirect to login page
            return LoginScreen(
              userRepository: _userRepository,
              message: state.message,
            );
          }
          if (state is AuthenticationGuest) {
            // guest user - redirect to home screen as guest
            return const HomeScreen();
          }
          if (state is AuthenticationCompleteProfile) {
            // complete profile page
            return const FillProfileDetails();
          }
          if (state is AuthenticationShowResult) {
            // complete profile page
            return ResultView(
              fitnessResponse: state.result,
              resultType: 'BMI',
            );
          }
          if (state is AuthenticationOnLoading) {
            return const LoadingWidget();
          }
          if (state is AuthenticationLoadSplashScreen) {
            return const SplashScreen();
          }
          return const SplashScreen();
        },
      ),
    );
  }
}
