import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ora_cancar/layout/cubit/oral_cubit.dart';
import 'package:ora_cancar/layout/cubit/oral_states.dart';
import 'package:ora_cancar/modules/edit%20profile/edit_profile.dart';
import 'package:ora_cancar/modules/login/login_screen.dart';
import 'package:ora_cancar/shared/component/component.dart';
import 'package:ora_cancar/shared/component/constance.dart';
import 'package:ora_cancar/shared/network/local.dart';
import 'package:ora_cancar/shared/styles/icons.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    double? heightScreen = screenSize.height;
    double? widthScreen = screenSize.width;
    var cubit = OralCubit.get(context);
    return BlocConsumer<OralCubit, OralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        List<String> titles = [
          'Home',
          'Share ',
          'Sign Out',
        ];
        return OralCubit.get(context).userModel != null
            ? Container(
                color: Colors.grey[200],
                child: Column(
                  children: [
                    Container(
                      height: heightScreen / 3,
                      width: widthScreen,
                      color: Colors.orange,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Settings',
                              style: GoogleFonts.pacifico(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: 20,
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      '${cubit.userModel!.image}',
                                    ),
                                    radius: heightScreen / 19,
                                  ),
                                  SizedBox(
                                    width: widthScreen / 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Hello',
                                        style: GoogleFonts.aBeeZee(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        '${cubit.userModel!.name!.split(' ')[0]}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: GoogleFonts.aBeeZee(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      navigateTo(context, EditProfile());
                                      cubit.imageProfile = null;
                                    },
                                    child: CircleAvatar(
                                      backgroundColor: Colors.grey[300],
                                      radius: widthScreen / 19,
                                      child: Icon(
                                        IconBroken.Edit,
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
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return itemBuilder(
                                widthScreen: widthScreen,
                                heightScreen: heightScreen,
                                titles: titles,
                                index: index,
                                context: context,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return index == 1
                                  ? SizedBox(
                                      height: 7,
                                    )
                                  : SizedBox(
                                      height: 1,
                                    );
                            },
                            itemCount: titles.length,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Center(child: CircularProgressIndicator(color: colorDefault,));
      },
    );
  }

  Widget itemBuilder({
    double? widthScreen,
    double? heightScreen,
    titles,
    int? index,
    context,
  }) {
    return GestureDetector(
      onTap: () {
        if (index == 0) {
          OralCubit.get(context).changeBottomNav(0);
        }
        if (index == 2) {
          navigateToFinish(context, LoginScreen());
          CacheHelper.removeData(key: 'uId');
        }
      },
      child: Container(
        width: widthScreen,
        height: heightScreen! / 15,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(
                '${titles![index!]}',
                style: TextStyle(
                  fontSize: widthScreen! / 26,
                  color: index == 2 ? colorDefault : Colors.black,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios_outlined,
                size: widthScreen / 25,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
