import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:ora_cancar/models/onBoard_Model/on_board_model.dart';
import 'package:ora_cancar/shared/component/constance.dart';

import '../styles/icons.dart';

Future navigateTo(context, screen) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );

Future navigateToFinish(context, screen) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => screen), (route) => false);

Widget onItemBoard(OnBoardModel list) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image(
          image: AssetImage('${list.image}'),
          fit: BoxFit.fill,
          height: 400,
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          '${list.title}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          '${list.body}',
          maxLines: 3,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );

Widget defaultTextFormedFailed({
  IconData? prefixIcon,
  IconData? suffixIcon,
  String? name,
  String? hintText,
  TextInputType? type,
  Function()? onTap,
  required TextEditingController? controller,
  var validate,
  var onChange,
  bool isSecure = false,
  var sufPressed,
  int? maxLength,
  var onSubmit,
  Color? colorOfBorder,
  Color? colorFocusedBorder,
  double? widthOfBorder,
}) {
  return TextFormField(
    controller: controller,
    onTap: onTap,
    keyboardType: type,
    validator: validate,
    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon),
      labelText: name,
      hintText: hintText,
      hintStyle: TextStyle(
        fontSize: 12,
      ),
      suffixIcon: InkWell(
        onTap: sufPressed,
        child: Icon(
          suffixIcon,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorFocusedBorder ?? colorDefault, width: widthOfBorder ?? 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorOfBorder ?? Colors.grey, width: widthOfBorder ?? 2.0),
      ),
    ),
    onChanged: onChange,
    obscureText: isSecure,
    maxLength: maxLength,
    onFieldSubmitted: onSubmit,
  );
}

Widget inputButton({
  String? text,
  Color? colorOfBox,
  Function()? onTap,
  double height = 50,
  double width = double.infinity,
  Color? colorOfIntgrateBox,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(
        4.0,
      ),
      color: colorOfBox,
      gradient: LinearGradient(
        colors: [colorDefault, colorOfIntgrateBox ?? Colors.amber],
        tileMode: TileMode.mirror,
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
    ),
    child: MaterialButton(
      onPressed: onTap,
      child: Center(
        child: Text(
          text!,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}

Widget textButton({
  var onPressed,
  String? text,
  double fontSize = 18,
  Color? color,
}) {
  return TextButton(
      onPressed: onPressed,
      child: Text(
        text!,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
        ),
      ));
}

//   state is! LoginLoadingState = false ,
Widget conditionalBuilder({bool? condition = false, builder, fallback}) {
  if (condition == true) {
    return builder;
  } else {
    return fallback;
  }
}

void showToast({required String message, required ToastStates? state}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: chooseToastColor(state!),
      textColor: Colors.white,
      fontSize: 16.0);
}

enum ToastStates { success, failed, warning }

Color? chooseToastColor(ToastStates? state) {
  Color color;
  switch (state!) {
    case ToastStates.success:
      color = Colors.green;
      break;
    case ToastStates.failed:
      color = Colors.red;
      break;
    case ToastStates.warning:
      color = Colors.orange;
      break;
  }
  return color;
}

Widget circleForLogin({
  required Color? backgroundColor,
  required IconData? icon,
  required Color? colorOfIcon,
  required var onTap,
}) {
  return InkWell(
    onTap: onTap,
    child: CircleAvatar(
      backgroundColor: backgroundColor,
      radius: 30,
      child: Icon(
        icon,
        size: 40,
        color: colorOfIcon,
      ),
    ),
  );
}

Widget inputButton2({
  String? text,
  String? image,
  Color? color,
  Color? colorOfText,
  Function()? onTap,
  double height = 50,
}) {
  return Container(
    height: height,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadiusDirectional.circular(
        4.0,
      ),
      color: color,
    ),
    child: MaterialButton(
      onPressed: onTap,
      child: Row(
        children: [
          Image(
            image: AssetImage(
              image!,
            ),
            height: 30,
          ),
          SizedBox(
            width: 25,
          ),
          Text(
            text!,
            style: TextStyle(
              color: colorOfText,
            ),
          ),
        ],
      ),
    ),
  );
}

void messageSuccess(context , String? text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text('$text Successful'),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.green,
  ));
}

void messageError(context , text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(text),
    duration: Duration(seconds: 1),
    backgroundColor: Colors.red,
  ));
}

Image imageBuilding({
  @required String? url,
  double? width,
}){
  return Image(
    image: NetworkImage("${url}"),
    width: width,
    fit: BoxFit.cover,
    errorBuilder: (BuildContext context,
        Object exception,
        StackTrace? stackTrace) {
      return Center(
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Icon(
              IconBroken.Info_Circle,
              color: Colors.grey[500],
            ),
            Text(
              'error in loading images',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
            Text(
              'check your internet',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    },
  );
}
String dateTimeNow(){
  var date = DateTime.now();
  var format = DateFormat('dd-MM-yyyy H:mm');
  String dateString = format.format(date);
  return dateString;
}

DateTime dateTimeNow1(PDate){
  var mdyFullString = PDate;
  /// 2022-07-05 16:22:01.050711
  var dateTime3 = DateFormat('yyyy-MM-dd h:mm').parse(mdyFullString);
  return dateTime3;
}