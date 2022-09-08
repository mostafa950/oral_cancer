import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:ora_cancar/modules/onBoarding/onBoarding_screen.dart';
import 'package:ora_cancar/shared/component/component.dart';
import '../../shared/component/constance.dart';

class OpenedScreen extends StatelessWidget {
  const OpenedScreen({Key? key}) : super(key: key);
  void initState(BuildContext context) {
    Future.delayed(
      (Duration(
        seconds: 3,
      )),
          () {
        navigateToFinish(context, screen);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    initState(context);
    return SafeArea(
      child: Center(
        child: Container(
          color: Colors.black26,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundImage:
                    AssetImage("assets/images/final logo .png"),
                radius: 150,
              ),
              SizedBox(
                height: 50,
              ),
              LoadingBouncingGrid.circle(
                size: 40,
                borderSize: 5,
                borderColor: Colors.black,
                backgroundColor: Colors.amber,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
