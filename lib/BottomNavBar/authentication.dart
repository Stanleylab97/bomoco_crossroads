import 'package:bomoco/bottomNavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';

class Authentication extends StatefulWidget {
  static const routeName = "authentication";

  Authentication({Key key}) : super(key: key);
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  List<Color> colors = [Color(0xffffff), Colors.orange];
  int _index = 0;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController _login_email = new TextEditingController();
  TextEditingController _login_pass = new TextEditingController();
  TextEditingController _register_email = new TextEditingController();
  TextEditingController _register_pass = new TextEditingController();
  TextEditingController _register_passconfirm = new TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      top: false,
      bottom: false,
      left: false,
      right: false,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: colors,
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/icons/logo.png',
                  width: 220,
                ),
                Tabs(context),
                AnimatedCrossFade(
                  duration: Duration(milliseconds: 150),
                  firstChild: Login(context),
                  secondChild: SignUp(context),
                  crossFadeState: _index == 0
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Widget Login(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
        child: Column(
          children: <Widget>[
            Stack(
                overflow: Overflow.visible,
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 15, right: 15, bottom: 20),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            controller: _login_email,
                            validator: (inputEmail) {
                              if (inputEmail.isEmpty)
                                return 'Entrez votre e-mail';
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.grey,
                                ),
                                labelText: "Entrez votre email",
                                labelStyle: TextStyle(color: Colors.black87),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                          ),
                          Divider(color: Colors.grey, height: 8),
                          TextField(
                            controller: _login_pass,
                            decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.grey,
                                ),
                                labelText: "Mot de passe",
                                labelStyle: TextStyle(color: Colors.black87),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent)),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent))),
                          ),
                          Divider(
                            color: Colors.transparent,
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 140,
                    child: Center(
                      child: GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Center(
                                child: !isLoading
                                    ? Text(
                                        "Connexion",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )
                                    : LoadingBouncingLine.circle(
                                        backgroundColor: Colors.white,
                                        size: 30,
                                        borderColor: Colors.white,
                                      )),
                          ),
                        ),
                        onTap: () async {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                    email: _login_email.text.trim(),
                                    password: _login_pass.text.trim());

                            Navigator.of(context)
                                .pushReplacementNamed(Racine.routeName);
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              setState(() {
                                isLoading = false;
                              });
                              Flushbar(
                                message:
                                    "Désolé! Cet utilisateur n'existe pas.",
                                icon: Icon(
                                  Icons.info_outline,
                                  size: 28.0,
                                  color: Colors.blue[300],
                                ),
                                duration: Duration(seconds: 3),
                                leftBarIndicatorColor: Colors.blue[300],
                              )..show(context);
                              // print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              setState(() {
                                isLoading = false;
                              });
                              Flushbar(
                                message: "Mot de passe incorrect",
                                icon: Icon(
                                  Icons.info_outline,
                                  size: 28.0,
                                  color: Colors.blue[300],
                                ),
                                duration: Duration(seconds: 3),
                                leftBarIndicatorColor: Colors.blue[300],
                              )..show(context);
                              //print('Wrong password provided for that user.');
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ]),
            Padding(
              padding: const EdgeInsets.only(top: 45.0),
              child: GestureDetector(
                child: Center(
                    child: Text(
                  "Mot de passe oublié ?",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )),
                onTap: () {
                  print("Changing password");
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget SignUp(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, left: 15, right: 15),
      child: Column(
        children: <Widget>[
          Stack(
              overflow: Overflow.visible,
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, left: 15, right: 15, bottom: 20),
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: _register_email,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.email,
                                color: Colors.grey,
                              ),
                              labelText: "Entrez voitre email",
                              labelStyle: TextStyle(color: Colors.black87),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent))),
                        ),
                        Divider(color: Colors.grey, height: 8),
                        TextField(
                          controller: _register_pass,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              labelText: "Mot de passe",
                              labelStyle: TextStyle(color: Colors.black87),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent))),
                        ),
                        Divider(color: Colors.grey, height: 8),
                        TextField(
                          controller: _register_passconfirm,
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Colors.grey,
                              ),
                              labelText: "Confirmez le mot de passe",
                              labelStyle: TextStyle(color: Colors.black87),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent))),
                        ),
                        Divider(
                          color: Colors.transparent,
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 210,
                  child: Center(
                    child: GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0),
                            child: Center(
                                child: !isLoading
                                    ? Text(
                                        "Inscription",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      )
                                    : LoadingBouncingLine.circle(
                                        backgroundColor: Colors.white,
                                        size: 30,
                                        borderColor: Colors.white,
                                      )),
                          ),
                        ),
                        onTap: () async {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                    email: _register_email.text.trim(),
                                    password: _register_pass.text.trim());

                            Navigator.of(context)
                                .pushReplacementNamed(Racine.routeName);
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
                              setState(() {
                                isLoading = false;
                              });
                              Flushbar(
                                message:
                                    "Mot de passe trop court. Saisissez au moins 6 caractères",
                                icon: Icon(
                                  Icons.info_outline,
                                  size: 28.0,
                                  color: Colors.blue[300],
                                ),
                                duration: Duration(seconds: 3),
                                leftBarIndicatorColor: Colors.blue[300],
                              )..show(context);
                              //print('The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              setState(() {
                                isLoading = false;
                              });
                              Flushbar(
                                message: "Cette adresse e-mail est déjà prise",
                                icon: Icon(
                                  Icons.info_outline,
                                  size: 28.0,
                                  color: Colors.blue[300],
                                ),
                                duration: Duration(seconds: 3),
                                leftBarIndicatorColor: Colors.blue[300],
                              )..show(context);
                              //print('The account already exists for that email.');
                            }
                          } catch (e) {
                            setState(() {
                              isLoading = false;
                            });
                            //print(e);
                            Flushbar(
                              message: "$e",
                              icon: Icon(
                                Icons.info_outline,
                                size: 28.0,
                                color: Colors.blue[300],
                              ),
                              duration: Duration(seconds: 3),
                              leftBarIndicatorColor: Colors.blue[300],
                            )..show(context);
                          }
                        }),
                  ),
                ),
              ]),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Rejoignez notre communauté",
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget Tabs(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 30.0, left: 15, right: 15),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.12),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                          color:
                              _index == 0 ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Ancien",
                          style: TextStyle(
                              color: _index == 0 ? Colors.black : Colors.white,
                              fontSize: 18,
                              fontWeight: _index == 0
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ))),
                  onTap: () {
                    setState(() {
                      _index = 0;
                    });
                  },
                ),
              ),
              Expanded(
                child: GestureDetector(
                  child: Container(
                      decoration: BoxDecoration(
                          color:
                              _index == 1 ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(25)),
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Nouveau",
                          style: TextStyle(
                              color: _index == 1 ? Colors.black : Colors.white,
                              fontSize: 18,
                              fontWeight: _index == 1
                                  ? FontWeight.bold
                                  : FontWeight.normal),
                        ),
                      ))),
                  onTap: () {
                    setState(() {
                      _index = 1;
                    });
                  },
                ),
              )
            ],
          )),
    );
  }
}
