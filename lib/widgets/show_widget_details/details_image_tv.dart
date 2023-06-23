import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailsStackTv extends StatelessWidget {
  const DetailsStackTv({
    super.key,
    required this.id,
    required this.isAdult,
    required this.name,
    required this.description,
    required this.posterUrl,
    required this.bannerUrl,
    required this.rating,
  });

  final String id, isAdult, name, description, posterUrl, bannerUrl, rating;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            child: Container(
          height: 600,
          child: Image.network(
            posterUrl,
            fit: BoxFit.cover,
          ),
        )),
        Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: Color.fromARGB(213, 0, 0, 0),
            )),
        Positioned(
          bottom: 140,
          left: 15,
          child: Container(
            width: 100,
            height: 40,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(20)),
            child: isAdult == 'false'
                ? Center(
                    child: Text('PG-13',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground)),
                  )
                : Center(
                    child: Text('R',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground)),
                  ),
          ),
        ),
        Positioned(
          bottom: 80,
          left: 15,
          right: 0,
          child: Wrap(children: [
            Text(
              name.toUpperCase(),
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
        Positioned(
          bottom: 40,
          left: 15,
          child: Container(
            child: Text(
              rating + ' ⭐',
              style: GoogleFonts.poppins(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }
}
