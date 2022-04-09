import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/movie_select_model.dart';

class SelectableMovie extends StatefulWidget {
  final SelectedMovieModel selectedMovieModel;
  final List<SelectedMovieModel> selectedMoviesListRef;

  const SelectableMovie(
      {Key? key,
      required this.selectedMovieModel,
      required this.selectedMoviesListRef})
      : super(key: key);

  @override
  State<SelectableMovie> createState() => _SelectableMovieState();
}

class _SelectableMovieState extends State<SelectableMovie> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        top: 5,
        right: 8,
        bottom: 5,
      ),
      child: InkWell(
        onTap: (){
          setState(() {
            widget.selectedMovieModel.isSelected = !widget.selectedMovieModel.isSelected;
            if(widget.selectedMovieModel.isSelected == true){
              widget.selectedMoviesListRef.add(widget.selectedMovieModel);
            } else if (widget.selectedMovieModel.isSelected == false){
              widget.selectedMoviesListRef.removeWhere((element) =>element.title == widget.selectedMovieModel.title);
            }
          });
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.selectedMovieModel.imageUrl),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 8,
                  ),
                ]
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 60,
                width: query.size.width * (77/100),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 2,
                      blurRadius: 8,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.selectedMovieModel.title, // Change to name.
                              style: TextStyle(fontWeight: FontWeight.w600),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(widget.selectedMovieModel.year.toString(),
                              overflow: TextOverflow.ellipsis,),
                          ],
                        ),
                      ),
                      widget.selectedMovieModel.isSelected
                          ? Icon(
                        Icons.check_circle,
                        color: Colors.grey,
                      ) : Icon(
                        Icons.check_circle_outline,
                        color: Colors.grey,
                      ),
                    ],
                  )
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}
