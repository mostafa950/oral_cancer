import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ora_cancar/modules/login/login_screen.dart';
import 'package:ora_cancar/shared/component/component.dart';
import 'package:ora_cancar/shared/component/constance.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SizedBox(
        height: 700,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 250,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                        topStart: Radius.circular(
                          4.0,
                        ),
                        topEnd: Radius.circular(
                          4.0,
                        ),
                      ),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/6333054.jpg',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                'Welcome',
                style: styleOrginalText,
              ),
              Center(
                child: Text(
                  'create an account and enjoy with our features',
                  style: styleHintText,
                ),
              ),
              Spacer(),
              Container(
                child: inputButton(
                  text: 'Getting Started',
                  colorOfBox: colorDefault,
                  onTap: () {
                    navigateToFinish(context, LoginScreen());
                  },
                  height: 50,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ?',
                    style: styleHintText,
                  ),
                  SizedBox(
                    width: 0.0,
                  ),
                  Container(
                    child: textButton(
                      color: colorDefault,
                      text: 'login',
                      onPressed: () {
                        navigateToFinish(context, LoginScreen());
                      },
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
