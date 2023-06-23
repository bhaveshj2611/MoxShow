import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moxshow/widgets/show_widget_details/tv_details.dart';

class SimRecTv extends StatelessWidget {
  const SimRecTv({super.key, this.movies, this.title});

  final movies;
  final title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
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
          decoration: BoxDecoration(),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(movies.length, (index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return TvDesc(
                        id: movies[index]['id'].toString(),
                        isAdult: movies[index]['adult'].toString(),
                        name: movies[index]['original_name'],
                        description: movies[index]['overview'],
                        posterUrl: 'https://image.tmdb.org/t/p/w500' +
                            movies[index]['poster_path'],
                        bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                            movies[index]['backdrop_path'],
                        rating:
                            movies[index]['vote_average'].toStringAsFixed(1),
                      );
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
