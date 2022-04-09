import 'package:ctse_assignment_1/bottom_navigation/app.dart';
import 'package:ctse_assignment_1/screens/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../styles.dart';
import '../util/userAuth/userauthentication.dart';

class LoginScreen extends StatefulWidget {
  String? emailadd, password;

  LoginScreen({Key? key,  this.emailadd,  this.password})
      : super(key: key);
  @override
  _LoginScreen createState() => _LoginScreen();
}



class _LoginScreen extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  String? emailadd, password;
  String? ErrorMsg = '';

  Future<void> alertDialogBox() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          backgroundColor: Color(0xffc5f7fa),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Email or Password empty'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    void loginUserMethod(String email, String pwd) {
      bool pattern = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
      if(pattern){
        Provider.of<UserAuthentication>(context, listen: false).logInUser(emailadd!, pwd!);
        Stream<User?> val = Provider.of<UserAuthentication>(context, listen: false).authStateChanges;
        val.listen((event) {
          print('event email $event.email');
          if(event != null){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => App()),
            );
          }else{
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RegisterScreen()),
            );
          }
        });
      } else {
        print('fail');
      }



    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 0,
        toolbarHeight: 10,
      ),
    body: Container(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Container(
                color:  Color(0xff0DD6E3),
                padding: EdgeInsets.symmetric(vertical: 10 ,horizontal: 0),
                width: 1000,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
              Container(
                width: 800,
                height: 220,
                decoration: const BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/cinemaz.jpeg",
                      ),
                      fit: BoxFit.fill),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(4, 8, 4, 4),
                padding: EdgeInsets.symmetric(vertical: 0 ,horizontal: 10),
                child: SizedBox(
                  child: TextField(
                    onChanged: (val) => setState(() => emailadd = val.trim()),
                    decoration: InputDecoration(
                      labelText: "Enter Email Address",
                      filled: true,
                      fillColor: Color(0xffffffff),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(4, 8, 4, 0),
                padding: EdgeInsets.symmetric(vertical: 0 ,horizontal: 10),
                child: SizedBox(
                  child: TextField(
                    onChanged: (val) => setState(() => password = val),
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
                  ),
                ),
              ),
              SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20),
                        primary: Styles.primaryThemeColor,
                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5)),
                    onPressed: () {
                      if(emailadd == null || password == null ){
                        alertDialogBox();
                        return;
                      } else{
                        loginUserMethod(emailadd!, password!);
                      }
                    },
                    child: const Text('Login'),
                  )
              ), SizedBox(
                child: ElevatedButton(
                  child: const Text('Register Here'),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => RegisterScreen()),
                    );
                  },
                ),
              )
            ],

          ),
        ),
      )
    );

  }
}

