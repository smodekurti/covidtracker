import 'dart:convert';
import 'dart:ffi';

import 'package:covidtracker/datasource.dart';
import 'package:covidtracker/pages/countryPage.dart';
import 'package:covidtracker/panels/infopanel.dart';
import 'package:covidtracker/panels/mostaffectedpanel.dart';
import 'package:covidtracker/panels/worldwidepanel.dart';
import 'package:covidtracker/routes/PageRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:http/http.dart' as http;

import 'Services/Services.dart';
import 'pojos/Covid_Countries.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final summaryDataURL = 'https://corona.lmao.ninja/v2/all';
  final countryDataURL = 'https://corona.lmao.ninja/v2/countries?sort=cases';
  Map worldData;
  List countryData;
  List<Covid_Countries> covidCounttries;
  List<Covid_Countries> filterCovidCountries = List<Covid_Countries>();

  @override
  void initState() {
    fetchWorldWideData();
    //fetchCountryData();
    fetchCovidCountries();

    super.initState();
  }

  Future<Void> fetchData() async {
    setState(() {
      fetchWorldWideData();
      fetchCovidCountries();
    });
    return null;
  }

  fetchWorldWideData() async {
    http.Response response = await http.get(summaryDataURL);
    setState(() {
      worldData = json.decode(response.body);
    });
  }

  fetchCovidCountries() async {
    Services.getCovidCountries().then((covidCountriesFromService) {
      setState(() {
        covidCounttries = covidCountriesFromService;
        filterCovidCountries = covidCounttries;
        //print(covidCountriesFromService);
      });
    });
  }

  resettFilteredCountries() {
    setState(() {
      filterCovidCountries = covidCounttries;
    });
  }

  showCountryPick(BuildContext context) {
    resettFilteredCountries();
    showModalBottomSheet(
        context: context,
        elevation: 1,
        isScrollControlled: true,
        backgroundColor: backGroundMainColor,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: Column(
              children: <Widget>[
                TextField(
                  style:
                      new TextStyle(fontSize: 20.0, color: Color(0xFFbdc6cf),),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    hintText: 'Enter country name or code',

                    hintStyle: TextStyle(color: Colors.white),
                    icon: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                  onChanged: (string) {

                    setState(() {
                      filterCovidCountries = (covidCounttries.where((cv) =>
                          (cv.country
                              .toLowerCase()
                              .contains(string.toLowerCase())) ||
                          (cv.countryInfo.iso2
                              .toLowerCase()
                              .contains(string.toLowerCase())))).toList();
                    });
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.all(0.2),
                          child: GestureDetector(
                            onTap: () {
                              //Navigator.pop(context);
                              Navigator.push(
                                context, 
                                PageRoutes.slide(()=>CountryPage(
                                        covidCounttry:
                                        filterCovidCountries[index])));
                              //Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     PageTransition(type: 
                              //       PageTransitionType.fade, 
                              //     child: 
                              //     CountryPage(
                              //               covidCounttry:
                              //                   filterCovidCountries[index],
                              //             )));
                              //     ;
                            },
                            child: new Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              height: 50,
                              decoration: BoxDecoration(
                                color: panelColor,
                                boxShadow: [
                                  BoxShadow(
                                      color: panelColor, offset: Offset(0, 5))
                                ],
                              ),
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: <Widget>[
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Image(
                                    image: AdvancedNetworkImage(
                                      'https://www.countryflags.io/' +
                                          filterCovidCountries[index]
                                              .countryInfo
                                              .iso2 +
                                          '/flat/64.png',
                                      useDiskCache: true,
                                      cacheRule: CacheRule(
                                          maxAge: const Duration(days: 7)),
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                  // Image.network(
                                  //   'https://www.countryflags.io/' +
                                  //       filterCovidCountries[index]
                                  //           .countryInfo
                                  //           .iso2 +
                                  //       '/flat/64.png',
                                  // ),
                                  SizedBox(
                                    height: 5,
                                    width: 50,
                                  ),
                                  Flexible(
                                    child: Text(
                                      filterCovidCountries[index].country,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    },
                    itemCount: filterCovidCountries.length,
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroundMainColor,
      appBar: AppBar(
        centerTitle: false,
        title: Text('COVID-19 Tracker'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchData,
        strokeWidth: 3,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  height: 30,
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(2),
                  child: Text(
                    'Pull to refresh !!!',
                    style: TextStyle(
                        color: Colors.white54,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Worldwide",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => CountryPickerPage()));
                        showCountryPick(context);
                      },
                      child: Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: primaryBlack,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text("Countries",
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  child: (worldData == null)
                      ? CircularProgressIndicator()
                      : WorldWidePanel(worldData: worldData)),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Text('Most Affected Countries',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.white)),
              ),
              Container(
                  alignment: Alignment.center,
                  child: (covidCounttries == null)
                      ? Container()
                      : MostAffectedPanel(
                          countryData: covidCounttries,
                          callback: showCountryPick,
                        )),
              InfoPanel(),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
