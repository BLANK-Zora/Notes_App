import 'package:flutter/material.dart';

//light mode

ThemeData lightmode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.grey.shade200,
    primary: Colors.grey.shade700,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade800
  ),
);

// dark mode 


ThemeData darkmode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    background: Color.fromARGB(255, 18, 17, 17),
    primary: Colors.grey.shade700,
    secondary: Colors.grey.shade900,
    inversePrimary: Colors.grey.shade300
  ),
);