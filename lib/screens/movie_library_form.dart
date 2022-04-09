import 'package:ctse_assignment_1/components/movie/status_tag.dart';
import 'package:ctse_assignment_1/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../models/library_model.dart';
import '../util/crud_model.dart';
import '../util/userAuth/userauthentication.dart';
import 'movie_library_list.dart';

class LibraryForm extends StatefulWidget {
  final int functionValue;
  final String libraryId;
  final String libraryName;
  String? userId; // Put a initial value here if necessary.

  LibraryForm(
      {Key? key,
      required this.functionValue,
      required this.libraryId,
      required this.libraryName})
      : super(key: key);

  @override
  _LibraryFormState createState() => _LibraryFormState();
}

class _LibraryFormState extends State<LibraryForm> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? lname;
  String? color = "4280391411";

  void getColor() {
    int colorInteger = int.parse(color.toString());
    Color newColor = Color(colorInteger);
  }

  // Creating a common navigation method.
  void navigatorMethod() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LibraryList()),
    );
  }

  storeSession() {
    Stream<User?> val = Provider.of<UserAuthentication>(context, listen: false)
        .authStateChanges;
    val.listen((event) => {
          setState(() {
            widget.userId = event!.uid.toString();
          }), //Get the User Id.
        });
  }

  @override
  Widget build(BuildContext context) {
    // Initiation Methods.
    storeSession();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        toolbarHeight: 10,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          height: 500,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.functionValue == 0
                                ? "Create Library"
                                : "Update Library",
                            style: Styles.textSectionHeader,
                          ),
                          Text(
                            "Custom Libraries to Manage Favorite Movies",
                            style: Styles.textSectionSubBody,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      MoviesStatusTag(
                          status: widget.functionValue == 0
                              ? "Inserting"
                              : "Updating",
                          color: widget.functionValue == 0
                              ? Colors.green
                              : Colors.deepOrange),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                Center(
                  child: SizedBox(
                    width: 270, // Adjust Input Field Width.
                    child: TextFormField(
                      initialValue:
                          widget.functionValue == 0 ? "" : widget.libraryName,
                      onChanged: (val) => setState(() => lname = val),
                      decoration: const InputDecoration(
                          labelText: "Enter the Library Name",
                          fillColor: Colors.teal),
                      validator: (value) {
                        if (value!.isEmpty ||
                            !RegExp(r'^[a-zA-Z]+$').hasMatch(value!)) {
                          return "Please enter correct library name";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: TextButton(
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.focused))
                          return Colors.red;
                        return null; // Defer to the widget's default.
                      }),
                    ),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Select the Color"),
                              content: Text("Library Color"),
                              actions: <Widget>[
                                BlockPicker(
                                  pickerColor: Colors.red, //default color
                                  onColorChanged: (Color col) {
                                    //on color picked
                                    setState(
                                        () => color = col.value.toString());
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          });
                    },
                    child: Text('Select Color'),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            primary: Colors.teal,
                            padding: EdgeInsets.all(15)),
                        onPressed: () {
                          if (formKey.currentState!.validate() &&
                              !(color == null)) {
                            // Update and Inserting Logic Separation.
                            if (widget.functionValue == 0) {
                              // Create the Library Model.
                              final library = Library(
                                name: lname.toString(),
                                optional: "optional",
                                id: 'default-id',
                                color: color.toString(),
                                userId: widget.userId.toString(), // Update this userId.
                              );

                              // Printing color.
                              print(color);

                              // Call the DB method to write to the database.
                              Provider.of<CrudModel>(context, listen: false)
                                  .addLibraries(library);
                              Navigator.of(context).pop();
                            } else {
                              // Calling the Database Update Method.
                              Provider.of<CrudModel>(context, listen: false)
                                  .libraryNameUpate(lname.toString(),
                                      widget.libraryId, color.toString());
                              Navigator.of(context).pop();
                            }
                          } else {
                            // Toast Messages are deprecated above Android 11.
                            print("Form Validation Error | Color Not selected");
                            // Replace the Toast with a Pop up window.
                            // Fluttertoast.showToast(
                            //     msg: "This is Center Short Toast",
                            //     toastLength: Toast.LENGTH_SHORT,
                            //     gravity: ToastGravity.CENTER,
                            //     timeInSecForIosWeb: 1,
                            //     backgroundColor: Colors.red,
                            //     textColor: Colors.white,
                            //     fontSize: 16.0
                            // );
                          }
                        },
                        child: Text(
                          widget.functionValue == 0
                              ? "Insert the Libraries"
                              : "Update the Library",
                          style: Styles.navBarTitle,
                        )),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LibraryList()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            primary: Colors.teal,
                            padding: EdgeInsets.all(15)),
                        child: Text(
                          "See All Libraries",
                          style: Styles.navBarTitle,
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
