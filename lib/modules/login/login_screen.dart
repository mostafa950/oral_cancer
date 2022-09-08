import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ora_cancar/layout/app_layout.dart';
import 'package:ora_cancar/modules/home/home_screen.dart';
import 'package:ora_cancar/modules/login/cubit/login_cubit.dart';
import 'package:ora_cancar/modules/login/cubit/login_states.dart';
import 'package:ora_cancar/shared/network/local.dart';

import '../../layout/cubit/oral_cubit.dart';
import '../../shared/component/component.dart';
import '../../shared/component/constance.dart';
import '../../shared/styles/icons.dart';
import '../register/register_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is OralLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId);
            navigateToFinish(context, OralLayout());
            messageSuccess(context, 'login');
            /*if(OralCubit.get(context).userModel!.status == null )
              CacheHelper.saveData(key: 'isDoctor', value: false);*/
          } else if (state is OralLoginErrorState ||
              state is OralSignInWithGoogleErrorState ||
              state is OralSignInWithFacebookErrorState) {
            messageError(context , 'email or password invalid');
          } else if (state is OralSignInWithGoogleSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId);
            navigateToFinish(context, OralLayout());
            messageSuccess(context, 'login');
          } else if (state is OralSignInWithFacebookSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId);
            navigateToFinish(context, OralLayout());
            messageSuccess(context, 'login');
          }
        },
        builder: (context, state) {
          LoginCubit cubit = LoginCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                            color: Colors.white,
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: AssetImage(
                                'assets/images/final logo .png',
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Log In Now',
                              style: styleOrginalText,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              'Please login to continue using our app',
                              style: styleHintText,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: defaultTextFormedFailed(
                              hintText: 'Your email address',
                              controller: emailController,
                              prefixIcon: Icons.email,
                              type: TextInputType.emailAddress,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'This field is required';
                                } else
                                  return null;
                              },
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: defaultTextFormedFailed(
                              type: TextInputType.visiblePassword,
                              hintText: 'Enter your password',
                              controller: passwordController,
                              prefixIcon: IconBroken.Password,
                              isSecure: LoginCubit.get(context).isSecure,
                              sufPressed: () {
                                LoginCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              suffixIcon: LoginCubit.get(context).fallIcon,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'This field is required';
                                } else
                                  return null;
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              top: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Text(
                                    'Forget password ?',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: conditionalBuilder(
                              condition: state is! OralLoginLoadingState,
                              builder: Padding(
                                padding: EdgeInsetsDirectional.only(
                                  top: 20,
                                ),
                                child: Container(
                                  child: inputButton(
                                    text: 'Login',
                                    colorOfBox: colorDefault,
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.signInWithEmailAndPassword(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        );

                                      }
                                    },
                                    height: 50,
                                  ),
                                ),
                              ),
                              fallback: CircularProgressIndicator(
                                color: colorDefault,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              bottom: 8.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Don\'t have an account ? ',
                                  style: styleHintText,
                                ),
                                Container(
                                  child: textButton(
                                    onPressed: () {
                                      navigateToFinish(
                                          context, RegisterScreen());
                                    },
                                    text: 'Sign Up',
                                    fontSize: 12,
                                    color: colorDefault,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                              bottom: 10.0,
                            ),
                            child: Text(
                              'Or connect with',
                              style: styleHintText,
                            ),
                          ),
                          OutlinedButton(
                            onPressed: () {
                              cubit.signInWithGoogle();
                            },
                            style: ButtonStyle(
                            ),
                            child: Row(
                              children: [
                                Image(
                                  image: AssetImage(
                                    'assets/images/googleLogo.png',
                                  ),
                                  height: 30,
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                Text(
                                  'Sign in with Google',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          /*SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: inputButton2(
                              color: colorDefault,
                              text: 'Sign in with Google',
                              image: 'assets/images/googleLogo.png',
                              onTap: () {
                                cubit.signInWithGoogle();
                              },
                              height: 40,
                              colorOfText: Colors.white,
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
