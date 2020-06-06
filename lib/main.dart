import 'package:eventkg/coinlist.dart';
import 'package:flutter/material.dart';
void main()=> runApp(CoinTracker());

class CoinTracker extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Coin Tracker',
      theme: ThemeData(
        primarySwatch: Colors.cyan
      ),
      home: CoinList()
    );
  }

}