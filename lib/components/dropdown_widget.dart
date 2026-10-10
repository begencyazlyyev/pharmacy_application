import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DropdownWidget extends StatefulWidget {
  final ValueChanged<String>? onCityChanged;
  final VoidCallback? onCleared;

  const DropdownWidget({super.key, this.onCityChanged, this.onCleared});

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  static const String defaultCity = 'Aşgabat';

  String selectedCity = defaultCity;
  bool _isFiltered = false;

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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonHideUnderline(
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
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(city, style: TextStyle(fontSize: 14)),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedCity = value;
                    _isFiltered = true;
                  });
                  widget.onCityChanged?.call(value);
                }
              },
            ),
          ),
          if (_isFiltered)
            IconButton(
              icon: const Icon(Icons.close, size: 18),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
              onPressed: () {
                setState(() {
                  selectedCity = defaultCity;
                  _isFiltered = false;
                });
                widget.onCleared?.call();
              },
            ),
        ],
      ),
    );
  }
}
