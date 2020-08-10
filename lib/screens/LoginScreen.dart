import 'package:Complex_ui/resouces/firebase_repository.dart';
import 'package:Complex_ui/screens/HomeScreen.dart';
import 'package:Complex_ui/utils/universal_variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseRepository _firebaseRepository = FirebaseRepository();
  bool isLoginPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: Stack(
        children: <Widget>[
          Center(
            child: loginButton(),
          ),
          isLoginPressed ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container()
        ],
      ),
    );
  }

  Widget loginButton() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: UniversalVariables.senderColor,
      child: FlatButton(
        padding: EdgeInsets.all(25),
        onPressed: performLogin,
        child: Center(
          child: Text(
            'LOGIN',
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 25, letterSpacing: 1.2),
          ),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void performLogin() {

    setState(() {
      isLoginPressed = true;
    });

    _firebaseRepository.signIn().then((value) {
      if (value != null) {
        authenticateUser(value);
      } else {
        print('ERROR');
      }
    });
  }

  void authenticateUser(FirebaseUser value) {
    _firebaseRepository.authenticateUser(value).then((isNew) {

      setState(() {
        isLoginPressed = false;
      });

      if (isNew) {
        _firebaseRepository.addDataToDb(value).then((value) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        });
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }
}
