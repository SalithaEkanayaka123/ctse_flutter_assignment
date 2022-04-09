import 'package:ctse_assignment_1/screens/index_page.dart';
import 'package:ctse_assignment_1/screens/login_screen.dart';
import 'package:ctse_assignment_1/screens/movie_library_form.dart';

import 'package:ctse_assignment_1/screens/movie_wiki.dart';

import 'package:ctse_assignment_1/screens/navigation_screen.dart';
import 'package:ctse_assignment_1/screens/register_screen.dart';

import 'package:ctse_assignment_1/util/FeedBack/feed_back_crud_model.dart';
import 'package:ctse_assignment_1/util/Quiz_Result/quiz_result_crud_model.dart';

import 'package:ctse_assignment_1/util/QuizeConfig/leaderboard_crud_model.dart';

import 'package:ctse_assignment_1/util/QuizeConfig/quize_list_crud_model.dart';

import 'package:ctse_assignment_1/util/Quizes/quiz_crud_model.dart';
import 'package:ctse_assignment_1/util/UserHistory/user_history_crud_model.dart';
import 'package:ctse_assignment_1/util/User/UserCRUDModel.dart';
import 'package:ctse_assignment_1/util/crud_model.dart';
import 'package:ctse_assignment_1/util/userAuth/userauthentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'bottom_navigation/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  // if (Firebase.apps.isEmpty) {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   await Firebase.initializeApp(
  //     // Replace with actual values
  //     options: const FirebaseOptions(
  //       apiKey: "",
  //       appId: "1:406029970910:android:4da777d7415dd38630814f",
  //       messagingSenderId: "406029970910",
  //       projectId: "ctse-assignment-1",
  //     ),
  //   );
  // }else {
  //   Firebase.apps; // if already initialized, use that one
  // }
  //
  //
  // runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserAuthentication>(
          create: (_) => UserAuthentication(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<UserAuthentication>().authStateChanges,
          initialData: null,
        ),
        ChangeNotifierProvider(create: (context) => CrudModel()),
        ChangeNotifierProvider(
            create: (context) => UserAuthentication(FirebaseAuth.instance)),
        ChangeNotifierProvider(create: (context) => QuizCrudModel()),
        ChangeNotifierProvider(create: (context) => QuizListCrudModel()),
        ChangeNotifierProvider(create: (context) => FeedBackCrudModel()),
        ChangeNotifierProvider(create: (context) => QuizResultCrudModel()),
        ChangeNotifierProvider(create: (context) => LeaderBoardCrudModel()),
        ChangeNotifierProvider(create: (context) => UserCRUDModel()),
        ChangeNotifierProvider(create: (context) => UserHistoryCrudModel()),
      ],
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            backgroundColor: Colors.black,
          ),
          home:
              RegisterScreen()
             // EditUserForm()
          // App()
          ),
    );
  }
}
