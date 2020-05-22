import 'package:covidtracker/datasource.dart';
import 'package:covidtracker/pojos/Covid_Countries.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class CountryPage extends StatefulWidget {
  CountryPage({Key key, this.covidCounttry}) : super(key: key);

  final Covid_Countries covidCounttry;
  @override
  CountryPageState createState() => CountryPageState(covidCounttry);
}

class CountryPageState extends State<CountryPage> {
  final Covid_Countries covidCountry;

  CountryPageState(this.covidCountry);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");
    return Scaffold(
        backgroundColor: backGroundMainColor,
        appBar: AppBar(
          title: Text("Country Stats - " + covidCountry.country,
          style: TextStyle(fontSize: 24)),
          backgroundColor: Color(0xff191923),

        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              buildCountryStatTile('Cases', FontAwesomeIcons.viruses,
                  formatter.format(covidCountry.cases), casesColor),
              buildCountryStatTile('Active', FontAwesomeIcons.virus,
                  formatter.format(covidCountry.active), activeColor),
              buildCountryStatTile('Recovered', FontAwesomeIcons.sun,
                  formatter.format(covidCountry.recovered), recoveredColor),
              buildCountryStatTile('Critical', FontAwesomeIcons.bed,
                  formatter.format(covidCountry.critical), criticalColor),
              buildCountryStatTile('Deaths', FontAwesomeIcons.skull,
                  formatter.format(covidCountry.deaths), deathsColor),
            ],
          ),
        ));
  }

  Padding buildCountryStatTile(
      String title, IconData statIcon, value, Color color) {
    return Padding(
      padding: const EdgeInsets.all(0.1),
      child: Container(
        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: panelColor,
          borderRadius: BorderRadius.circular(1)
        ),
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(title, style: TextStyle(color: color, fontSize: 24)),
                SizedBox(
                  height: 10,
                ),
                FaIcon(
                  statIcon,
                  color: color,
                  size: 48,
                ),
              ],
            ),
            Text(
              value,
              style: TextStyle(
                  color: color, fontSize: 36, fontWeight: FontWeight.w400),
            )
            // Expanded(child:Text(covidCountry.todayCases.toString()))
          ],
        ),
      ),
    );
  }
}
