import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:ora_cancar/layout/app_layout.dart';
import 'package:ora_cancar/layout/cubit/oral_cubit.dart';
import 'package:ora_cancar/layout/cubit/oral_states.dart';
import 'package:ora_cancar/modules/battery/get_battery.dart';
import 'package:ora_cancar/modules/desktop/desktop_screen.dart';
import 'package:ora_cancar/modules/home/home_screen.dart';
import 'package:ora_cancar/modules/login/cubit/login_cubit.dart';
import 'package:ora_cancar/modules/login/cubit/login_states.dart';
import 'package:ora_cancar/modules/mobile/mobile_screen.dart';
import 'package:ora_cancar/modules/onBoarding/onBoarding_screen.dart';
import 'package:ora_cancar/modules/opened/opened_screen.dart';
import 'package:ora_cancar/modules/register/cubit/register_cubit.dart';
import 'package:ora_cancar/modules/welcome/welcome_screen.dart';
import 'package:ora_cancar/shared/component/constance.dart';
import 'package:ora_cancar/shared/network/local.dart';
import 'package:ora_cancar/shared/styles/bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  await CacheHelper.initial();
  await Firebase.initializeApp();
  bool? onBoard = CacheHelper.getData(key: 'OnBoarding');
  uId = CacheHelper.getData(key: 'uId');
  //isDoctor = CacheHelper.getData(key: 'isDoctor');
  Bloc.observer = MyBlocObserver();
  if (onBoard != null && uId == null) {
    screen = WelcomeScreen();
  } else if (onBoard != null && uId != null) {
    screen = OralLayout();
  } else if (onBoard == null) {
    screen = OnBoardingScreen();
  }
  print(screen!.toString());
  print('uId is $uId');
  print(getOS());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
/*
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OralCubit()..getImages()..getUserData()..getAdvices()..getResults(),
        ),
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
      ],
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Oral Cancer',
            home: OpenedScreen(),
          );
        },
      ),
    );
*/
    return MaterialApp(
      title: 'Oral Cancer',
/*      home: LayoutBuilder(
        builder: (BuildContext, BoxConstraints) {
          print(BoxConstraints.minWidth.toInt());
          if (BoxConstraints.minWidth.toInt() < 560) {
            return MobileScreen();
          } else {
            return DesktopScreen();
          }
        },
      ),*/
      home: Builder(
        builder: (BuildContext context) {
          MediaQuery.of(context).size.width;
          if (MediaQuery.of(context).size.width.toInt() < 560) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 0.75,
              ),
              child: MobileScreen(),
            );
          } else {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: 1.25,
              ),
              child: DesktopScreen(),
            );
          }
        },
      ),
    );
  }
}
