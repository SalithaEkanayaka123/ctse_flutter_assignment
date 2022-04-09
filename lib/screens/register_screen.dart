import 'package:ctse_assignment_1/models/user.dart';
import 'package:ctse_assignment_1/screens/login_screen.dart';
import 'package:ctse_assignment_1/util/userAuth/userauthentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';

import '../styles.dart';
import '../util/User/UserCRUDModel.dart';

class RegisterScreen extends StatefulWidget {

  String? userName, password;
  RegisterScreen({Key? key,  this.userName,  this.password})
      : super(key: key);
  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen  extends State<RegisterScreen>{

  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? uname;
  String? passwordVal;
  String? emailadd;
  final String _regxPattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  int initialAgeValue = 1;
  var itemList = new List<int>.generate(100, (i) => i + 1);

  void AddUserToDB(String emailadd ,String uname , int  initialAgeValue, String  passwordVal){
    var value = Provider.of<UserAuthentication>(context, listen: false).registerUser(emailadd!, passwordVal!);
    UserAuthentication val = Provider.of<UserAuthentication>(context, listen: false);
    Stream<User?> val1 = Provider.of<UserAuthentication>(context, listen: false).authStateChanges;
    if(val1 != null){
      val1.listen((event) {
        print(event?.uid);
        setState(() {
          Users user =  new Users(id: event!.uid.toString(), email: emailadd!, userName: uname!, profileUrl: '', age: initialAgeValue.toString());
          Provider.of<UserCRUDModel>(context, listen: false).insertUserData(user).then((value) =>
          {
            print(value)
          });
        });
      });
      _showMyDialog();
    }
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success..!!'),
          backgroundColor: Color(0xffc5f7fa),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('You Have Registered successfully.'),
                Text('Please Login to continue.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff0DD6E3),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        toolbarHeight: 10,
        ),
        body: Padding(
          padding: EdgeInsets.all(0),
            child: Container(
              height: 500,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      color:  Color(0xff0DD6E3),
                      height: 420,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.vertical(top: Radius.zero, bottom: Radius.zero),
                      // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                          color: Color(0xffffffff),
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                      ),
                                      child: const FlutterLogo(
                                        size: 60,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Welcome Movie Quiz',
                                        style: Styles.mainWelcomeText,

                                      ),
                                      Text(
                                        'Welcome Movie Quize',
                                        style: Styles.subWelcomeText,)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                              width: 300,
                              height: 50,
                              child: TextField(
                                onChanged: (val) => setState(() => uname = val),

                                decoration: InputDecoration(
                                  labelText: "Enter Username",
                                  filled: true,
                                  fillColor: Color(0xffffffff),
                                  border: OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors.red),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                // border: Border.all(color: Colors.black, width: 4),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              child: SizedBox(
                                child:TextField(
                                  // decoration: const InputDecoration(
                                  //   labelText: "Enter Email Address",
                                  //   filled: true,
                                  //   fillColor: Color(0xffffffff),
                                  //   border:  InputBorder.none,
                                  // ),
                                  obscureText: true,
                                  enableSuggestions: false,
                                  autocorrect: false,
                                  decoration: InputDecoration(
                                    labelText: "Enter Password",
                                    filled: true,
                                      fillColor: Color(0xffffffff),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onChanged: (val) => setState(() => passwordVal = val),
                                ),
                              )
                            ),
                          ),Center(
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                                width: 300,
                                height: 50,
                                decoration: BoxDecoration(
                                // border: Border.all(color: Colors.black, width: 4),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              child: SizedBox(
                                child:TextField(
                                  // decoration: const InputDecoration(
                                  //   labelText: "Enter Email Address",
                                  //   filled: true,
                                  //   fillColor: Color(0xffffffff),
                                  //   border:  InputBorder.none,
                                  // ),
                                  decoration: InputDecoration(
                                    labelText: "Enter Email Address",
                                    filled: true,
                                      fillColor: Color(0xffffffff),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  onChanged: (val) => setState(() => emailadd = val),
                                ),
                              )
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 2),
                              padding: EdgeInsets.symmetric(horizontal: 14,vertical: 1),
                              width: 300, // Adjust Input Field Width.
                                decoration: BoxDecoration(
                                  // border: Border.all(color: Colors.black, width: 4),
                                  borderRadius: BorderRadius.circular(12),
                                  color: const Color(0xffffffff)
                                ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                isExpanded: true,
                                iconSize: 36,
                                icon: Icon(Icons.arrow_drop_down_circle_outlined, color: Color(0xff0DD6E3)),
                                borderRadius: BorderRadius.circular(12),
                                dropdownColor: const Color(0xffffffff),
                                items: itemList.map((itemName) {
                                  return DropdownMenuItem(
                                    value: itemName,
                                      child: Text(itemName.toString())
                                  );
                                }).toList(),
                                onChanged: (int? newValue) {
                                  setState(() {
                                    initialAgeValue = newValue!;
                                  });
                                },
                                value: initialAgeValue,
                              )
                              )
                            ),
                          ),
                          Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child: GestureDetector(
                                  onTap: (){
                                    Navigator.push(context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginScreen()
                                      ),
                                    );
                                  },
                                  child: Text('Or Login',
                                    style: Styles.subWelcomeText),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 25),
                            primary: Styles.primaryThemeColor,
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5)),

                        onPressed: (){
                           AddUserToDB(emailadd! ,uname! , initialAgeValue,  passwordVal! );
                        },
                        child: const Text('Start'),
                      ),
                    ),
                  ],
                ),
              ),
          )
        )
    );
  }

}