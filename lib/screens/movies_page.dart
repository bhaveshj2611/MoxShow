import 'package:flutter/material.dart';
import 'package:moxshow/widgets/movies_widgets/wide_movies.dart';
import 'package:moxshow/widgets/movies_widgets/potrait_movies.dart';
import 'package:moxshow/widgets/movies_widgets/trending_people.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  List trendMvs = [];
  List topMvs = [];
  List topMvsI = [];
  List nowpMvs = [];
  List upcomingMvs = [];
  List trendppl = [];
  List allMovies = [];

  final String apiKey = '848690b648dc8469cef88857b3e293c8';
  final String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NDg2OTBiNjQ4ZGM4NDY5Y2VmODg4NTdiM2UyOTNjOCIsInN1YiI6IjY0OTE2NTY4YzNjODkxMDEyZDVmNGRlOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DmyxRgIpvEXHJC6cbwG3AtTb5cv5fvklRWphcElmthE';

  void loadMovies() async {
    TMDB tmdbCustomLogs = TMDB(ApiKeys(apiKey, token),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));

    Map trendMvsResult = await tmdbCustomLogs.v3.trending.getTrending(
        mediaType: MediaType.movie,
        timeWindow: TimeWindow.week,
        language: 'hi-IN');
    Map topMvsIResult = await tmdbCustomLogs.v3.movies
        .getTopRated(language: 'hi-IN', region: 'IN');
    Map topMvsResult = await tmdbCustomLogs.v3.movies.getTopRated();
    Map upcomingMvsResult = await tmdbCustomLogs.v3.movies.getUpcoming();
    Map nowpMvsResult = await tmdbCustomLogs.v3.movies.getNowPlaying();
    Map trendpplResult = await tmdbCustomLogs.v3.trending
        .getTrending(mediaType: MediaType.person);

    if (mounted) {
      setState(() {
        trendMvs = trendMvsResult['results'];
        topMvs = topMvsResult['results'];
        upcomingMvs = upcomingMvsResult['results'];
        nowpMvs = nowpMvsResult['results'];
        trendppl = trendpplResult['results'];
        topMvsI = topMvsIResult['results'];
      });
    }
  }

  int activeIndex = 0;
  final List urlimg = [
    'https://www.themoviedb.org/t/p/w1066_and_h600_bestv2/kIX6VS5FTMURcK3WlNNkPss60e4.jpg',
    'https://cdn.wallpapersafari.com/53/79/ajwtby.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/e8BCc8Jk11dnSffI6ElICLePvLZ.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/evaFLqtswezLosllRZtJNMiO1UR.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/4XM8DUTQb3lhLemJC51Jx4a2EuA.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/dIWwZW7dJJtqC6CgWzYkNVKIUm8.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/hiKmpZMGZsrkA3cdce8a7Dpos1j.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/u7kuUaySqXBVAtqEl9vkTkAzHV9.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/9wRAIQeOv2qzcgpfvA4dYZKeezl.jpg',
    'https://wallpapercave.com/wp/wp10363337.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.black, Color.fromARGB(255, 3, 27, 3)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 20,
          ),
          CarouselSlider.builder(
              itemCount: urlimg.length,
              itemBuilder: (context, index, realIndex) {
                final urlImage = urlimg[index];
                return buildImage(urlImage, index);
              },
              options: CarouselOptions(
                  enlargeFactor: 0.5,
                  autoPlayAnimationDuration: Duration(milliseconds: 2000),
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: 2.0,
                  onPageChanged: (index, reason) {
                    return setState(() => activeIndex = index);
                  })),
          SizedBox(
            height: 12,
          ),
          Center(child: buildIndicator()),
          SizedBox(
            height: 20,
          ),
          WideMovies(
            wideMvs: upcomingMvs,
            title: 'Soon in Theatres',
          ),
          SizedBox(
            height: 10,
          ),
          PotraitMovies(
            moviePotraits: trendMvs,
            title: 'Trending Now',
          ),
          TrendingPeople(trendppl: trendppl),
          WideMovies(
            wideMvs: nowpMvs,
            title: 'Now playing',
          ),
          PotraitMovies(
            moviePotraits: topMvsI,
            title: 'Top Movies(India)',
          ),
          PotraitMovies(
            moviePotraits: topMvs,
            title: 'Top Movies(Global)',
          ),
        ],
      ),
    ));
  }

  Widget buildIndicator() {
    return AnimatedSmoothIndicator(
        effect: ExpandingDotsEffect(
            activeDotColor: const Color.fromARGB(255, 0, 255, 8),
            dotHeight: 5,
            dotWidth: 12),
        activeIndex: activeIndex,
        count: urlimg.length);
  }
}

Widget buildImage(String urlImage, int index) {
  return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Image.network(urlImage, fit: BoxFit.cover));
}
