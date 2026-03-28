import 'package:flutter/material.dart';
// 방금 만든 알람 설정 파일 이름을 불러옵니다. 파일명이 다르면 수정해주세요!
import 'alarm_settings.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '아빠~❤️',
      debugShowCheckedModeBanner: false, // 오른쪽 상단 디버그 띠 제거
      theme: ThemeData(
        primarySwatch: Colors.blue,
        // 아버님을 위해 앱 전체의 기본 글꼴 크기를 크게 설정합니다.
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 20.0),
          bodyMedium: TextStyle(fontSize: 18.0),
        ),
        useMaterial3: true, // 최신 안드로이드 스타일 적용
      ),
      // 앱이 켜지자마자 보여줄 첫 화면을 지정합니다.
      home: AlarmSettingsScreen(), 
    );
  }
}