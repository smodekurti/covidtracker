import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class CountryPickerPage extends StatelessWidget {
  const CountryPickerPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CountryCodePicker(
                onChanged: print,
                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                initialSelection: 'US',
                favorite: ['US'],
                showFlag: true,
                showCountryOnly: true,
                showFlagDialog: true,
                comparator: (a, b) => b.name.compareTo(a.name),
                //Get the country information relevant to the initial selection
                onInit: (code) =>
                    print("on init ${code.name} ${code.dialCode}"),
              ),
    );
  }
}