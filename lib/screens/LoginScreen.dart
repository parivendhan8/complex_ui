import 'package:Complex_ui/resouces/firebase_repository.dart';
import 'package:Complex_ui/screens/HomeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseRepository _firebaseRepository = FirebaseRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: loginButton(),
    );
  }

  Widget loginButton() {
    return FlatButton(
        padding: EdgeInsets.all(25),
        onPressed: performLogin,
        child: Center(
          child: Text(
            'Login',
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 25, letterSpacing: 1.2),
          ),
        ));
  }
  void  performLogin(){
    _firebaseRepository.signIn().then((value) {
      if(value != null){
        authenticateUser(value);
      } else {
        print('ERROR');
      }
    });

  }

  void authenticateUser(FirebaseUser value) {
    _firebaseRepository.authenticateUser(value).then((isNew){
      if(isNew){
        _firebaseRepository.addDataToDb(value).then((value) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
        });
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
      }
    });
  }
}
