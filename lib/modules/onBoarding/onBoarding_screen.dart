import 'package:flutter/material.dart';
import 'package:ora_cancar/models/onBoard_Model/on_board_model.dart';
import 'package:ora_cancar/modules/home/home_screen.dart';
import 'package:ora_cancar/modules/login/login_screen.dart';
import 'package:ora_cancar/modules/welcome/welcome_screen.dart';
import 'package:ora_cancar/shared/component/component.dart';
import 'package:ora_cancar/shared/component/constance.dart';
import 'package:ora_cancar/shared/network/local.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardModel> boarding = [
    OnBoardModel(
      image: 'assets/images/splash screen 1.png',
      body: 'Oral cancer, also known as mouth cancer, is cancer of the lining of the lips, mouth, or upper throat. In the mouth, it most commonly starts as a painless white patch, that thickens, develops red patches, an ulcer, and continues to grow.',
      title: 'Oral cancer definition',
    ),
    OnBoardModel(
      image: 'assets/images/splash screen 2.PNG',
      body: 'The application offers a unique feature for you, which is the examination feature that is powered by artificial intelligence. All you have to do is take a picture of your mouth and upload the image to the application, and the application will display the result and tell you if there is cancer or not.',
      title: 'Scan your oral',
    ),
    OnBoardModel(
      image: 'assets/images/splash screen 3.PNG',
      body: 'You can also see some medical advice that will help you to know more information about this disease and some prevention tips, and you will find most of what is on your mind in these tips',
      title: 'Tips for you',
    ),
  ];
  bool isLast = false;
  void submit() {
      CacheHelper.saveData(key: 'OnBoarding', value: true).then((value) {
        if (value)
          navigateToFinish(context, WelcomeScreen());
      });
  }
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: groundColor,
      appBar: AppBar(
        backgroundColor: groundColor,
        elevation: 0.0,
        actions: [
          textButton(
            text: 'SKIP',
            fontSize: 15,
            color: colorDefault,
            onPressed: () {
              submit();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return onItemBoard(boarding[index]);
                },
                controller: controller,
                physics: BouncingScrollPhysics(),
                itemCount: boarding.length,
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    isLast = false;
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20,),
              child: Row(
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: boarding.length,
                    effect: WormEffect(
                      type: WormType.thin,
                      dotHeight: 15,
                      dotWidth: 15,
                      activeDotColor: colorDefault,
                    ),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast){
                        submit();
                      }
                      else {
                        controller.nextPage(duration: Duration(milliseconds: 750,), curve: Curves.fastLinearToSlowEaseIn,);
                      }
                    },
                    backgroundColor: colorDefault,
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
