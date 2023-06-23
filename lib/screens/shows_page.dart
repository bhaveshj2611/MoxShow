import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:moxshow/widgets/shows_widgets/potrait_tv.dart';
import 'package:moxshow/widgets/shows_widgets/wide_tv.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:tmdb_api/tmdb_api.dart';

class ShowsPage extends StatefulWidget {
  const ShowsPage({super.key});

  @override
  State<ShowsPage> createState() => _ShowsPageState();
}

class _ShowsPageState extends State<ShowsPage> {
  @override
  void initState() {
    loadMovies();
    super.initState();
  }

  List airingtv = [];
  List topTvs = [];
  List trendTvs = [];

  final String apiKey = '848690b648dc8469cef88857b3e293c8';
  final String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4NDg2OTBiNjQ4ZGM4NDY5Y2VmODg4NTdiM2UyOTNjOCIsInN1YiI6IjY0OTE2NTY4YzNjODkxMDEyZDVmNGRlOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.DmyxRgIpvEXHJC6cbwG3AtTb5cv5fvklRWphcElmthE';

  void loadMovies() async {
    TMDB tmdbCustomLogs = TMDB(ApiKeys(apiKey, token),
        logConfig: ConfigLogger(showLogs: true, showErrorLogs: true));
    Map trendTvsResult =
        await tmdbCustomLogs.v3.trending.getTrending(mediaType: MediaType.tv);

    Map topTvsResult = await tmdbCustomLogs.v3.tv.getTopRated();
    Map airingtvResult = await tmdbCustomLogs.v3.tv.getAiringToday();

    setState(() {
      airingtv = airingtvResult['results'];
      topTvs = topTvsResult['results'];
      trendTvs = trendTvsResult['results'];
    });
  }

  int activeIndex = 0;
  final List urlimg = [
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/A9sCKnxgTTapzu307ybdXCJQEqD.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/rqbCbjB19amtOtFQbb3K2lgm2zv.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/ta5oblpMlEcIPIS2YGcq9XEkWK2.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/4h4HETnteDE5wAEptaghTO7KS9Q.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/2TM7UZLSGsMYZ62yysyGPhDtpfr.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/20eIP9o5ebArmu2HxJutaBjhLf4.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/hPea3Qy5Gd6z4kJLUruBbwAH8Rm.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/h3vViR087OJlk4PedNt5JLIKOOi.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/sHhwowiiN5djzlIHeCUM2mUwa2M.jpg',
    'https://www.themoviedb.org/t/p/w1000_and_h563_face/6T19aRp9zLMghZo1dTEwoNyreNZ.jpg',
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
                  autoPlayCurve: Curves.easeInOutCirc,
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
          PotraitTv(
            tvPotraits: trendTvs,
            title: 'Trending Shows',
          ),
          WideTvs(
            wideTv: topTvs,
            title: 'Top Rated Shows',
          ),
          PotraitTv(tvPotraits: airingtv, title: 'Airing Now'),
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
