import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moxshow/widgets/movie_details_widgets/movie_details.dart';
import 'package:tmdb_api/tmdb_api.dart';

class CelebDetails extends StatefulWidget {
  const CelebDetails(
      {super.key, required this.id, required this.name, required this.photo});

  final String id, name, photo;

  @override
  State<CelebDetails> createState() => _CelebDetailsState();
}

class _CelebDetailsState extends State<CelebDetails> {
  Map pDetails = {};
  List moviesDone = [];
  void initState() {
    loadCelebs();
    super.initState();
  }

  final String apiKey = '848690b648dc8469cef88857b3e293c8';

  final String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NDg2OTBiNjQ4ZGM4NDY5Y2VmODg4NTdiM2UyOTNjOCIsInN1YiI6IjY0OTE2NTY4YzNjODkxMDEyZDVmNGRlOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DmyxRgIpvEXHJC6cbwG3AtTb5cv5fvklRWphcElmthE';

  void loadCelebs() async {
    TMDB tmdbCustomLogs = TMDB(ApiKeys(apiKey, token),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

    int intId = int.parse(widget.id);

    Map personDetailsResult = await tmdbCustomLogs.v3.people.getDetails(intId);
    Map moviesDoneResult =
        await tmdbCustomLogs.v3.people.getMovieCredits(intId);

    setState(() {
      pDetails = personDetailsResult;
      moviesDone = moviesDoneResult['cast'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.name,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 1, 15, 2),
        ),
        body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.photo),
                  fit: BoxFit.cover,
                  opacity: 0.1)),
          child: ListView(children: [
            Expanded(
              child: Container(
                height: 400,
                child: Image.network(widget.photo, fit: BoxFit.cover),
              ),
            ),
            Container(
              height: 80,
              color: Color.fromARGB(168, 0, 0, 0),
              child: Center(
                child: Wrap(children: [
                  Text(
                    widget.name.toUpperCase(),
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ]),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Place of Birth : ${pDetails['place_of_birth']}',
                    style: GoogleFonts.prompt(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'DOB : ${pDetails['birthday']}',
                    style: GoogleFonts.prompt(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Text(
                'About',
                textAlign: TextAlign.justify,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 30,
                ),
              ),
            ),
            Container(
                padding: EdgeInsets.all(20),
                child: pDetails['biography'] == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Text(
                        pDetails['biography'],
                        textAlign: TextAlign.justify,
                        softWrap: true,
                        style: GoogleFonts.rubik(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                        ),
                      )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Filmography",
                    style: GoogleFonts.poppins(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
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
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(moviesDone.length, (index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return MovieDesc(
                                  id: moviesDone[index]['id'].toString(),
                                  isAdult:
                                      moviesDone[index]['adult'].toString(),
                                  name: moviesDone[index]['original_title'],
                                  description: moviesDone[index]['overview'],
                                  posterUrl: 'https://image.tmdb.org/t/p/w500' +
                                      moviesDone[index]['poster_path'],
                                  bannerUrl: 'https://image.tmdb.org/t/p/w500' +
                                      moviesDone[index]['backdrop_path'],
                                  rating: moviesDone[index]['vote_average']
                                      .toStringAsFixed(1),
                                  releaseDate: moviesDone[index]
                                      ['release_date']);
                            },
                          ));
                        },
                        child: moviesDone[index]['poster_path'] == null
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
                                            moviesDone[index]['poster_path']),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ]),
        ));
  }
}
