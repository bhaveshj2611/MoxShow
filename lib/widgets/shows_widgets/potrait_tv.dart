import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moxshow/widgets/show_widget_details/tv_details.dart';

class PotraitTv extends StatelessWidget {
  const PotraitTv({super.key, required this.tvPotraits, required this.title});

  final List tvPotraits;
  final title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.prompt(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontSize: 25),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            height: 400,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: tvPotraits.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return TvDesc(
                        id: tvPotraits[index]['id'].toString(),
                        isAdult: tvPotraits[index]['adult'].toString(),
                        name: tvPotraits[index]['original_name'],
                        description: tvPotraits[index]['overview'],
                        posterUrl: 'https://image.tmdb.org/t/p/w500' +
                            tvPotraits[index]['poster_path'],
                        bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                            tvPotraits[index]['backdrop_path'],
                        rating: tvPotraits[index]['vote_average']
                            .toStringAsFixed(1),
                      );
                    },
                  ));
                },
                child: Container(
                  width: 200,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 7),
                              height: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 5,
                                    spreadRadius: 3,
                                  ),
                                ],
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          tvPotraits[index]['poster_path']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 25,
                              top: 10,
                              child: Container(
                                width: 55,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(225, 0, 0, 0),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          spreadRadius: 6,
                                          color: Colors.black.withOpacity(0.3)),
                                    ],
                                    borderRadius: BorderRadius.circular(60)),
                              ),
                            ),
                            Positioned(
                              left: 32,
                              top: 15,
                              child: Container(
                                child: Text(
                                  tvPotraits[index]['vote_average']
                                          .toStringAsFixed(1) +
                                      ' ⭐',
                                  style: GoogleFonts.poppins(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(6, 10, 10, 0),
                          child: Text(
                            tvPotraits[index]['original_name'] == null
                                ? 'Loading'
                                : tvPotraits[index]['original_name'],
                            maxLines: 4,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onTertiaryContainer,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
