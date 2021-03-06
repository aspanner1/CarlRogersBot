import 'package:flutter/material.dart';
import 'package:mental_hacks/loginpage.dart';

import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
     
      initialRoute: "/",
      routes: {
        "/":(context) => LoginPage(),
      },
     
    );
  }
}
