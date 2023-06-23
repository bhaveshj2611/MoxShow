import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moxshow/widgets/movie_details_widgets/celeb_details.dart';

class TrendingPeople extends StatelessWidget {
  const TrendingPeople({super.key, required this.trendppl});

  final List trendppl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Populars Celebs',
            style: GoogleFonts.prompt(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                fontSize: 25),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: trendppl.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return CelebDetails(
                        id: trendppl[index]['id'].toString(),
                        name: trendppl[index]['name'],
                        photo: 'https://image.tmdb.org/t/p/w500' +
                            trendppl[index]['profile_path'],
                      );
                    },
                  ));
                },
                child: trendppl[index]['profile_path'] == null
                    ? Container()
                    : Container(
                        width: 125,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 0),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 7),
                                height: 125,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.3),
                                      blurRadius: 5,
                                      spreadRadius: 3,
                                    ),
                                  ],
                                ),
                                child: CircleAvatar(
                                  backgroundColor:
                                      const Color.fromARGB(0, 76, 175, 79),
                                  radius: 200,
                                  backgroundImage: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500' +
                                          trendppl[index]['profile_path']),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(6, 10, 10, 0),
                                child: Text(
                                  trendppl[index]['original_name'] == null
                                      ? 'Loading'
                                      : trendppl[index]['original_name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
