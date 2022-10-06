import 'package:covid19_app/views/world_page.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String image;
  String name;
  int totalCase,
      totalRecover,
      totalDeath,
      active,
      test,
      todayRecovered,
      critical;

  DetailScreen({
    required this.image,
    required this.name,
    required this.totalCase,
    required this.todayRecovered,
    required this.totalDeath,
    required this.active,
    required this.test,
    required this.totalRecover,
    required this.critical,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*.067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height*.06,),
                      Reuseable(title: 'Cases', value:widget.totalCase.toString()),
                      Reuseable(title: 'Recovered', value:widget.totalRecover.toString()),
                      Reuseable(title: 'Death', value:widget.totalDeath.toString()),
                      Reuseable(title: 'Critical', value:widget.critical.toString()),
                      Reuseable(title: 'Today Recover', value:widget.todayRecovered.toString())
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
