import 'package:flutter/material.dart';
import 'package:ora_cancar/shared/component/component.dart';

class DesktopScreen extends StatelessWidget {
  DesktopScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Container(
              height: double.infinity,
              color: Colors.teal,
            ),
          ),
          Expanded(
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
