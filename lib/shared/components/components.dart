import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopapp/shared/styles/colors.dart';


Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 0,
  required String text,
  required VoidCallback function,
}) => Container(
    width: width,
    decoration: BoxDecoration(
      color: background,
      borderRadius: BorderRadius.circular(
          radius,
      ),
    ),
    child: MaterialButton(
      onPressed: function,
       child: Text(
         isUpperCase? text.toUpperCase() : text,
         style: const TextStyle(
           color: Colors.white,
         ),
       ),
      ),
    );

Widget defaultTextButton({
  required Text text,
  required VoidCallback? onPressed,
}) => TextButton(
  child: text,
  onPressed: onPressed,
);

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged? onSubmit,
  ValueChanged? onChanged,
  GestureTapCallback? onTap,
  required FormFieldValidator<String>? validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  VoidCallback? suffixPressed,
  bool isPassword = false,
  double radius = 0,
  bool isClickable = true,
}) => TextFormField(
  controller: controller,
  obscureText: isPassword,
  keyboardType: type,
  enabled: isClickable,
  onFieldSubmitted: onSubmit,
  onChanged: onChanged,
  validator: validate,
  onTap: onTap,
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix
      ),
    ) : null,
    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(
          radius,
        )
    ),
  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

void navigateTo({
  required widget,
  required context
}) => Navigator.push(
  context,
  MaterialPageRoute(
      builder: (context) => widget,
  ),
);

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
        (route) => false
);

void showToast({
  required String message,
  ToastStates? state,
}) => Fluttertoast.showToast(
  msg: "${message}",
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 5,
  backgroundColor: state == null ? defaultColor : chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastStates {SUCCESS, ERROR, WARNING}

Color? chooseToastColor(ToastStates state)
{
  Color? color;

  switch(state)
  {
    case(ToastStates.SUCCESS):
      color = Colors.green;
      break;
    case(ToastStates.ERROR):
      color = Colors.red;
      break;
    case(ToastStates.WARNING):
      color = Colors.amber;
      break;
  }
  return color;
}