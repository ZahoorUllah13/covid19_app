import 'package:covid19_app/services/state_service.dart';
import 'package:covid19_app/views/World_countries.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Model/WorldStateModel.dart';

class WorldPage extends StatefulWidget {
  const WorldPage({Key? key}) : super(key: key);
  @override
  _WorldPageState createState() => _WorldPageState();
}

class _WorldPageState extends State<WorldPage> with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 5), vsync: this)
        ..repeat();


  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];


  final _stateServices = StateServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.teal,
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .08,
                ),
                FutureBuilder<WorldStateModel>(
                  future: _stateServices.fetchWorldStateRecord(),
                  builder: (context, snapshot) {
                    print(snapshot.data);
                    if (!snapshot.hasData) {
                      return SpinKitCircle(
                        color: Colors.white,
                        size: 50.0,
                        controller: _controller,
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                              dataMap: {
                                "total": double.parse(snapshot.data!.cases.toString()),
                                "recover": double.parse(snapshot.data!.recovered.toString()),
                                "death": double.parse(snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              chartRadius: MediaQuery.of(context).size.width / 3,
                              legendOptions: const LegendOptions(legendPosition: LegendPosition.left),
                              animationDuration: const Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorList),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * .06,),
                            child: Card(
                              child: Column(
                                children: [
                                  Reuseable(
                                      title: 'Total',
                                      value: snapshot.data!.cases.toString()),
                                  Reuseable(
                                      title: 'Death',
                                      value: snapshot.data!.deaths.toString()),
                                  Reuseable(
                                      title: 'Recover',
                                      value: snapshot.data!.recovered.toString()),
                                  Reuseable(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString()),
                                  Reuseable(
                                      title: 'Critical',
                                      value: snapshot.data!.critical.toString()),
                                  Reuseable(
                                      title: 'Today Death',
                                      value:
                                          snapshot.data!.todayDeaths.toString()),
                                  Reuseable(
                                      title: 'today Recover',
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context)=>WorldCountries()));
                            },
                            child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    color: const Color(0xff1aa260),
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Center(child: Text('track country'))),
                          )
                        ],
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

}

class Reuseable extends StatelessWidget {
  final String title, value;

  Reuseable({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          const Divider(),
        ],
      ),
    );
  }

}
