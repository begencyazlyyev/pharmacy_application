import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({super.key});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String selectedCity = 'Aşgabat';

  final List<String> cities = [
    'Aşgabat',
    'Daşoguz',
    'Mary',
    'Balkanabat',
    'Türkmenabat',
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCity,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          items: cities.map((city) {
            return DropdownMenuItem<String>(
              value: city,
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/svg/location-filled.svg",
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(city, style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) setState(() => selectedCity = value);
          },
        ),
      ),
    );
  }
}
