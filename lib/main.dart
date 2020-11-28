import 'package:bomoco/account_tabs/login.dart';
import 'package:bomoco/bottomNavBar.dart';
import 'package:bomoco/home_tabs/more/affaire_details.dart';
import 'package:bomoco/home_tabs/more/emploi_details.dart';
import 'package:bomoco/home_tabs/more/opportunity_details.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'BottomNavBar/account.dart';
import 'BottomNavBar/authentication.dart';
import 'account_tabs/register.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Racine.routeName: (context) => Racine(),
        Authentication.routeName: (context) => Authentication(),
        Account.routeName: (context) => Account(),
        AffaireDetails.routeName: (context) => AffaireDetails(),
        EmploiDetails.routeName: (context) => EmploiDetails(),
        OpportunityDetails.routeName: (context) => OpportunityDetails(),
      },
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => new _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
        seconds: 8,
        navigateAfterSeconds: Authentication(),
        title: new Text('Evoluons main dans la main'),
        image: new Image.asset('assets/images/logo.gif'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 180.0,
        loaderColor: Colors.orange);
  }
}
