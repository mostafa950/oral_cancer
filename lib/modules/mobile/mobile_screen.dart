import 'package:flutter/material.dart';
import 'package:ora_cancar/modules/adaptive/adapative_indicator.dart';
import 'package:ora_cancar/shared/component/constance.dart';

import '../../shared/component/component.dart';

class MobileScreen extends StatelessWidget {
  MobileScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.teal,
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              height: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Login now.. ',
                      style: Theme.of(context).textTheme.headline4,),
                    SizedBox(height: 10,),
                    Container(
                      child: defaultTextFormedFailed(
                        controller: emailController,
                        colorFocusedBorder: Colors.teal,
                        hintText: 'email',
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      child: defaultTextFormedFailed(
                        controller: passwordController,
                        colorFocusedBorder: Colors.teal,
                        hintText: 'Password',
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 40,
                            color: Colors.teal,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            height: 40,
                            color: Colors.blue,
                            child: MaterialButton(
                              onPressed: () {},
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Center(child: AdaptiveIndicator(os: getOS(),)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}