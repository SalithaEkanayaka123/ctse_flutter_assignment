import 'package:ctse_assignment_1/components/leaderboard/leaderboard_card.dart';
import 'package:ctse_assignment_1/screens/quize_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../models/leaderboard_model.dart';
import '../util/QuizeConfig/leaderboard_crud_model.dart';

class LeaderBoard extends StatefulWidget {
  final String id;
  const LeaderBoard({
    Key? key,
    required this.id

  }) : super(key: key);



  @override
  _LeaderBoardState createState() => _LeaderBoardState();

}

class _LeaderBoardState extends State<LeaderBoard> {

  List<LeaderBoardModel> docs1= [];


  List names = ["Bright vachirawit", "Bright vachirawit","Bright vachirawit","Bright vachirawit"];
  List place = ["1st place", "1st place","1st place","1st place"];

  @override
  void initState() {
    super.initState();

    // Previous.
    Provider.of<LeaderBoardCrudModel>(context, listen: false)
        .readLeaderBoard().then((value) => {
      setState(() {
        docs1 = value;
      }),
    });
  }

  bool _isShown = true;

  void _deleteItem(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: const Text('Please Confirm'),
            content: const Text('Are you sure to remove the item?'),
            actions: [
              // The "Yes" button
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    print(widget.id);
                    Provider.of<LeaderBoardCrudModel>(context, listen: false).deleteLeaderboardItem(widget.id.toString());
                    //initState();
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const LeaderBoard(id: "x8MbVVeKSJtPXkspQPn4",)));
                  },
                  child: const Text('Yes')),
              TextButton(
                  onPressed: () {
                    // Close the dialog
                    Navigator.of(context).pop();
                  },
                  child: const Text('No'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // Stream Version.
    Stream<List<LeaderBoardModel>> list = Provider.of<LeaderBoardCrudModel>(context, listen: false)
        .getListOfLeaderBoxes;

    Color getTheRightColor(int index) {
      print(index);
      if (docs1[index].version.toString() == 'Gold') {
          return Colors.pink;
      }
      else if(docs1[index].version.toString() == 'Silver'){
          return Colors.amber;
      }
      else if(docs1[index].version.toString() == 'Bronze'){
          return Colors.purple;
      }
      return const Color.fromARGB(255, 0, 238, 255);

    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Leader Board ",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<List<LeaderBoardModel>>(
        stream: list,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Text("Error");
          } else if (snapshot.hasData){
            final data = snapshot.requireData;
            return ListView.builder(
                itemCount: data.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) => Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                  child: LeaderBoradCard(index: index, model: data[index]),
                )
            );
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        }
      ),
    );
  }
}
