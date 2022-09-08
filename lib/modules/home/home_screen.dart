import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:ora_cancar/layout/cubit/oral_cubit.dart';
import 'package:ora_cancar/layout/cubit/oral_states.dart';
import 'package:ora_cancar/models/upload_model/upload_model.dart';
import 'package:ora_cancar/shared/component/constance.dart';
import 'package:ora_cancar/shared/styles/icons.dart';

import '../../shared/component/component.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print("images length in home screen is ${OralCubit.get(context).images!.length}");
    var screenSize = MediaQuery.of(context).size;
    double? heightScreen = screenSize.height;
    double? widthScreen = screenSize.width;
    return BlocConsumer<OralCubit, OralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return OralCubit.get(context).userModel != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: widthScreen,
                    height: heightScreen / 3,
                    child: OralCubit.get(context).imagesCovers != null
                        ? CarouselSlider(
                            items: OralCubit.get(context)
                                .imagesCovers!
                                .map(
                                  (e) => imageBuilding(
                                    url: e,
                                    width: screenSize.width,
                                  ),
                                )
                                .toList(),
                            options: CarouselOptions(
                                height: 250,
                                autoPlay: true,
                                viewportFraction: 1,
                                scrollDirection: Axis.horizontal,
                                enableInfiniteScroll: true,
                                initialPage: 0,
                                autoPlayAnimationDuration: Duration(seconds: 3),
                                autoPlayCurve: Curves.easeInOutQuart,
                                clipBehavior: Clip.antiAliasWithSaveLayer),
                          )
                        : Center(
                            child: CircularProgressIndicator(
                            color: colorDefault,
                          )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, bottom: 4),
                    child: Text(
                      'Your Results :',
                      style: GoogleFonts.pacifico(
                        color: colorDefault,
                      ),
                    ),
                  ),
                  if (OralCubit.get(context).resultModel!.length == 0)
                    Container(
                      child: noDataFounded(
                        widthScreen,
                        heightScreen,
                        context,
                      ),
                    ),
                  if (OralCubit.get(context).resultModel!.length != 0)
                    Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return buildItems(
                            widthScreen,
                            context,
                            OralCubit.get(context).resultModel![index],
                          );
                        },
                        itemCount: OralCubit.get(context).resultModel!.length,
                      ),
                    ),
                ],
              )
            : Center(
                child: CircularProgressIndicator(
                color: colorDefault,
              ));
      },
    );
  }
}

Widget noDataFounded(width, height, context) {
  return Expanded(
    child: Padding(
      padding:
          EdgeInsets.symmetric(vertical: height / 6, horizontal: width / 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.grey,
            size: 40,
          ),
          Text(
            'No data founded...!!',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildItems(widthScreen, context, ResultModel resultModel) {
  return Container(
    padding: EdgeInsets.all(0),
    height: 100,
    child: Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 8,
      color: Colors.white,
      shadowColor: Colors.deepOrange[300],
      margin: EdgeInsetsDirectional.all(8),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 100,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(
                3,
              ),
            ),
            child: Image(
              image: NetworkImage(
                '${resultModel.resultImage}',
              ),
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: AlignmentDirectional.topStart,
                    child: Container(
                        width: widthScreen / 1.61,
                        margin: EdgeInsetsDirectional.all(3),
                        child: Text(
                          'My dear ${OralCubit.get(context).userModel!.name!.split(' ')[0]} '
                          'you suffer from ....... , and your result is ${resultModel.text}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 25, bottom: 10),
                    child: InkWell(
                      onTap: () {
                        OralCubit.get(context)
                            .removeResults(resultModel.idOfPost);
                      },
                      radius: 40,
                      child: Icon(
                        IconBroken.Delete,
                        color: Colors.red,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Text(
                  /// resultModel.dateTime
                  '${resultModel.dateTime}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
