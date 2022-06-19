import 'package:flutter/material.dart';

// Imports for Auth0
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'homepage.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
const FlutterSecureStorage secureStorage = FlutterSecureStorage();

const String AUTH0_ISSUER = 'dev-bpy22x96.us.auth0.com';
const String AUTH0_DOMAIN = 'https://$AUTH0_ISSUER';
const String AUTH0_CLIENT_ID = 'ryyH61QkgKI5KEoB4XA9SR7OlgBFAh6b';
// May not need this:
// const String AUTH0_REDIRECT_URI = 'com.{your domain}.{your app}://login-callback';

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
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: homepage(),
    );
  }
}
