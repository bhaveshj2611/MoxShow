import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:moxshow/widgets/movie_details_widgets/movie_details.dart';

class PotraitMovies extends StatelessWidget {
  const PotraitMovies({
    super.key,
    required this.moviePotraits,
    this.title,
  });

  final List moviePotraits;
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
              itemCount: moviePotraits.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return MovieDesc(
                          id: moviePotraits[index]['id'].toString(),
                          isAdult: moviePotraits[index]['adult'].toString(),
                          name: moviePotraits[index]['original_title'],
                          description: moviePotraits[index]['overview'],
                          posterUrl: 'https://image.tmdb.org/t/p/w500' +
                              moviePotraits[index]['poster_path'],
                          bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                              moviePotraits[index]['backdrop_path'],
                          rating: moviePotraits[index]['vote_average']
                              .toStringAsFixed(1),
                          releaseDate: moviePotraits[index]['release_date']);
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
                                            moviePotraits[index]
                                                ['poster_path']),
                                    fit: BoxFit.cover),
                              ),
                            ),
                            Positioned(
                              left: 25,
                              top: 10,
                              child: Container(
                                width: 55,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(223, 0, 0, 0),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          spreadRadius: 6,
                                          color: Colors.black.withOpacity(0.3)),
                                    ],
                                    borderRadius: BorderRadius.circular(50)),
                              ),
                            ),
                            Positioned(
                              left: 32,
                              top: 15,
                              child: Container(
                                child: Text(
                                  moviePotraits[index]['vote_average']
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
                            moviePotraits[index]['title'] == null
                                ? 'Loading'
                                : moviePotraits[index]['title'],
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
