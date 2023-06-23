import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moxshow/widgets/movie_details_widgets/movie_details.dart';

class SimRec extends StatelessWidget {
  const SimRec({super.key, this.movies, this.title});

  final movies;
  final title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // color: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            title,
            style: GoogleFonts.poppins(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontWeight: FontWeight.w500,
                fontSize: 27),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 220,
          width: 600,

          decoration: BoxDecoration(
              // color: Theme.of(context).colorScheme.onSecondary,
              // borderRadius: BorderRadius.circular(20),
              ),
          // padding: EdgeInsets.all(10),

          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(movies.length, (index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return MovieDesc(
                          id: movies[index]['id'].toString(),
                          isAdult: movies[index]['adult'].toString(),
                          // index: upcomingMvs[index],
                          name: movies[index]['original_title'],
                          description: movies[index]['overview'],
                          posterUrl: 'https://image.tmdb.org/t/p/w500' +
                              movies[index]['poster_path'],
                          bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                              movies[index]['backdrop_path'],
                          rating:
                              movies[index]['vote_average'].toStringAsFixed(1),
                          releaseDate: movies[index]['release_date']);
                    },
                  ));
                },
                child: movies[index]['poster_path'] == null
                    ? Container()
                    : Container(
                        margin: EdgeInsets.all(6),
                        width: 140,
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          // color: Colors.red,
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w500' +
                                    movies[index]['poster_path']),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
