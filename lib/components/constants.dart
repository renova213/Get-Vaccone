import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

const baseUrl = '';

const textColor = Color(0xFF35364F);
const primaryColor = Color(0xFF06919D);
const secondColor = Color(0xFF6CC5CD);
const secondColorLow = Color(0XFFBDE8EC);
const tertiary = Color(0XFF06779D);
const buttonColorPrimary = Color(0XFFF0A258);
const buttonColorSecondary = Color(0XFFF58114);
const buttonColorLight = Color(0XFFF6E1CD);
const statusSuccess = Color(0XFF52C41A);
const statusDanger = Color(0XFFF5222D);
const statusWarning = Color(0XFFFFAD14);
const statusInfo = Color(0XFF1890FF);
const pressedColor = Color(0xff03484E);
const lowPressedColor = Color(0xffCDE9EB);

Uint8List convertBase64Image(String base64String) {
  return const Base64Decoder().convert(base64String.split(',').last);
}

bool isTrue = true;
bool isInitBooking = true;

const LinearGradient gradientVertical = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    secondColor,
    tertiary,
  ],
);

const LinearGradient gradientHorizontal = LinearGradient(
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
  colors: [tertiary, secondColor],
);

const InputDecorationTheme inputDecorationTheme = InputDecorationTheme();

const IconThemeData iconTheme = IconThemeData(color: Colors.white, size: 28);

AppBarTheme appBarTheme = const AppBarTheme(
    titleSpacing: 0,
    iconTheme: IconThemeData(color: Colors.black),
    elevation: 0,
    backgroundColor: Colors.white);

ButtonStyle lowStateButton = ButtonStyle(
  foregroundColor: MaterialStateProperty.resolveWith(
    (states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade300;
      }
      if (states.contains(MaterialState.pressed)) {
        return pressedColor;
      }
      return primaryColor;
    },
  ),
  textStyle: MaterialStateProperty.resolveWith(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        );
      }
      if (states.contains(MaterialState.pressed)) {
        return const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        );
      }
      return const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      );
    },
  ),
  side: MaterialStateProperty.resolveWith<BorderSide?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return BorderSide(width: 1, color: Colors.grey.shade600);
      }
      if (states.contains(MaterialState.pressed)) {
        return const BorderSide(width: 1, color: pressedColor);
      }

      return const BorderSide(width: 1, color: lowPressedColor);
    },
  ),
  overlayColor: MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) return lowPressedColor;
      return null;
    },
  ),
  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade600;
      }
      if (states.contains(MaterialState.pressed)) return lowPressedColor;
      return Colors.white;
    },
  ),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);

ButtonStyle secondStateButton = ButtonStyle(
  foregroundColor: MaterialStateProperty.resolveWith(
    (states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade300;
      }
      if (states.contains(MaterialState.pressed)) {
        return primaryColor;
      }
      return primaryColor;
    },
  ),
  textStyle: MaterialStateProperty.resolveWith(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          fontFamily: 'Poppins',
        );
      }
      if (states.contains(MaterialState.pressed)) {
        return const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        );
      }
      return const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        fontFamily: 'Poppins',
      );
    },
  ),
  side: MaterialStateProperty.resolveWith<BorderSide?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return BorderSide(width: 1, color: Colors.grey.shade600);
      }
      if (states.contains(MaterialState.pressed)) {
        return const BorderSide(width: 2, color: pressedColor);
      }

      return const BorderSide(width: 2, color: primaryColor);
    },
  ),
  overlayColor: MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.pressed)) return lowPressedColor;
      return null;
    },
  ),
  backgroundColor: MaterialStateProperty.resolveWith<Color?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return Colors.grey.shade600;
      }
      if (states.contains(MaterialState.pressed)) return lowPressedColor;
      return Colors.white;
    },
  ),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
  ),
);

ElevatedButtonThemeData elevatedButtonTheme = ElevatedButtonThemeData(
  style: ButtonStyle(
    foregroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey;
        }
        if (states.contains(MaterialState.pressed)) {
          return Colors.white;
        }
        return Colors.white;
      },
    ),
    textStyle: MaterialStateProperty.resolveWith(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w400,
            fontFamily: 'Poppins',
          );
        }
        if (states.contains(MaterialState.pressed)) {
          return const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
          );
        }
        return const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        );
      },
    ),
    side: MaterialStateProperty.resolveWith<BorderSide?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return BorderSide(width: 1, color: Colors.grey.shade600);
        }
        if (states.contains(MaterialState.pressed)) {
          return const BorderSide(width: 1, color: pressedColor);
        }

        return null;
      },
    ),
    overlayColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed)) return pressedColor;
        return primaryColor;
      },
    ),
    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey.shade600;
        }
        if (states.contains(MaterialState.pressed)) return pressedColor;
        return primaryColor;
      },
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  ),
);

TextTheme textTheme = TextTheme(
  headline1: TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: Colors.grey.shade900),
  headline2: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: Colors.grey.shade900),
  headline3: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: Colors.grey.shade900),
  headline4: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: primaryColor),
  headline5: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: primaryColor),
  headline6: const TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: primaryColor),
  subtitle1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
      color: Colors.grey.shade800),
  subtitle2: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
      color: Colors.grey.shade800),
  bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins',
      color: Colors.grey.shade700),
  bodyText2: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      fontFamily: 'Poppins',
      color: Colors.grey.shade800),
  button: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'Poppins',
      color: Colors.grey.shade900),
  caption: TextStyle(
      fontSize: 10.0,
      fontWeight: FontWeight.w500,
      fontFamily: 'Poppins',
      color: Colors.grey.shade800),
);

const defaultPadding = 16.0;
