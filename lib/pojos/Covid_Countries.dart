class Covid_Countries {
  int updated;
  String country;
  CountryInfo countryInfo;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int active;
  int critical;
  double casesPerOneMillion;
  double deathsPerOneMillion;
  int tests;
  double testsPerOneMillion;
  int population;
  String continent;
  double activePerOneMillion;
  double recoveredPerOneMillion;
  double criticalPerOneMillion;

  Covid_Countries(
      {this.updated,
      this.country,
      this.countryInfo,
      this.cases,
      this.todayCases,
      this.deaths,
      this.todayDeaths,
      this.recovered,
      this.active,
      this.critical,
      this.casesPerOneMillion,
      this.deathsPerOneMillion,
      this.tests,
      this.testsPerOneMillion,
      this.population,
      this.continent,
      this.activePerOneMillion,
      this.recoveredPerOneMillion,
      this.criticalPerOneMillion});

  Covid_Countries.fromJson(Map<String, dynamic> json) {
    updated = json['updated'];
    country = json['country'];
    countryInfo = json['countryInfo'] != null
        ? new CountryInfo.fromJson(json['countryInfo'])
        : null;
    cases = (json['cases'] != null) ? json['cases'] : 0;
    todayCases = ( json['todayCases'] !=null) ? json['todayCases'] : 0;
    deaths = (json['deaths']!=null) ? json['deaths'] : 0;
     todayDeaths = (json['todayDeaths']!=null) ? json['todayDeaths'] : 0;
    recovered = (json['recovered']!=null) ? json['recovered'] : 0;
    active = (json['active']!=null) ? json['active'] : 0;
    critical = (json['critical']!=null) ? json['critical']:0;
    casesPerOneMillion = (json['casesPerOneMillion']!=null) ? json['casesPerOneMillion']+.0 : 0.0;
    deathsPerOneMillion = (json['deathsPerOneMillion']!=null) ? json['deathsPerOneMillion'] +.0 : 0.0;
    tests = (json['tests']!=null) ? json['tests'] : 0;
    testsPerOneMillion = (json['testsPerOneMillion']!=null) ? json['testsPerOneMillion'] +.0 : 0.0;
    population = (json['population']!=null) ? json['population']:0;
    continent = (json['continent']!=null) ? json['continent'] : '';
    activePerOneMillion = (json['activePerOneMillion']!=null) ? json['activePerOneMillion']+.0 : 0.0;
    recoveredPerOneMillion = (json['recoveredPerOneMillion'] !=null) ? json['recoveredPerOneMillion'] +.0 : 0.0;
    criticalPerOneMillion = (json['criticalPerOneMillion']!=null) ? json['criticalPerOneMillion'] +.0 : 0.0;
    //print(country);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['updated'] = this.updated;
    data['country'] = this.country;
    if (this.countryInfo != null) {
      data['countryInfo'] = this.countryInfo.toJson();
    }
    data['cases'] = this.cases;
    data['todayCases'] = this.todayCases;
    data['deaths'] = this.deaths;
    data['todayDeaths'] = this.todayDeaths;
    data['recovered'] = this.recovered;
    data['active'] = this.active;
    data['critical'] = this.critical;
    data['casesPerOneMillion'] = this.casesPerOneMillion;
    data['deathsPerOneMillion'] = this.deathsPerOneMillion;
    data['tests'] = this.tests;
    data['testsPerOneMillion'] = this.testsPerOneMillion;
    data['population'] = this.population;
    data['continent'] = this.continent;
    data['activePerOneMillion'] = this.activePerOneMillion;
    data['recoveredPerOneMillion'] = this.recoveredPerOneMillion;
    data['criticalPerOneMillion'] = this.criticalPerOneMillion;
    return data;
  }
}

class CountryInfo {
  int iId;
  String iso2;
  String iso3;
  double lat;
  double long;
  String flag;

  CountryInfo({this.iId, this.iso2, this.iso3, this.lat, this.long, this.flag});

  CountryInfo.fromJson(Map<String, dynamic> json) {
    iId = (json['_id']!=null) ? json['_id']:0;
    iso2 = (json['iso2']!=null) ?json['iso2'] : '';
    iso3 = (json['iso3']!=null) ? json['iso3'] : '';
    lat = (json['lat']!=null) ? json['lat']+.0 : 0.0;
    long = (json['long']!=null) ? json['long']+.0 : 0.0;
    flag = (json['flag']!=null) ? json['flag']: '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.iId;
    data['iso2'] = this.iso2;
    data['iso3'] = this.iso3;
    data['lat'] = this.lat;
    data['long'] = this.long;
    data['flag'] = this.flag;
    return data;
  }
}
