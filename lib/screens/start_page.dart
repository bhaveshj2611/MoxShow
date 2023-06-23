import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moxshow/screens/nav_page.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    void toNav() {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => NavPage()));
    }

    void alertBox() {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.onTertiary,
            title: Text(
              'MoxShow',
              style: TextStyle(color: Colors.white),
            ),
            content: Container(
              height: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text(
                      'MoxShow is a Flutter application designed to provide users with a comprehensive database of movies and TV shows. The app utilizes the TMDb (The Movie Database) API to fetch information about various films and television series, including details about cast members, recommendations, and similar movies.',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Image.network(
                      'https://pbs.twimg.com/profile_images/1243623122089041920/gVZIvphd_400x400.jpg',
                      width: 200,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'GitHub - @bhaveshj2611',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'))
            ],
          );
        },
      );
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.black, Color.fromARGB(255, 5, 48, 5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight),
        ),
        child: Column(
          children: [
            Image.asset(
              'assets/images/pxfuel.jpg',
            ),
            const SizedBox(
              height: 60,
            ),
            Image.asset(
              'assets/images/logo-moxshow.png',
              width: 250,
              alignment: Alignment.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'MoxoShow - A TMDb Powered Movie Guide',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            const SizedBox(
              height: 60,
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: const LinearGradient(colors: [
                    Color.fromARGB(255, 11, 175, 17),
                    Color.fromARGB(255, 108, 255, 10),
                  ])),
              child: TextButton(
                  onPressed: toNav,
                  style: TextButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(270, 40),
                    foregroundColor: Theme.of(context).colorScheme.onSecondary,
                  ),
                  child: Text(
                    'Guest Login',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              child: Container(
                child: Text(
                  'About MoxShow - Readme',
                  style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
              onTap: alertBox,
            )
          ],
        ),
      ),
    );
  }
}
