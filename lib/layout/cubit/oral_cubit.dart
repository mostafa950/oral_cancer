import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ora_cancar/layout/cubit/oral_states.dart';
import 'package:ora_cancar/models/advice_model/advice_model.dart';
import 'package:ora_cancar/models/upload_model/upload_model.dart';
import 'package:ora_cancar/modules/chat/chat_screen.dart';
import 'package:ora_cancar/modules/home/home_screen.dart';
import 'package:ora_cancar/modules/info/info_screen.dart';
import 'package:ora_cancar/modules/upload/upload_screen.dart';
import 'package:ora_cancar/shared/component/constance.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../models/user_model/user_model.dart';
import '../../modules/settings/settings_screen.dart';

class OralCubit extends Cubit<OralStates> {
  OralCubit() : super(InitialStates());

  static OralCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;
  bool? isDoctor = false;
  void getUserData() {
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.fromJson(value.data());
      isDoctor = userModel!.status == null ? false : true;
      print(value.data());
      emit(OralGetUserDataSuccessStates());
    }).catchError((error) {
      emit(OralGetUserDataErrorStates());
    });
  }

  List<String>? titles = [
    'Home',
    'Upload',
    'Articles',
    'Settings',
  ];

  List<Widget>? screens = [
    HomeScreen(),
    UploadScreen(),
    InfoScreen(),
    SettingsScreen(),
  ];

  int currentIndex = 0;
  String loadingImage =
      'https://img.freepik.com/free-vector/loading-concept-illustration_114360-1057.jpg?t=st=1655917553~exp=1655918153~hmac=b647df6d7eb618f7a4d653d5417fa78f7931de4ed20dbed403d332662ed2b289&w=996';
  void changeBottomNav(int index) {
    if (index == 0) {
      currentIndex = index;
      emit(OralChangeBottomNavStates());
      getImages();
    }
    if (index == 2 ){
      currentIndex = index;
      emit(OralChangeBottomNavStates());
      getAdvices();
    }
      else {
      currentIndex = index;
      emit(OralChangeBottomNavStates());
    }
  }

  bool iconAdvices = false;
  void changeIconAdvices() {
    iconAdvices = !iconAdvices;
    emit(OralChangeIconAdvicesStates());
  }

  List<String>? imagesCovers;
  void getImages() {
    emit(OralGetImagesLoadingStates());
    FirebaseFirestore.instance
        .collection('photos ')
        .doc('1')
        .get()
        .then((value) {
      imagesCovers = [];
      for (int i = 0; i < value.data()!['images']!.hashCode.bitLength; i++) {
        imagesCovers!.add(value.data()!['images'][i]);
      }
      emit(OralGetImagesSuccessStates());
      print(imagesCovers!.length);
      print(value.data()!['images']);
    }).catchError((error) {
      emit(OralGetImagesErrorStates());
    });
  }

  String imageArticles =
      'https://img.freepik.com/free-vector/reading-news-concept_118813-3240.jpg?w=1060';

  Map<String, dynamic>? advices = {};
  List<AdviceModel>? adviceModel;
  void getAdvices() {
    emit(OralGetAdvicesLoadingStates());
    FirebaseFirestore.instance
        .collection('advices')
        .doc('1')
        .get()
        .then((value) {
      advices = {};
      adviceModel = [];
      for (int i = 0; i < value.data()!['adviceMap']!.hashCode.bitLength; i++) {
        advices!.addAll(value.data()!["adviceMap"]);
      }
      advices!.forEach((key, value) {
        adviceModel!.add(AdviceModel(key, value));
      });

      // advices!.keys.forEach((k) => title!.add(k));
      print("adviceModel!.length is : ${adviceModel!.length}");
      print("adviceModel!.length is : ${adviceModel![1].title}");
      emit(OralGetAdvicesSuccessStates());
      /*print("advices are ${advices!}}");
      print("advices length are  ${advices!.length}");*/
    }).catchError((error) {
      emit(OralGetAdvicesErrorStates());
    });
  }

  File? pickedImage;
  var picker = ImagePicker();
  Future imageFormGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      emit(OralImagePickedSuccessState());
    } else {
      print('no photos selected.');
      emit(OralImagePickedErrorState());
    }
  }

  Future imageFormCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedFile != null) {
      pickedImage = File(pickedFile.path);
      emit(OralImagePickedSuccessState());
    } else {
      print('no photos selected.');
      emit(OralImagePickedErrorState());
    }
  }

  void uploadImage({
    @required String? text,
    @required String? dateTime,
  }) {
    emit(OralUploadLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('results/ ${Uri.file(pickedImage!.path).pathSegments.last}')
        .putFile(pickedImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createNewResults(
          dateTime: dateTime,
          text: text,
          resultImage: value,
        );
        print(value);
        emit(OralUploadSuccessState());
      }).catchError((error) {
        emit(OralCreateNewResultErrorState());
      });
    }).catchError((error) {
      emit(OralCreateNewResultErrorState());
    });
  }

  void createNewResults({
    @required String? dateTime,
    @required String? text,
    String? resultImage,
  }) {
    emit(OralCreateNewResultLoadingState());
    ResultModel model = ResultModel(
      name: userModel!.name,
      uId: userModel!.uId,
      text: text,
      dateTime: dateTime,
      resultImage: resultImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('results')
        .add(model.toMap())
        .then((value) {
      print("id id id id id ${value.id}");
      emit(OralCreateNewResultSuccessState());
    }).catchError((error) {
      emit(OralCreateNewResultErrorState());
    });
  }

  List<ResultModel>? resultModel = [];
  void getResults() {
    emit(OralGetResultsLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('results')
        .orderBy('dateTime')
        .snapshots()
        .listen((event) {
      resultModel = [];
      event.docs.forEach((element) {
        print("id ${element.id}");
        resultModel!.add(ResultModel.fromJson(element.data(), element.id));
        emit(OralGetResultsSuccessState());
      });
    });
  }

  void removeResults(id) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('results')
        .doc(id)
        .delete()
        .then((value) {
          getResults();
      emit(OralDeleteResultsSuccessState());
    }).catchError((error) {
      emit(OralDeleteResultsErrorState());
    });
  }

  File? imageProfile;
  var pickerProfile = ImagePicker();
  Future getImageProfile() async {
    final pickedFile = await pickerProfile.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageProfile = File(pickedFile.path);
      emit(OralImageProfilePickedSuccessState());
    } else {
      print('no photos selected.');
      emit(OralImageProfilePickedErrorState());
    }
  }

  void uploadProfileImage({
    @required String? name,
    @required String? phone,
    @required String? bio,
  }) {
    emit(OralUploadImageProfileLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/ ${Uri.file(imageProfile!.path).pathSegments.last}')
        .putFile(imageProfile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUserData(name: name, phone: phone, bio: bio, profile: value);
        print(value);
        emit(OralUploadImageProfileSuccessState());
      }).catchError((error) {
        emit(OralUploadImageProfileErrorState());
      });
    }).catchError((error) {
      emit(OralUploadImageProfileErrorState());
    });
  }
  void updateUserData({
    @required String? name,
    @required String? phone,
    @required String? bio,
    var profile,
    String? cover,
  }) {
    emit(OralUpdateUserDataLoadingState());
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      image: profile ?? userModel!.image,
      email: userModel!.email,
      uId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
      emit(OralUpdateUserDataSuccessState());
    }).catchError((error) {
      emit(OralUpdateUserDataErrorState());
    });
  }
}
