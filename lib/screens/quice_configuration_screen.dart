import 'package:ctse_assignment_1/screens/quize_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../components/form_dropdown/Scrollbar.dart';
import '../components/form_dropdown/ExpandedListAnimationWidget.dart';
import '../util/QuizeConfig/quize_list_crud_model.dart';

class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  _DropDownState createState() => _DropDownState();
}
List <String> _list =['Action',"Romance","Thriller",'Animation', "Comedy", "Horror"];
List <String> _list2 =['2',"3","5",'7', '10'];
List <String> _list3 =['10',"15","20", "30"];

class _DropDownState extends State<DropDown> {
  bool isStrechedDropDown = false;
  bool isStrechedDropDown2 = false;
  bool isStrechedDropDown3 = false;

  String title = 'Select Movie Category';
  String title2 = 'Select No of questions';
  String title3 = 'Select time';

  String? category;
  int? questions, time;

  // Radio button values.
  int? categoryRadioValue, questionRadioValue, timeRadioValue;

  void onPress () {
    print(category);
    Provider.of<QuizListCrudModel>(context, listen: false).insertQuizListData(category, questions, time)
        .then((value) {
          
      if(value != 0){
        Alert(
          context: context,
          type: AlertType.success,
          desc: "Successfully added data",
          buttons: [
            DialogButton(
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: (){
                Navigator.of(context, rootNavigator: true).pop(); // New Pop Method.
                Navigator.push(context, MaterialPageRoute(builder: (context) => QuizeList()));
              },
              color: Color.fromRGBO(91, 55, 185, 1.0),
              radius: BorderRadius.circular(10.0),
            ),
          ],
        ).show();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(160),
          child: AppBar(
            centerTitle: true,
            flexibleSpace: ClipRRect(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(30), bottomLeft: Radius.circular(30)),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/h2.jpg"),
                        fit: BoxFit.fill,
                    )
                ),
              ),
            ),
            title: Text(
              "Quice Configuration",
              style: TextStyle(
                color: Colors.black45, fontWeight: FontWeight.bold, fontSize: 25),
            ),
            backgroundColor: Colors.pink,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(50), bottomLeft: Radius.circular(50))
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 60),
            child: SafeArea(
              child: Column(
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(left: 5.0, bottom: 5.0, top: 5.0),
                          child: Text(
                            "Enter Movie Category",
                             style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.teal),
                                      borderRadius: BorderRadius.all(Radius.circular(12))),
                                  child: Column(
                                    children: [
                                      Container(
                                          width: double.infinity,
                                          padding: EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.teal,
                                              ),
                                              borderRadius:
                                              BorderRadius.all(Radius.circular(10))),
                                          constraints: BoxConstraints(
                                            minHeight: 45,
                                            minWidth: double.infinity,
                                          ),
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 20, vertical: 10),
                                                  child:
                                                  Text(
                                                    title,
                                                    style: TextStyle(color: Colors.black45),
                                                  ),
                                                ),
                                              ),
                                              GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      isStrechedDropDown =
                                                      !isStrechedDropDown;
                                                    });
                                                  },
                                                  child: Icon(isStrechedDropDown
                                                      ? Icons.arrow_upward
                                                      : Icons.arrow_downward))
                                            ],
                                          )),
                                      ExpandedSection(
                                        expand: isStrechedDropDown,
                                        height: 100,
                                        child: MyScrollbar(
                                          builder: (context, scrollController2) =>
                                              ListView.builder(
                                                  padding: EdgeInsets.all(0),
                                                  controller: scrollController2,
                                                  shrinkWrap: true,
                                                  itemCount: _list.length,
                                                  itemBuilder: (context, index) {
                                                    return RadioListTile(
                                                        title: Text(_list.elementAt(index)),
                                                        value: index,
                                                        groupValue: categoryRadioValue,
                                                        onChanged: (val) {
                                                          if (val == 0) {
                                                            setState(() {
                                                              category =
                                                              'Action';
                                                              title = _list.elementAt(index);
                                                              categoryRadioValue = 0;
                                                            });
                                                          } else if (val == 1) {
                                                            setState(() {
                                                              category =
                                                              'Romance';
                                                              title = _list.elementAt(index);
                                                              categoryRadioValue = 1;
                                                            });
                                                          }
                                                          else if (val == 2) {
                                                            setState(() {
                                                              category =
                                                              'Thriller';
                                                              title = _list.elementAt(index);
                                                              categoryRadioValue = 2;
                                                            });
                                                          }
                                                          else if (val == 3) {
                                                            setState(() {
                                                              category =
                                                              'Animation';
                                                              title = _list.elementAt(index);
                                                              categoryRadioValue = 3;
                                                            });
                                                          }
                                                          else if (val == 4) {

                                                            setState(() {
                                                              category =
                                                              'Comedy';
                                                              title = _list.elementAt(index);
                                                              categoryRadioValue = 4;
                                                            });
                                                          }
                                                          else if (val == 5) {
                                                            setState(() {
                                                              category =
                                                              'Horror';
                                                              title = _list.elementAt(index);
                                                              categoryRadioValue = 5;
                                                            });
                                                          }
                                                        }
                                                        );
                                                  }),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 5.0, bottom: 5.0, top: 5.0),
                        child: Text(
                          "Enter no of questions",
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.teal),
                                    borderRadius: BorderRadius.all(Radius.circular(12))),
                                child: Column(
                                  children: [
                                    Container(
                                      // height: 45,
                                        width: double.infinity,
                                        padding: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.teal,
                                            ),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(10))),
                                        constraints: BoxConstraints(
                                          minHeight: 45,
                                          minWidth: double.infinity,
                                        ),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 20, vertical: 10),
                                                child: Text(
                                                  title2,
                                                  style: TextStyle(color: Colors.black45),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isStrechedDropDown2 =
                                                    !isStrechedDropDown2;
                                                  });
                                                },
                                                child: Icon(isStrechedDropDown2
                                                    ? Icons.arrow_upward
                                                    : Icons.arrow_downward))
                                          ],
                                        )),
                                    ExpandedSection(
                                      expand: isStrechedDropDown2,
                                      height: 100,
                                      child: MyScrollbar(
                                        builder: (context, scrollController2) =>
                                            ListView.builder(
                                                padding: EdgeInsets.all(0),
                                                controller: scrollController2,
                                                shrinkWrap: true,
                                                itemCount: _list2.length,
                                                itemBuilder: (context, index) {
                                                  return RadioListTile(
                                                      title: Text(_list2.elementAt(index)),
                                                      value: index,
                                                      groupValue: questionRadioValue,

                                                      onChanged: (val) {
                                                        if (val == 0) {
                                                          setState(() {
                                                            questions =
                                                            2;
                                                            questionRadioValue = 0;
                                                            title2 = _list2.elementAt(index);
                                                          });
                                                        } else if (val == 1) {
                                                          setState(() {
                                                            questions =
                                                            3;
                                                            questionRadioValue = 1;
                                                            title2 = _list2.elementAt(index);
                                                          });
                                                        }
                                                        else if (val == 2) {
                                                          setState(() {
                                                            questions =
                                                            5;
                                                            questionRadioValue = 2;
                                                            title2 = _list2.elementAt(index);
                                                          });
                                                        }
                                                        else if (val == 3) {
                                                          setState(() {
                                                            questions =
                                                            7;
                                                            questionRadioValue = 3;
                                                            title2 = _list2.elementAt(index);
                                                          });
                                                        }
                                                        else if (val == 4) {
                                                          setState(() {
                                                            questions =
                                                            10;
                                                            questionRadioValue = 4;
                                                            title2 = _list2.elementAt(index);
                                                          });
                                                        }
                                                      }
                                                      );
                                                }),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 5.0, bottom: 5.0, top: 5.0),
                        child: Text(
                          "Enter Time",
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.teal),
                                    borderRadius: BorderRadius.all(Radius.circular(12))),
                                child: Column(
                                  children: [
                                    Container(
                                      // height: 45,
                                        width: double.infinity,
                                        padding: EdgeInsets.only(right: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.teal,
                                            ),
                                            borderRadius:
                                            BorderRadius.all(Radius.circular(10))),
                                        constraints: BoxConstraints(
                                          minHeight: 45,
                                          minWidth: double.infinity,
                                        ),
                                        alignment: Alignment.center,
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 20, vertical: 10),
                                                child: Text(
                                                  title3,
                                                  style: TextStyle(color: Colors.black45),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    isStrechedDropDown3 =
                                                    !isStrechedDropDown3;
                                                  });
                                                },
                                                child: Icon(isStrechedDropDown3
                                                    ? Icons.arrow_upward
                                                    : Icons.arrow_downward))
                                          ],
                                        )),
                                    ExpandedSection(
                                      expand: isStrechedDropDown3,
                                      height: 100,
                                      child: MyScrollbar(
                                        builder: (context, scrollController3) =>
                                            ListView.builder(
                                                padding: EdgeInsets.all(0),
                                                controller: scrollController3,
                                                shrinkWrap: true,
                                                itemCount: _list3.length,
                                                itemBuilder: (context, index) {
                                                  return RadioListTile(
                                                      title: Text(_list3.elementAt(index)),
                                                      value: index,
                                                      groupValue: timeRadioValue,
                                                      onChanged: (val) {
                                                        if (val == 0) {
                                                          setState(() {
                                                            time =
                                                            10;
                                                            timeRadioValue = 0;
                                                            title3 = _list3.elementAt(index);
                                                          });
                                                        } else if (val == 1) {
                                                          setState(() {
                                                            time =
                                                            15;
                                                            timeRadioValue = 1;
                                                            title3 = _list3.elementAt(index);
                                                          });
                                                        }
                                                        else if (val == 2) {
                                                          setState(() {
                                                            time =
                                                            20;
                                                            timeRadioValue = 2;
                                                            title3 = _list3.elementAt(index);
                                                          });
                                                        }
                                                        else if (val == 3) {
                                                          setState(() {
                                                            time =
                                                            30;
                                                            timeRadioValue = 3;
                                                            title3 = _list3.elementAt(index);
                                                          });
                                                        }
                                                      }
                                                      );
                                                }),
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 10),
                  Column(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(90, 45),
                            textStyle: TextStyle(fontSize: 15),
                            primary: Colors.teal,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text('Add Label'),
                          onPressed: onPress
                        ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(90, 45),
                          textStyle: TextStyle(fontSize: 15),
                          primary: Colors.teal,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QuizeList()),
                          );
                        },
                        child: const Text(
                          'Quiz List',
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
