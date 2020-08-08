import 'package:Complex_ui/resouces/firebase_repository.dart';
import 'package:Complex_ui/screens/HomeScreen.dart';
import 'package:Complex_ui/screens/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FirebaseRepository _firebaseRepository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Skype App',
        home: FutureBuilder(
          future: _firebaseRepository.getCurrentUser(),
          builder: (context,  snapshot) {
            if (snapshot.hasData) {
              return HomeScreen();
            } else {
              return LoginScreen();
            }
          },
        )
    );
  }
}
