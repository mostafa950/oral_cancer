import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ora_cancar/modules/register/cubit/register_state.dart';

import '../../../models/user_model/user_model.dart';
import '../../../shared/network/local.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(InitialRegisterState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool isSecure = true;
  IconData fallIcon = Icons.visibility_off;
  void changePasswordVisibility() {
    isSecure = !isSecure;
    fallIcon = isSecure ? Icons.visibility_off : Icons.visibility;
    emit(ChangePasswordVisibilityRegisterState());
  }

  void registerNewUser({
    required String? email,
    required String? password,
    String? name,
    String? phone,
    String? image,
  }) {
    emit(OralRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email!,
      password: password!,
    )
        .then((value) {
      createNewUser(
        email: email,
        password: password,
        uId: value.user!.uid,
        phone: phone,
        name: name,
      );
      print(value.user!.email);
      print(value.user!.uid);

      emit(OralRegisterSuccessState());
    }).catchError((error) {
      print('error founded in register state mostafa ${error.toString()}');
      emit(OralRegisterErrorState(error.toString()));
    });
  }

  void createNewUser({
    required String? email,
    required String? password,
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
      uId: uId,
      status: status ?? null,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(OralCreateUserSuccessState());
    }).catchError((error) {
      emit(OralCreateUserErrorState());
    });
  }
  String? value;
}
