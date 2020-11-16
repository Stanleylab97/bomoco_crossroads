import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomCenter,
                    colors: [Colors.orange, Colors.pinkAccent])),
            child: Container(
              width: double.infinity,
              height: size.height * .37,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://fondationclaudinetalon.org/wp-content/uploads/2020/03/LOGO_FCT_couleurs.png",
                      ),
                      radius: 50.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Fondation Claudine Talon",
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Domaines",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Education",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.pinkAccent,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Cibles",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Filles",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.pinkAccent,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Zones",
                                    style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Text(
                                    "Afrique|Chine|Argentine|Brésil",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.pinkAccent,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
        Container(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Mission:",
                  style: TextStyle(
                      color: Colors.orange,
                      fontStyle: FontStyle.normal,
                      fontSize: 20.0),
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  'La Fondation Claudine Talon a pour mission d’améliorer les conditions de vie des femmes et des enfants en situation difficile au Bénin. Dans ce but, elle met en place des solutions durables pour résoudre les problèmes de santé, d’hygiène et de cadre de vie inhérents à la précarité des femmes et de leurs enfants.',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 3.0,
        ),
        Container(
          width: size.width * .8,
          child: RaisedButton(
              onPressed: () {},
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              elevation: 4.0,
              padding: EdgeInsets.all(0.0),
              child: Ink(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [Colors.orange, Colors.pinkAccent]),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Container(
                  width: size.width * .8,
                  height: size.width * .1,
                  alignment: Alignment.center,
                  child: Text(
                    "Visiter notre site internet",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              )),
        ),
      ],
    );
  }
}
