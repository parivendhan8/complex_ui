
import 'package:Complex_ui/models/user.dart';
import 'package:Complex_ui/utils/utilities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseMethods {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Firestore fireStore = Firestore.instance;
  User _user = User();



  Future<FirebaseUser> getCurrentUser() async {
    return await _firebaseAuth.currentUser();
  }



  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _authentication = await _googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: _authentication.idToken,
        accessToken: _authentication.accessToken);
    FirebaseUser _user;
   return _user = (await _firebaseAuth.signInWithCredential(credential)).user;
  }

  Future<bool> authenticateUser(FirebaseUser user) async{
    QuerySnapshot snapshot = await fireStore.collection('users')
        .where('email', isEqualTo: user.email)
        .getDocuments();

    final List<DocumentSnapshot> docs = snapshot.documents;
    return docs.length == 0 ? true : false;

  }

  Future<void> addDataToDb(FirebaseUser user) async{

    String email = Utils.getUserName(user.email);

    _user = User(
      uid: user.uid,
      name: user.displayName,
      email: user.email,
      profilePhoto: user.photoUrl,
      username: email
    );

    fireStore.collection("users").document(user.uid).setData(_user.toMap(_user));

  }

}