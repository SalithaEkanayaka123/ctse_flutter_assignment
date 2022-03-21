import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctse_assignment_1/models/movie_select_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/movie/moviecard/movie_select.dart';
import '../styles.dart';
import '../util/crud_model.dart';

class MovieMultiSelect extends StatefulWidget {
  final String libraryId;
  const MovieMultiSelect({Key? key, required this.libraryId}) : super(key: key);

  @override
  _MovieMultiSelectState createState() => _MovieMultiSelectState();
}

class _MovieMultiSelectState extends State<MovieMultiSelect> {
  List<SelectedMovieModel> selectedMovies = [];

  // Temporary Hard coded Array List;

  /// Drop this model and replaced it with the movies model.

  List<SelectedMovieModel> selectableMovies = [

  ];

  @override
  Widget build(BuildContext context) {
    // Importing the movies from Provider.
    Stream<List<SelectedMovieModel>> movies =
        Provider.of<CrudModel>(context, listen: false).getListOfMoviesShortSelectable(widget.libraryId);

    // Importing Movie List from The Steam - Prototype.


    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Multi Select"),
      ),
      body:
        SafeArea(child: Column(
          children: [
            Flexible(
              flex: 9,
              child: StreamBuilder<List<SelectedMovieModel>>(
                stream: movies,
                builder: (context, snapshot) {
                  if(snapshot.hasError){
                    return Text("Snapshot contains error!", style: Styles.textSectionSubBody,);
                  } else if (snapshot.hasData){
                    final movies = snapshot.data;
                    return ListView.builder(
                      itemCount: movies?.length,
                      itemBuilder: (BuildContext context, int index){
                        return SelectableMovie(selectedMovieModel: movies![index], selectedMoviesListRef: selectedMovies);
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator(),);
                  }
                }
              ),
            ),
            Flexible(
              flex: 1,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 10,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Colors.teal,
                      padding: EdgeInsets.all(15)
                  ),
                  onPressed: () {
                    Provider.of<CrudModel>(context, listen: false)
                        .addMoviesTotheLibrary(selectedMovies);
                  },
                  child: const Text("Add Movies to the Library"),
                ),
              ),
            )
          ],
        ),

        )
    );
  }
}
