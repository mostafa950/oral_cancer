import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
Widget? screen;

Color? groundColor = Colors.white;

Color colorDefault = Colors.deepOrange;

String? uId ;

var styleHintText = TextStyle(
  color: Colors.grey,
  fontSize: 12,
);

var styleOrginalText = GoogleFonts.adamina(
  fontSize: 20,
  color: Colors.deepOrange,
  fontWeight: FontWeight.bold,
);


Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

String getOS(){
  return Platform.operatingSystem.toString();
}

//bool? isDoctor;