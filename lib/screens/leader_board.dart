import 'package:ctse_assignment_1/components/leaderboard/leaderboard_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../models/leaderboard_model.dart';
import '../styles.dart';
import '../util/QuizeConfig/leaderboard_crud_model.dart';

class LeaderBoard extends StatefulWidget {
  final String? id;
  const LeaderBoard({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  _LeaderBoardState createState() => _LeaderBoardState();
}

class _LeaderBoardState extends State<LeaderBoard> {
  List<LeaderBoardModel> docs1 = [];

  @override
  void initState() {
    super.initState();

    Provider.of<LeaderBoardCrudModel>(context, listen: false)
        .readLeaderBoard()
        .then((value) => {
              setState(() {
                docs1 = value;
              }),
            });
  }

  @override
  Widget build(BuildContext context) {
    // Stream Version.
    Stream<List<LeaderBoardModel>> list =
        Provider.of<LeaderBoardCrudModel>(context, listen: false)
            .getListOfLeaderBoxes;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0,
          toolbarHeight: 10,
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "LeaderBoard",
                      style: Styles.textSectionHeader,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: StreamBuilder<List<LeaderBoardModel>>(
                    stream: list,
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("Error");
                      } else if (snapshot.hasData) {
                        final data = snapshot.requireData;
                        return ListView.builder(
                            itemCount: data.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 2.0),
                                  child: LeaderBoradCard(
                                      index: index, model: data[index]),
                                ));
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
            ],
          ),
        )
        );
  }
}
