import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moxshow/screens/nav_page.dart';
import 'package:moxshow/widgets/movie_details_widgets/cast.dart';
import 'package:moxshow/widgets/show_widget_details/details_image_tv.dart';
import 'package:moxshow/widgets/shows_widgets/sim_rec_tv.dart';
import 'package:tmdb_api/tmdb_api.dart';

class TvDesc extends StatefulWidget {
  const TvDesc(
      {super.key,
      required this.id,
      required this.isAdult,
      required this.name,
      required this.description,
      required this.posterUrl,
      required this.bannerUrl,
      required this.rating});

  final String id, isAdult, name, description, posterUrl, bannerUrl, rating;

  @override
  State<TvDesc> createState() => _TvDescState();
}

class _TvDescState extends State<TvDesc> {
  void initState() {
    loadMovies();
    super.initState();
  }

  List similarTv = [];
  List recommendTv = [];
  List creditTv = [];

  final String apiKey = '848690b648dc8469cef88857b3e293c8';

  final String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NDg2OTBiNjQ4ZGM4NDY5Y2VmODg4NTdiM2UyOTNjOCIsInN1YiI6IjY0OTE2NTY4YzNjODkxMDEyZDVmNGRlOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DmyxRgIpvEXHJC6cbwG3AtTb5cv5fvklRWphcElmthE';

  void loadMovies() async {
    TMDB tmdbCustomLogs = TMDB(ApiKeys(apiKey, token),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

    int intId = int.parse(widget.id);

    Map similarTvResult = await tmdbCustomLogs.v3.tv.getSimilar(intId);
    Map creditTvResult = await tmdbCustomLogs.v3.tv.getCredits(intId);
    Map recommendTvResult =
        await tmdbCustomLogs.v3.tv.getRecommendations(intId);

    setState(() {
      creditTv = creditTvResult['cast'];
      similarTv = similarTvResult['results'];
      recommendTv = recommendTvResult['results'];
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
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return NavPage();
              },
            ));
          },
        ),
        backgroundColor: Color.fromARGB(255, 1, 15, 2),
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(widget.bannerUrl),
                fit: BoxFit.cover,
                opacity: 0.3)),
        child: ListView(scrollDirection: Axis.vertical, children: [
          Container(
              height: 600,
              // color: Colors.blue,
              child: DetailsStackTv(
                id: widget.id,
                isAdult: widget.isAdult,
                name: widget.name,
                description: widget.description,
                posterUrl: widget.posterUrl,
                bannerUrl: widget.bannerUrl,
                rating: widget.rating,
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Text(
              'Overview',
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
            padding: EdgeInsets.all(15),
            child: Text(
              widget.description,
              maxLines: 10,
              textAlign: TextAlign.justify,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.rubik(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                fontSize: 16,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Cast(credit: creditTv),
          SizedBox(
            height: 20,
          ),
          SimRecTv(
            movies: recommendTv,
            title: 'Recommended Shows',
          ),
          SizedBox(
            height: 20,
          ),
          SimRecTv(
            movies: similarTv,
            title: 'Similar Shows',
          ),
        ]),
      ),
    );
  }
}
