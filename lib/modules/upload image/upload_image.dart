import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ora_cancar/layout/cubit/oral_cubit.dart';
import 'package:ora_cancar/layout/cubit/oral_states.dart';
import 'package:ora_cancar/shared/component/component.dart';
import 'package:ora_cancar/shared/component/constance.dart';
import 'package:ora_cancar/shared/styles/icons.dart';

import '../results/results_screen.dart';

class UploadImageScreen extends StatelessWidget {
  UploadImageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double? heightScreen = screenSize.height;
    double? widthScreen = screenSize.width;
    var image = OralCubit.get(context).pickedImage;
    return BlocConsumer<OralCubit, OralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text(
              'Upload image',
              style: GoogleFonts.pacifico(
                color: colorDefault,
              ),
            ),
            titleSpacing: 0.0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                IconBroken.Arrow___Left,
                color: colorDefault,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          showPicker(context);
                        },
                        child: CircleAvatar(
                          radius: widthScreen / 3.6,
                          backgroundColor: Colors.grey[300],
                          child: OralCubit.get(context).pickedImage != null
                              ? ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(widthScreen / 3),
                                  child: Image.file(
                                    OralCubit.get(context).pickedImage!,
                                    height: 200,
                                    width: 200,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(
                                      widthScreen / 3,
                                    ),
                                  ),
                                  width: 50,
                                  height: 50,
                                  child: Icon(
                                    IconBroken.Camera,
                                    color: Colors.grey[800],
                                  ),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Align(
                      alignment: AlignmentDirectional.topStart,
                      child: Text(
                        'To get results about your image following this steps : ',
                        style: GoogleFonts.adamina(
                          color: colorDefault,
                          fontWeight: FontWeight.w700,
                          fontSize: widthScreen / 28,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return steps(words[index], widthScreen, index);
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 5,
                                );
                              },
                              itemCount: words.length,
                            ),
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomCenter,
                            child: conditionalBuilder(
                              condition:
                                  state is! OralCreateNewResultLoadingState,
                              builder: Container(
                                child: inputButton(
                                  height: heightScreen / 20,
                                  onTap: () {
                                    if (OralCubit.get(context).pickedImage !=
                                        null && state is! OralCreateNewResultErrorState) {
                                      navigateTo(context, ResultsScreen(image));
                                      OralCubit.get(context).uploadImage(
                                        text: 'text',
                                        dateTime: dateTimeNow(),
                                      );
                                    } else {
                                      messageError(
                                          context, 'Please upload your photo');
                                    }
                                  },
                                  text: 'Upload',
                                  colorOfBox: colorDefault,
                                  width: widthScreen / 3,
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
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future showPicker(context) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          child: Wrap(
            children: [
              ListTile(
                onTap: () {
                  OralCubit.get(context).imageFormCamera();
                  Navigator.pop(context);
                },
                leading: Icon(IconBroken.Camera),
                title: Text('camera'),
              ),
              ListTile(
                onTap: () {
                  OralCubit.get(context).imageFormGallery();
                  Navigator.pop(context);
                },
                leading: Icon(Icons.browse_gallery_outlined),
                title: Text('photos library'),
              ),
            ],
          ),
        );
      },
    );
  }

  List<String> words = [
    'Click on camera to choose your image.',
    'Choose your image from gallery or take a photo by camera.',
    'Click on upload and you will move to page of analyzing.',
    'Once the analyzing complete you will move to page that appear your results.',
    'If you want to save this results and show it in home click on button save.',
  ];

  Widget steps(text, widthScreen, index) {
    return Text(
      '${index + 1}. $text',
      style: GoogleFonts.adamina(
        color: Colors.black,
        fontWeight: FontWeight.w700,
        fontSize: widthScreen / 30,
      ),
    );
  }
}
