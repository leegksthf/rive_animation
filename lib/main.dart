import 'package:flutter/material.dart';
import 'package:rive_animation/entry_point.dart';
import 'package:rive_animation/screens/onboading/onboading_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Flutter Way',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFEEF1F8), // 전체 스크린 배경색 설정
          primarySwatch: Colors.blue, // 미리제공되는 견본색상으로 전체 테마 색상 적용
          fontFamily: 'Intel',
          inputDecorationTheme: const InputDecorationTheme(
            filled: true, // 배경색
            fillColor: Colors.white,
            errorStyle: TextStyle(height: 0),
            border: defaultInputBorder,
            enabledBorder: defaultInputBorder,
            focusedBorder: defaultInputBorder,
            errorBorder: defaultInputBorder,
          )),
      home: OnBoadingScreen(),
    );
  }
}

// border 하단만 주려면 UnderlineInputBorder
const defaultInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(16)),
    borderSide: BorderSide( // border 꾸미기
      color: Color(0xFFDEE3F2),
      width: 1,
    )
);
