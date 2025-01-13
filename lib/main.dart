import 'package:capicua/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Capicua',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xff06b6d4),
          surface: Color(0xff020617),
          surfaceDim: Color(0xff0f172a),
          brightness: Brightness.dark,
        ),

        cardTheme: CardTheme(
          color: Color(0xff1e293b),
        ),

        textTheme: TextTheme(
          bodyMedium: TextStyle(
            fontWeight: FontWeight.bold,
          )
        ),

        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
