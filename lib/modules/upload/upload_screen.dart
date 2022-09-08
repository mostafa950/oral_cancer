import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ora_cancar/layout/cubit/oral_states.dart';
import 'package:ora_cancar/shared/component/constance.dart';

import '../../layout/cubit/oral_cubit.dart';
import '../../shared/component/component.dart';
import '../upload image/upload_image.dart';

class UploadScreen extends StatelessWidget {
  UploadScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double? heightScreen = screenSize.height;
    double? widthScreen = screenSize.width;
    return BlocConsumer<OralCubit, OralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return OralCubit.get(context).userModel != null
            ? Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: widthScreen,
                      height: heightScreen / 3,
                      child: imageBuilding(
                        url: OralCubit.get(context).loadingImage,
                        width: widthScreen,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.check_circle,
                      color: Colors.grey,
                      size: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              'My dear ${OralCubit.get(context).userModel!.name!.split(' ')[0]} upload your image and check your results.',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Align(
                      alignment: AlignmentDirectional.center,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Container(
                          child: inputButton(
                            width: widthScreen / 2,
                            colorOfBox: colorDefault,
                            text: 'Start Uploading',
                            height: heightScreen / 20,
                            onTap: () {
                              OralCubit.get(context).pickedImage = null;
                              navigateTo(
                                context,
                                UploadImageScreen(),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(
                child: CircularProgressIndicator(
                color: colorDefault,
              ));
        ;
      },
    );
  }
}
