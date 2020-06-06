import 'package:eventkg/coindata.dart';
import "package:flutter/material.dart";
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//создает ту вьюшку которая рендерится на экране
class CoinList extends StatefulWidget{

  @override
  State <StatefulWidget> createState() {
    return CoinListState();
  }
}

//хранит state экрана, который мы создаем выше и меняем этот state
class CoinListState extends State{
  List<Coindata> mydata = [];
  //возвращает вьюшку в мэйн метод
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( // это toolbar
          title:  Text("Coin Tracker"),
        ),
        body: Container(
          child: ListView(
            children: _buildList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
        onPressed: ()=> _loadCoins(),
        child: Icon(Icons.refresh),
    ),
    );
  }
  List<Widget> _buildList(){
    return mydata.map((Coindata f) => ListTile(
      title: Text(f.name),
      subtitle: Text(f.symbol),
      leading: CircleAvatar(child: Text(f.rank.toString())),
      trailing: Text("\$${f.price.toStringAsFixed(2)}"),
    )).toList();
  }

  @override
  void initState(){
    super.initState();
    _loadCoins();
  }
  _loadCoins() async{
      final response = await http.get('https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?CMC_PRO_API_KEY=94f43d55-9e73-47aa-950a-50ee1193a9fe');
      Map<String, dynamic> map = json.decode(response.body);
      List<dynamic> data = map["data"];
      var datalist = List <Coindata>();
      data.forEach((element) {
        var record = Coindata(name : element["name"],symbol: element["symbol"],rank:element["cmc_rank"],price: element["quote"]["USD"]["price"]);
        datalist.add(record);
      });
      setState(() {
        mydata = datalist;
      });
  }
}
