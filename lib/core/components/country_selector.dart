import 'package:flutter/material.dart';

class CountrySelector extends StatefulWidget {
  const CountrySelector({super.key});

  @override
  State<CountrySelector> createState() => _CountrySelectorState();
}

class _CountrySelectorState extends State<CountrySelector> {
  String selectedCountry = 'English'; // Default selected country

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownButton<String>(
          value: selectedCountry,
          onChanged: (String? newValue) {
            setState(() {
              selectedCountry = newValue!;
            });
          },
          items: <String>['Germany', 'French', 'English']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  if (selectedCountry != value)
                    Image.asset(
                      'assets/images/${value.toLowerCase()}_flag.png',
                      width: 30,
                      height: 20,
                    ),
                  const SizedBox(width: 10),
                  Text(value),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
