import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ora_cancar/layout/cubit/oral_cubit.dart';
import 'package:ora_cancar/modules/login/cubit/login_states.dart';
import 'package:ora_cancar/shared/component/constance.dart';
import 'package:ora_cancar/shared/network/local.dart';

import '../../../models/user_model/user_model.dart';


class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(InitialLoginState());
  static LoginCubit get(context) => BlocProvider.of(context);
  bool isSecure = true;
  IconData fallIcon = Icons.visibility_off;
  UserModel? userModel;
  void changePasswordVisibility() {
    isSecure = !isSecure;
    fallIcon = isSecure ? Icons.visibility_off : Icons.visibility;
    emit(ChangePasswordVisibilityLoginState());
  }

  void signInWithEmailAndPassword({
    required String? email,
    required String? password,
  }) {
    emit(OralLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: email!,
      password: password!,
    )
        .then((value) {
      print(value.user!.uid);
      emit(OralLoginSuccessState(value.user!.uid));
    }).catchError((error) {
      print("error founded in OralLoginState Mostafa ${error.toString()}");
      emit(OralLoginErrorState(error.toString()));
    });
  }

  Future<UserCredential> signInWithGoogle() async {
    emit(OralSignInWithGoogleLoadingState());
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) {
      createNewUser(
        email: value.user!.email,
        uId: value.user!.uid,
        phone: value.user!.phoneNumber,
        name: value.user!.displayName,
      );
      print(value.user!.displayName);
      emit(OralSignInWithGoogleSuccessState(value.user!.uid));
      return value;
    }).catchError((error) {
      emit(OralSignInWithGoogleErrorState());
    });
  }

  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .then((value) {
          emit(OralSignInWithFacebookSuccessState(value.user!.uid));
      return value;
    }).catchError((error) {
      emit(OralSignInWithGoogleErrorState());
    });
  }
}

void createNewUser({
  required String? email,
  required String? uId,
  String? phone,
  String? image,
  String? name,
  String? bio,
  String? status,
}) {
  UserModel model = UserModel(
    name: name,
    image:
        'https://www.pandasecurity.com/en/mediacenter/src/uploads/2013/11/pandasecurity-facebook-photo-privacy.jpg',
    email: email,
    phone: phone ?? '',
    bio: bio ?? '',
    status: status ?? null,
    uId: uId,
  );
  FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap());
}
