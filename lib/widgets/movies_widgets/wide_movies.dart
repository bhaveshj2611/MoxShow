import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moxshow/widgets/movie_details_widgets/movie_details.dart';

class WideMovies extends StatelessWidget {
  const WideMovies({super.key, required this.wideMvs, this.title});

  final List wideMvs;
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
            height: 280,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: wideMvs.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return MovieDesc(
                          id: wideMvs[index]['id'].toString(),
                          isAdult: wideMvs[index]['adult'].toString(),
                          name: wideMvs[index]['original_title'],
                          description: wideMvs[index]['overview'],
                          posterUrl: 'https://image.tmdb.org/t/p/w500' +
                              wideMvs[index]['poster_path'],
                          bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                              wideMvs[index]['backdrop_path'],
                          rating: wideMvs[index]['vote_average'].toString(),
                          releaseDate: wideMvs[index]['release_date']);
                    },
                  ));
                },
                child: Container(
                  width: 365,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 10),
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.9),
                                    blurRadius: 5,
                                    spreadRadius: 3,
                                  ),
                                ],
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          wideMvs[index]['backdrop_path']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 25,
                              top: 10,
                              child: Container(
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(221, 0, 0, 0),
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
                              left: 60,
                              top: 15,
                              child: Container(
                                child: Text(
                                  wideMvs[index]['vote_average'].toString() +
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
                            wideMvs[index]['title'] == null
                                ? 'Loading'
                                : wideMvs[index]['title'],
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
