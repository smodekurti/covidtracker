import 'package:covidtracker/datasource.dart';
import 'package:covidtracker/pages/countryPage.dart';
import 'package:covidtracker/pojos/Covid_Countries.dart';
import 'package:covidtracker/routes/PageRoutes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_networkimage/provider.dart';
import 'package:intl/intl.dart';


typedef ActionSheetCallback = Function(BuildContext context);

class MostAffectedPanel extends StatelessWidget {
  final List<Covid_Countries> countryData;
  final ActionSheetCallback callback;

  const MostAffectedPanel({Key key, this.countryData, this.callback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formatter = new NumberFormat("#,###");

    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            onDoubleTap: (){
               Navigator.push(context, PageRoutes.fadeThrough(()=>CountryPage(
                    covidCounttry:
                    countryData[index])));
            },
            onTap: (){
            
              Navigator.push(context,

                  PageRoutes.fadeThrough(()=>CountryPage(
                    covidCounttry:
                    countryData[index])));
            
            },
            child: new Card(
                elevation: 1,
                margin: EdgeInsets.all(5),
                borderOnForeground: false,
                color: panelColor,
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    //Image.network(countryData[index]['countryInfo']['flag'], height: 50,width: 50,),
                    Image(
                      image: AdvancedNetworkImage(
                        'https://www.countryflags.io/' +
                            countryData[index].countryInfo.iso2 +
                            '/flat/64.png',
                        useDiskCache: true,
                        cacheRule: CacheRule(maxAge: const Duration(days: 7)),
                      ),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      formatter.format(countryData[index].cases),
                       style: TextStyle(
                          
                          fontSize: 22,
                          color: Color(0xFFF5BB00),
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Deaths",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      formatter.format(
                          int.parse(countryData[index].deaths.toString())),
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )),
          );
        },
        itemCount: 5,
      ),
    );
  }
}
