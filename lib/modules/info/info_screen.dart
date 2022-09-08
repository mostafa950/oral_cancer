import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ora_cancar/layout/cubit/oral_cubit.dart';
import 'package:ora_cancar/layout/cubit/oral_states.dart';
import '../../shared/component/component.dart';
import '../../shared/component/constance.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OralCubit, OralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = OralCubit.get(context);
        var screenSize = MediaQuery.of(context).size;
        double? heightScreen = screenSize.height;
        double? widthScreen = screenSize.width;
        return OralCubit.get(context).advices!.length != 0
            ? Container(
                color: Colors.white,

                child: Column(
                  children: [
                    Container(
                      width: widthScreen,
                      height: heightScreen / 3,
                      child: Stack(
                        children: [
                          Align(
                              alignment: AlignmentDirectional.center,
                              child: imageBuilding(
                                  url: cubit.imageArticles,
                                  width: screenSize.width)),
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Text(
                              'Articles',
                              style: GoogleFonts.adamina(
                                color: Colors.brown,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return listOfAdvices(
                                OralCubit.get(context).adviceModel, index);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                            height: 0,
                          ),
                          itemCount: OralCubit.get(context).adviceModel!.length,
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

Widget listOfAdvices(advice, index) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.deepPurple[50],
          borderRadius: BorderRadius.circular(20),
        ),
        child: ExpansionTile(
          // expandedCrossAxisAlignment: CrossAxisAlignment.start,
          tilePadding: EdgeInsetsDirectional.all(2),
          childrenPadding: EdgeInsetsDirectional.all(2),
          iconColor: Colors.deepPurple,
          title: Text(
            // title
            '${advice[index].title} ?',
            style: GoogleFonts.adamina(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 13,
            ),
          ),
          children: [
            Align(
              alignment: AlignmentDirectional.topStart,
              child: Text(
                // text
                '${advice[index].text}',
                // textAlign: TextAlign.left,
                style: GoogleFonts.adamina(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
