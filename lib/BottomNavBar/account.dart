
import 'package:bomoco/account_tabs/abonnement.dart';
import 'package:bomoco/account_tabs/chat/messages_Page.dart';
import 'package:bomoco/account_tabs/operations.dart';
import 'package:bomoco/account_tabs/profile.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  static const routeName = "account";
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
   
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: AppBar(
          
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text("Bomoco",style: TextStyle(color: Colors.orange),),
            
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.orange,
              labelColor: Colors.orange,
              unselectedLabelColor: Colors.black54,
              indicatorWeight: 3.0, 
               onTap: (index){
                 setState(() {});
              },
              tabs: <Widget>[
                Tab(
                  child: Container(
                    child: Text(
                      'Profil',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Abonnement',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Messages',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    child: Text(
                      'Opérations',
                      style: TextStyle(fontSize: 14.0),
                    ),
                  ),
                ),
              
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              Profile(),//ff5722
              Abonnement(),//3f51b5
              MessagesPage(),//e91e63
              Operations(), //9c27b0
            ],
          )),
    );
  }
}