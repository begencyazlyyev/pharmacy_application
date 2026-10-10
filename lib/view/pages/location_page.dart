import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/horizintal_list_widget.dart';
import 'package:pharmacy_app/data/pharmacy_data.dart';
import 'package:pharmacy_app/view/pages/home_page.dart';

class LocationPage extends StatelessWidget {
  const LocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              // Map fills the entire available space
              SizedBox.expand(
                child: Image.asset(
                  "assets/images/location-map.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              // Positioned places the list at the bottom of the stack
              Positioned(
                bottom: 20,
                left: 10,
                right: 10,
                child: HorizontalList(
                  images: pharmacyImage,
                  titles: pharmacies,
                  addresses: adresses,
                  points: 5.0,
                  reviews: "(58 Reviews)",
                  kilometer: "25 km/40min",
                  clinic: location,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
