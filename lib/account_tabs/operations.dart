import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';

class Operations extends StatefulWidget {
  @override
  _OperationsState createState() => _OperationsState();
}

class _OperationsState extends State<Operations> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Builder(
      // builder is used only for the snackbar, if you don't want the snackbar you can remove
      // Builder from the tree
      builder: (BuildContext context) => HawkFabMenu(
        icon: AnimatedIcons.menu_arrow,
        fabColor: Colors.orange,
        iconColor: Colors.white,
        items: [
          HawkFabMenuItem(
            label: 'Nouvelle publication',
            ontap: () {
              Scaffold.of(context)..hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Remplissage du formulaire de publication')),
              );
            },
            icon: Icon(Icons.share,color: Colors.orange,),
            color: Colors.white,
            labelColor: Colors.black,

          ),
          HawkFabMenuItem(
            label: 'Demander un spot vidéo',
            ontap: () {
              Scaffold.of(context)..hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Enregistrement du spot')),
              );
            },
            icon: Icon(Icons.video_call,color:Colors.orange),
            labelColor: Colors.black,
            labelBackgroundColor: Colors.white,
            color: Colors.white      ),
          HawkFabMenuItem(
            label: 'Other stuff',
            ontap: () {
              Scaffold.of(context)..hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(
                SnackBar(content: Text('Menu 3 selected')),
              );
            },
            color: Colors.white,
            icon: Icon(Icons.add_a_photo,color: Colors.orange,size: 25,),
          ),
        ],
        body: Center(
          child: Text('Historique des opérations récentes',textAlign: TextAlign.center,),
        ),
      ),
    ),
  );
  }
}
