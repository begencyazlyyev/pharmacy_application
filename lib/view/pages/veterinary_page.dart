import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/vertical_list_widget.dart';
import 'package:pharmacy_app/data/veterinary_data.dart';
import 'package:pharmacy_app/view/pages/vet_details.dart';

const List<String> vetInsideImage = [
  "assets/images/inside-one.jpg",
  "assets/images/inside-two.jpg",
  "assets/images/inside-three.jpg",
];

class VeterinaryPage extends StatelessWidget {
  const VeterinaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalList(
      titles: veterinaryName,
      addresses: veterinaryAdress,
      points: 5.0,
      reviews: "(58 Reviews)",
      images: vetInsideImage,
      kilometer: "25 km/40min",
      onTap: (index) {
        final vet = veterinaryList[index];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VeterinaryDetailsPage(veterinary: vet),
          ),
        );
      },
    );
  }
}
