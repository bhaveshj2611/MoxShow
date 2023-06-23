import 'package:flutter/material.dart';
import 'package:moxshow/screens/start_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

var kColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 6, 168, 0));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: kColorScheme,
        useMaterial3: true,
        textTheme: GoogleFonts.rubikTextTheme(),
      ),
      themeMode: ThemeMode.system,
      home: const StartPage(),
    );
  }
}
