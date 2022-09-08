import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ora_cancar/layout/cubit/oral_cubit.dart';
import 'package:ora_cancar/layout/cubit/oral_states.dart';
import 'package:ora_cancar/modules/chat/chat_screen.dart';
import 'package:ora_cancar/modules/settings/settings_screen.dart';
import 'package:ora_cancar/shared/component/constance.dart';
import 'package:ora_cancar/shared/styles/icons.dart';

import '../modules/home/home_screen.dart';

class OralLayout extends StatelessWidget {
  OralLayout({Key? key}) : super(key: key);
  var cubit = OralCubit();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OralCubit, OralStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = OralCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            titleSpacing: 0,
            centerTitle: false,
            leadingWidth: 1,
            title: Text(
              cubit.titles![cubit.currentIndex],
              style: GoogleFonts.pacifico(
                color: colorDefault,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(IconBroken.Notification, color: Colors.black),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(IconBroken.Search, color: Colors.black),
                onPressed: () {},
              ),
            ],
          ),
          body: cubit.screens![cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Home,
                ),
                label: 'home',
              ),
             // if (!OralCubit.get(context).isDoctor!)
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Upload,
                  ),
                  label: 'upload',
                ),
              // if (!OralCubit.get(context).isDoctor!)
                BottomNavigationBarItem(
                  icon: Icon(
                    IconBroken.Info_Square,
                  ),
                  label: 'advices',
                ),
              BottomNavigationBarItem(
                icon: Icon(
                  IconBroken.Setting,
                ),
                label: 'settings',
              ),
            ],
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            elevation: 20,
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            selectedItemColor: colorDefault,
          ),
        );
      },
    );
  }
}
