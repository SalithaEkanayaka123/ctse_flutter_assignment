import 'package:ctse_assignment_1/models/movie.dart';
import 'package:flutter/material.dart';
import '../../../styles.dart';
import '../moviecard/small_movie_card.dart';

class MovieCategory extends StatelessWidget {
  const MovieCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                "Recommended",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                child: const Text("View All"),
                onPressed: () {},
              )
            ],
          ),
        ),
        Container(
          height: 230,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movieList.length,
            itemBuilder: (ctx,i) => MovieCard(index: i),
            // children: [
            //   MovieCard(),
            //   MovieCard(),
            //   MovieCard(),
            //   MovieCard(),
            //   MovieCard(),
            // ],
          ),
        )
      ],
    );
  }
}
