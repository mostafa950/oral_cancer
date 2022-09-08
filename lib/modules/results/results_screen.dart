import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ora_cancar/layout/cubit/oral_cubit.dart';
import 'package:ora_cancar/layout/cubit/oral_states.dart';
import 'package:ora_cancar/modules/home/home_screen.dart';

import '../../shared/component/component.dart';
import '../../shared/component/constance.dart';
import '../../shared/styles/icons.dart';

class ResultsScreen extends StatelessWidget {
  final image;
  ResultsScreen(this.image);
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double? heightScreen = screenSize.height;
    double? widthScreen = screenSize.width;
    return BlocConsumer<OralCubit, OralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0.0,
            title: Text(
              'Results',
              style: GoogleFonts.pacifico(
                color: colorDefault,
              ),
            ),
            elevation: 0.0,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
                OralCubit.get(context).pickedImage = null ;
              },
              child: Icon(
                IconBroken.Arrow___Left,
                color: colorDefault,
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  width: widthScreen,
                  height: heightScreen / 3,
                  child: imageBuilding(
                    url:
                        'https://img.freepik.com/free-photo/results-analysis-discovery-investigation-concept_53876-120447.jpg?t=st=1656933334~exp=1656933934~hmac=99ea027f3bc9cba2c7aecd023efa462f9b7af5407683dbe3cb4ccec0af52a7c1&w=900',
                    width: widthScreen,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: AlignmentDirectional.topStart,
                  child: Text(
                    'Your Results : ',
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
                Text(
                  'You suffer from cancer and your results are ',
                  style: GoogleFonts.adamina(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: widthScreen / 28,
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsetsDirectional.only(
                    bottom: 20.0,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: Container(
                      child: inputButton(
                        height: heightScreen / 20,
                        onTap: () {
                          OralCubit.get(context).getResults();
                          OralCubit.get(context).pickedImage = null;
                        },
                        text: 'Save',
                        colorOfBox: colorDefault,
                        width: widthScreen / 3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
