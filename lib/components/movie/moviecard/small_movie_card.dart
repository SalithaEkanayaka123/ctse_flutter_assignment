import 'package:ctse_assignment_1/models/movie_select_model.dart';
import 'package:flutter/material.dart';

import '../../../models/movie.dart';
import '../../../screens/movie_single.dart';
import '../../../styles.dart';

class MovieCard extends StatelessWidget {
  final int index;
  final SelectedMovieModel movie;
  const MovieCard({Key? key, required this.index, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>  SingleMoviePage(index: 1,movie: movie,)
            ),
          );
        },
        child: Column(
          children: [
            Container(
              height: 140,
              width: 130,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(10.0),
                    topRight: const Radius.circular(10.0),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(movie.imageUrl.toString()),
                  )
              ),
            ),
            Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(movie.title.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Styles.smallCardHeader,
                      ),
                      Text(movie.year,
                        overflow: TextOverflow.ellipsis,
                        style: Styles.textSectionBody,
                      ),
                    ],
                  ),
                ),
                height: 60,
                width: 130,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(10.0),
                    bottomRight: const Radius.circular(10.0),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}
