import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ora_cancar/layout/cubit/oral_cubit.dart';
import 'package:ora_cancar/layout/cubit/oral_states.dart';

import '../../shared/component/component.dart';
import '../../shared/component/constance.dart';
import '../../shared/styles/icons.dart';
import '../login/cubit/login_cubit.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OralCubit, OralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var imageProfile = OralCubit.get(context).imageProfile;
        var cubit = OralCubit.get(context);
        var userModel = OralCubit.get(context).userModel;
        var screenSize = MediaQuery.of(context).size;
        double? heightScreen = screenSize.height;
        double? widthScreen = screenSize.width;

        bioController.text = userModel!.bio!;

        nameController.text = userModel.name!;

        phoneController.text = userModel.phone!;

        Color colorOfBorder = Colors.black26;

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            titleSpacing: 0.0,
            title: Text(
              'Edit Profile',
              style: GoogleFonts.pacifico(
                color: colorDefault,
              ),
            ),
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
                cubit.imageProfile = null;
              },
              child: Icon(
                IconBroken.Arrow___Left,
                color: colorDefault,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      height: heightScreen / 3.2,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            child: Container(
                              color: Colors.deepPurple[900],
                              height: heightScreen / 4,
                            ),
                            alignment: AlignmentDirectional.topStart,
                          ),
                          CircleAvatar(
                            radius: heightScreen / 10.3,
                            backgroundColor: Colors.white,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  radius: heightScreen / 11,
                                  backgroundImage: imageProfile == null
                                      ? NetworkImage(
                                          '${userModel.image}',
                                        )
                                      : FileImage(imageProfile)
                                          as ImageProvider,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      OralCubit.get(context).getImageProfile();
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: colorDefault,
                                      child: Icon(
                                        IconBroken.Camera,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (cubit.imageProfile != null)
                      state is! OralUploadImageProfileLoadingState
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if (cubit.imageProfile != null)
                                  inputButton(
                                    text: 'upload profile ',
                                    onTap: () {
                                      cubit.uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text,
                                      );
                                    },
                                    height: 40,
                                    colorOfBox: Colors.blue,
                                    width: widthScreen / 2,
                                  ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            )
                          : CircularProgressIndicator(
                              color: colorDefault,
                            ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: defaultTextFormedFailed(
                              type: TextInputType.text,
                              controller: nameController,
                              name: 'name',
                              prefixIcon: IconBroken.User,
                              colorOfBorder: colorOfBorder,
                              widthOfBorder: 1.0,
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
                              type: TextInputType.text,
                              controller: bioController,
                              name: 'bio',
                              prefixIcon: IconBroken.Info_Circle,
                              colorOfBorder: colorOfBorder,
                              widthOfBorder: 1.0,
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
                              type: TextInputType.text,
                              controller: phoneController,
                              name: 'phone',
                              prefixIcon: IconBroken.Call,
                              colorOfBorder: colorOfBorder,
                              widthOfBorder: 1.0,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'This field is required';
                                } else
                                  return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: conditionalBuilder(
                        condition: state is! OralUpdateUserDataLoadingState,
                        builder: Container(
                          child: inputButton(
                            text: 'Update',
                            colorOfBox: colorDefault,
                            width: widthScreen / 3,
                            height: 40,
                            colorOfIntgrateBox: Colors.purple[500],
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.updateUserData(
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  bio: bioController.text,
                                );
                              }
                            },
                          ),
                        ),
                        fallback: CircularProgressIndicator(
                          color: colorDefault,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
