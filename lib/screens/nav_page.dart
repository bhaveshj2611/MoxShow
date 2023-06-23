import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moxshow/screens/movies_page.dart';
import 'package:moxshow/screens/shows_page.dart';
import 'package:moxshow/screens/start_page.dart';

class NavPage extends StatefulWidget {
  const NavPage({super.key});

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int navIndex = 0;

  List screenList = [MoviesPage(), ShowsPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          elevation: 20,
          currentIndex: navIndex,
          selectedItemColor: Color.fromARGB(255, 93, 255, 24),
          backgroundColor: const Color.fromARGB(255, 4, 31, 5),
          onTap: (index) {
            setState(() {
              navIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.movie_outlined,
                size: 30,
              ),
              label: 'Movies',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.monitor_sharp,
                  size: 30,
                ),
                label: 'Shows')
          ]),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20),
            child: Image.asset(
              'assets/images/logo-moxshow.png',
              width: 50,
            ),
          ),
        ],
        title: Text(
          'MoxShow',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) {
                return StartPage();
              },
            ));
          },
        ),
        backgroundColor: Color.fromARGB(255, 1, 15, 2),
      ),
      body: screenList[navIndex],
    );
  }
}
