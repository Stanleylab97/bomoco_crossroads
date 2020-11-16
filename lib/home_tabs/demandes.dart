import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Demandes extends StatefulWidget {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  _DemandesState createState() => _DemandesState();
}

class _DemandesState extends State<Demandes> {
  int getColorHexFromStr(String colorStr) {
    colorStr = "FF" + colorStr;
    colorStr = colorStr.replaceAll("#", "");
    int val = 0;
    int len = colorStr.length;
    for (int i = 0; i < len; i++) {
      int hexDigit = colorStr.codeUnitAt(i);
      if (hexDigit >= 48 && hexDigit <= 57) {
        val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 65 && hexDigit <= 70) {
        // A..F
        val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
      } else if (hexDigit >= 97 && hexDigit <= 102) {
        // a..f
        val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
      } else {
        throw new FormatException("An error occurred when converting a color");
      }
    }
    return val;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, top: 15),
                child: Container(
                  padding: EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              color: Colors.orange,
                              style: BorderStyle.solid,
                              width: 3.0))),
                  child: Row(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('Soutenez un appel à projet',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: 'Timesroman',
                                  fontWeight: FontWeight.bold)),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ];
        },
        body: Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: size.height * .71,
                  color: Color(getColorHexFromStr('#fff5ea')),
                ),
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10),
                      height: size.height * .69,
                      child: Container(
                          child: StreamBuilder<QuerySnapshot>(
                              stream: widget.firestore
                                  .collection("advertisements")
                                  .doc("various")
                                  .collection("requests")
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                    itemCount: snapshot.data.docs.length,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot demande =
                                          snapshot.data.docs[index];
                                      return PrimaryCard(
                                          context: context,
                                          content: demande['content'],
                                          association: demande['association'],
                                          amountEstimation: demande[
                                              'amountEstimation']); //EventCard(event['affiche'], event['title'],
                                      //dates, event['link'],event['lieu']);
                                    },
                                    padding: EdgeInsets.only(
                                        top: 20.0, bottom: 10.0),
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              })),
                    ),
                    SizedBox(height: 10)
                  ],
                )
              ],
            ),
          ],
        ));
  }
}

class PrimaryCard extends StatelessWidget {
  const PrimaryCard({
    Key key,
    @required this.context,
    @required this.content,
    @required this.association,
    @required this.amountEstimation,
  }) : super(key: key);

  final BuildContext context;
  final String content;
  final String association;
  final int amountEstimation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      height: MediaQuery.of(context).size.height * .197,
      width: MediaQuery.of(context).size.width * .9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.grey[200],
      ),
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(2),
              child: Text(content,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  style: TextStyle(fontFamily: 'Quicksand'),
                  textAlign: TextAlign.start)),
          Spacer(),
          Container(
            height: 2.0,
            width: MediaQuery.of(context).size.width * .5,
            color: Colors.orange,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Row(
                children: [
                  Container(
                    height: 25.0,
                    width: 25.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.5),
                        image: DecorationImage(
                            image: AssetImage('assets/images/chris.jpg'))),
                  ),
                  Text(association, style: TextStyle(fontFamily: 'Quicksand')),
                ],
              ),
              FlatButton(
                  onPressed: () {
                    print('Boutton clicked $amountEstimation');
                  },
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 2.0, bottom: 2.0, left: 3.0, right: 3.0),
                      child: Text(
                        "Consulter",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12.5),
                    ),
                  )),
            ],
          )
        ],
      ),
    );
  }
}
