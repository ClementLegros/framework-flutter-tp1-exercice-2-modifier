import 'package:flutter/material.dart';
import 'package:tp2/pages/MaDureeCalculerPage.dart';
import 'package:tp2/pages/MonCalculAgePage.dart';
import 'package:tp2/pages/MyAgeCalculationPage.dart';
import 'package:tp2/pages/MyDurationCalculationPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      //Définis l'onglet de base
      initialIndex: 0,
      //Permet de gérer le nombre d'onglet de la navbar
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('calcul de dates'),
          bottom: const TabBar(
            //Menu de navigation : Icone
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.cake),
                text: "Ancien",
              ),
              Tab(
                icon: Icon(Icons.date_range_outlined),
                text: "Ancien",
              ),
              Tab(
                icon: Icon(Icons.cake),
                text: "Modifié",
              ),
              Tab(
                icon: Icon(Icons.date_range_outlined),
                text: "Modifié",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          //Menu de navigation : Redirection
          children: <Widget>[
            Center(
              child: MyAgeCalculationPage(
                title: "",
              ),
            ),
            Center(
              child: MyDurationCalculationPage(
                title: "",
              ),
            ),
            Center(
              child: MonCalculAgePage(title: ""),
            ),
            Center(
              child: MaDureeCalculerPage(title: ""),
            )
          ],
        ),
      ),
    );
  }
}
