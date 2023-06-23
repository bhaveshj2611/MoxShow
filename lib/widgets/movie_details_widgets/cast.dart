import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moxshow/widgets/movie_details_widgets/celeb_details.dart';

class Cast extends StatelessWidget {
  const Cast({
    super.key,
    required this.credit,
  });

  final credit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Cast',
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
          height: 250,
          width: 600,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background.withOpacity(0.7),
          ),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: List.generate(credit.length, (index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return CelebDetails(
                        id: credit[index]['id'].toString(),
                        name: credit[index]['name'],
                        photo: 'https://image.tmdb.org/t/p/w500' +
                            credit[index]['profile_path'],
                      );
                    },
                  ));
                },
                child: credit[index]['profile_path'] == null
                    ? Container()
                    : Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(6),
                            width: 100,
                            height: 140,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' +
                                        credit[index]['profile_path']),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Container(
                              width: 100,
                              child: Text(
                                credit[index]['name'],
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              )),
                          Container(
                              width: 100,
                              child: Text(
                                credit[index]['character'],
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ))
                        ],
                      ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
