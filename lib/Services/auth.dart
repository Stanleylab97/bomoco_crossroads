import 'package:bomoco/models/userbuilder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  static   signUp(String email, String password) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email, password: password);

     /*  Map<String, String> newUser = {
        'intitule':userBuilder.utilisateur.intitule,
        'domaine':userBuilder.utilisateur.domaine,
        'typeIntervention':userBuilder.utilisateur.typeIntervention,
        'activity':userBuilder.utilisateur.activity,
        'cibles':userBuilder.utilisateur.cible
      };

      users
          .add(newUser)
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error")); */
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  static signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  static signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
