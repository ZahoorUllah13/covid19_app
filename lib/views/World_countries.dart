import 'package:covid19_app/services/state_service.dart';
import 'package:covid19_app/views/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class WorldCountries extends StatefulWidget {
  WorldCountries({Key? key}) : super(key: key);

  @override
  State<WorldCountries> createState() => _WorldCountriesState();
}

class _WorldCountriesState extends State<WorldCountries> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextFormField(
              controller: searchController,
              onChanged: (value) {
                setState(() {});
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: 'search with countries',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: stateServices.WorldCountriesList(),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if (!snapshot.hasData) {
                  return ListView.builder(
                      itemCount: 8,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                          baseColor: Colors.grey.shade800,
                          highlightColor: Colors.grey.shade100,
                          child: Column(
                            children: [
                              ListTile(
                                title: Container(
                                  height: 10,
                                  width: 90,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  height: 10,
                                  width: 90,
                                  color: Colors.white,
                                ),
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        );
                      });
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      String name = snapshot.data![index]['country'];
                      if (searchController.text.isEmpty) {
                        return Column(
                          children: [
                            InkWell(
                              onTap:(){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>
                                    DetailScreen(
                                      image:snapshot.data![index]['countryInfo']['flag'],
                                      name: snapshot.data![index]['country'],
                                      totalCase: snapshot.data![index]['cases'],
                                      todayRecovered: snapshot.data![index]['recovered'],
                                      totalDeath:snapshot.data![index]['deaths'],
                                      active:snapshot.data![index]['active'],
                                      test:snapshot.data![index]['tests'],
                                      totalRecover:snapshot.data![index]['recovered'],
                                      critical:snapshot.data![index]['critical'],
                                    ),
                                    )
                                );
                              },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                              ),
                            )
                          ],
                        );
                      } else if (name.toLowerCase().contains(searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap:(){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>
                                        DetailScreen(
                                          image:snapshot.data![index]['countryInfo']['flag'],
                                          name: snapshot.data![index]['country'],
                                          totalCase: snapshot.data![index]['cases'],
                                          todayRecovered: snapshot.data![index]['recovered'],
                                          totalDeath:snapshot.data![index]['deaths'],
                                          active:snapshot.data![index]['active'],
                                          test:snapshot.data![index]['tests'],
                                          totalRecover:snapshot.data![index]['recovered'],
                                          critical:snapshot.data![index]['critical'],
                                        ),
                                    )
                                );
                        },
                              child: ListTile(
                                title: Text(snapshot.data![index]['country']),
                                subtitle: Text(
                                    snapshot.data![index]['cases'].toString()),
                                leading: Image(
                                  height: 50,
                                  width: 50,
                                  image: NetworkImage(snapshot.data![index]
                                      ['countryInfo']['flag']),
                                ),
                              ),
                            )
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
