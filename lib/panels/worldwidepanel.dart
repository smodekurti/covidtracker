import 'package:covidtracker/datasource.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';


class WorldWidePanel extends StatelessWidget {
  final Map worldData;


const WorldWidePanel({Key key, this.worldData}) : super(key:key);


  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");

    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2),
        children: <Widget>[
         StatusPanel(panelColor: panelColor,
                  panelTitle: "Confirmed",
                  panelValue: formatter.format(int.parse(worldData['cases'].toString())),
                  titleColor: casesColor, panelIcon: FontAwesomeIcons.viruses),
        StatusPanel(panelColor:panelColor,
                  panelTitle: "Active",
                  panelValue: formatter.format(int.parse(worldData['active'].toString())),
                  titleColor: activeColor, panelIcon: FontAwesomeIcons.virus,),
        StatusPanel(panelColor: panelColor,
                  panelTitle: "Recovered",
                  panelValue: formatter.format(int.parse(worldData['recovered'].toString())),
                  titleColor: recoveredColor, panelIcon: FontAwesomeIcons.sun,),
        StatusPanel(panelColor: panelColor,
                  panelTitle: "Deaths",
                  panelValue: formatter.format(int.parse(worldData['deaths'].toString())),
                  titleColor: deathsColor, panelIcon: FontAwesomeIcons.skull,)
        ],
      ),
      
    );
  }
}

class StatusPanel extends StatelessWidget {
  const StatusPanel({Key key, this.panelColor, this.titleColor, this.panelTitle, this.panelValue, this.panelIcon}) : super(key: key);

  final Color panelColor;
  final Color titleColor;
  final String panelTitle;
  final String panelValue;
  final IconData panelIcon;



  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.all(5),
      height: 80,
      width: width/2,
      
      decoration: BoxDecoration(
        color: panelColor,
        borderRadius: BorderRadius.circular(5),
      
      ),
      
      child: 
      
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                
                Text(panelTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: titleColor),),
                SizedBox(
                        height: 10,
                      ),
                      FaIcon(
                        panelIcon,
                        color: titleColor,
                        size: 32,
                      ),
                      SizedBox(
                        height: 10,
                      ),
               
                
              ],),
          ),
             Text(panelValue, style:TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: titleColor))
        ],
      ),

    );
  }
}