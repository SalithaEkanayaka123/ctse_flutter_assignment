import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ctse_assignment_1/models/movie_select_model.dart';
import 'package:flutter/cupertino.dart';
import '../models/library_model.dart';
import '../models/movie.dart';

class CrudModel extends ChangeNotifier {
  final Stream<QuerySnapshot> _movieStream =
      FirebaseFirestore.instance.collection('movies').snapshots();

  // Testing Constructor.
  CrudModel();

  // Getter for the User Steam.
  Stream<QuerySnapshot> get movies {
    return _movieStream;
  }

  // Getter for the private testing variable.
  Stream<List<Movie>> get getListOfMovies {
    Stream<QuerySnapshot> movieStreams =
        FirebaseFirestore.instance.collection('movies').snapshots();

    return movieStreams.map((event) => event.docs
        .map((e) => Movie(
              id: e["id"] ?? '',
              title: e["title"] ?? "default",
              imageUrl: e["imageUrl"] ?? "default",
              description: e["description"] ?? "default",
              rating: e["rating"] ?? "default",
              year: e["year"] ?? "default",
              duration: e["duration"] ?? "default",
            ))
        .toList());
  }

  // Getter for the list of movies (Short hand method.) - Not yet tested.
  Stream<List<Movie>> get getListOfMoviesShort {
    return FirebaseFirestore.instance.collection("movies").snapshots().map(
        (event) => event.docs.map((e) => Movie.fromMap(e.data())).toList());
  }

  // Getter for the list of movies (Short hand method.) - Not yet tested.
  Stream<List<SelectedMovieModel>> getListOfMoviesShortSelectable(
      String libraryId) {
    return FirebaseFirestore.instance.collection("movies").snapshots().map(
        (event) => event.docs
            .map((e) => SelectedMovieModel.fromMap(e.data(), e.id, libraryId))
            .toList());
  }

  // Method to add libraries to the Firebase.
  Future addLibraries(Library library) async {
    final addLibrary = FirebaseFirestore.instance.collection("libraries").doc();
    library.id = addLibrary.id;
    print("File Inserted " + addLibrary.id);
    final json = library.toJson();
    await addLibrary.set(json);
  }

  // Get a List of Libraries.
  Stream<List<Library>> get getListOfLibraries {
    return FirebaseFirestore.instance.collection("libraries").snapshots().map(
        (event) =>
            event.docs.map((e) => Library.fromMap(e.data(), e.id)).toList());
  }

  // Get Movies from a particular library.
  Stream<List<SelectedMovieModel>> getMoviesFromLibrary(String id) {
    return FirebaseFirestore.instance
        .collection("library-movies")
        .where("libraryId", isEqualTo: id)
        .snapshots()
        .map((event) => event.docs
            .map((e) => SelectedMovieModel.fromMap(
                e.data(), e.id, "eq18RJ9oVM8LvmdvBayB"))
            .toList());
  }

  // Bulk Insert method to insert data to libraries (Batch).
  Future addMoviesTotheLibrary (List<SelectedMovieModel> selectedMovieList) async{
    if(selectedMovieList.isEmpty){
      print("Selected Movie List is Empty");
    } else {
      final movieRef = FirebaseFirestore.instance.collection("library-movies");
      WriteBatch movieBatch = FirebaseFirestore.instance.batch();
      for (SelectedMovieModel movie in selectedMovieList){
        final newLibraryMovie = movieRef.doc();
        movie.id = newLibraryMovie.id;
        final json = movie.toJson();
        movieBatch.set(newLibraryMovie, json);
      }
      movieBatch.commit();
    }
  }

  // Library Name Update method
  Future libraryNameUpate(String newName, String libraryId) async {
    final doc =
        FirebaseFirestore.instance.collection("libraries").doc(libraryId);
    doc.update({
      "name": newName,
    });
  }

// Library Home Movies clean up method (Batch) - Do this after insert. - PROTO
  Future<void> cleanUpLibraryUponDelete(String libraryId) async {

    // Method troubleshooting block
    // - print("Library Id $libraryId");

    final movies = await FirebaseFirestore.instance.collection("library-movies").where("libraryId", isEqualTo: libraryId).get();

    // QuerySnap shot troubleshooting
    // - print(movies);
    // - print(movies.size);

    WriteBatch batch = FirebaseFirestore.instance.batch();
    for (final doc in movies.docs){
      // - print(doc.get("title"));
      batch.delete(doc.reference);
    }
    return batch.commit();
  }


// Library Home Movie Delete method.
    Future deleteLibraryMovie(String libraryId) async {
      final doc =
      FirebaseFirestore.instance.collection("library-movies").doc(libraryId);
      doc.delete();
    }

// Library Delete method.
 Future deleteLibrary(String libraryId) async {
   final doc =
   FirebaseFirestore.instance.collection("libraries").doc(libraryId);
   doc.delete();
 }
}
