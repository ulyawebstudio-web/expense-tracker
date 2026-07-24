import 'package:expense_tracker/palette.dart';
import 'package:expense_tracker/screens/home_screen.dart';
import 'package:flutter/material.dart';
  void main(){
    runApp(const MyApp());
  }
  class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme:  ColorScheme.fromSeed(seedColor: Palette.accent,
      brightness: Brightness.light),
      scaffoldBackgroundColor: Palette.background,),
      home:const HomeScreen(),
    );
  }
}