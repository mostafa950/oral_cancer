import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ora_cancar/modules/login/login_screen.dart';
import '../../shared/component/component.dart';
import '../../shared/component/constance.dart';
import '../../shared/styles/icons.dart';
import 'cubit/register_cubit.dart';
import 'cubit/register_state.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var emailController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  String? value;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is OralCreateUserSuccessState) {
            messageSuccess(context, 'Register Success');
            // navigateToFinish(context, OralLayout());
          }
          if (state is OralRegisterErrorState) {
            messageError(context, state.error);
          }
        },
        builder: (context, state) {
          RegisterCubit cubit = RegisterCubit.get(context);
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
                              'Register In Now',
                              style: styleOrginalText,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Center(
                            child: Text(
                              'Please fill the details to create account',
                              style: styleHintText,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            child: defaultTextFormedFailed(
                              hintText: 'Enter your name',
                              controller: nameController,
                              prefixIcon: IconBroken.User,
                              type: TextInputType.text,
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
                              hintText: 'Enter your phone',
                              controller: phoneController,
                              prefixIcon: IconBroken.Call,
                              type: TextInputType.phone,
                              validate: (String? value) {
                                if (phoneController.text.length < 11) {
                                  return 'phone must be at least 11 number  ';
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
                              isSecure: RegisterCubit.get(context).isSecure,
                              sufPressed: () {
                                RegisterCubit.get(context)
                                    .changePasswordVisibility();
                              },
                              suffixIcon: RegisterCubit.get(context).fallIcon,
                              validate: (String? value) {
                                if (passwordController.text.length < 8) {
                                  return 'password very weak';
                                } else
                                  return null;
                              },
                            ),
                          ),
                          Container(
                            child: conditionalBuilder(
                              condition: state is! OralRegisterLoadingState,
                              builder: Padding(
                                padding: EdgeInsetsDirectional.only(
                                  top: 30,
                                ),
                                child: Container(
                                  child: inputButton(
                                    text: 'Register',
                                    colorOfBox: colorDefault,
                                    onTap: () {
                                      if (_formKey.currentState!.validate()) {
                                        cubit.registerNewUser(
                                          email: emailController.text,
                                          password: passwordController.text,
                                          name: nameController.text,
                                          phone: phoneController.text,
                                        );
                                      }
                                    },
                                    height: 50,
                                  ),
                                ),
                              ),
                              fallback: Padding(
                                padding: EdgeInsetsDirectional.only(
                                  top: 30,
                                ),
                                child: CircularProgressIndicator(
                                  color: colorDefault,
                                ),
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
                                  'Already have an account ? ',
                                  style: styleHintText,
                                ),
                                Container(
                                  child: textButton(
                                    onPressed: () {
                                      navigateToFinish(context, LoginScreen());
                                    },
                                    text: 'Sign in',
                                    fontSize: 12,
                                    color: colorDefault,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
