import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/vertical_list_widget.dart';
import 'package:pharmacy_app/data/pharmacy_data.dart';
import 'package:pharmacy_app/view/pages/details_page.dart';

const List<String> insideImage = [
  "assets/images/inside-one.jpg",
  "assets/images/inside-two.jpg",
  "assets/images/inside-three.jpg",
];

class PharmacyPage extends StatelessWidget {
  const PharmacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Hemmesi",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
          ),
          bottom: const TabBar(
            labelStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            unselectedLabelStyle: TextStyle(
              color: Colors.black45,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: Colors.black,
            indicatorWeight: 3,
            tabs: [
              Tab(text: "Dermanhanalar"),
              Tab(text: "Weterinariýa"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            VerticalList(
              titles: pharmacies,
              addresses: adresses,
              points: 5.0,
              reviews: "(58 Reviews)",
              images: insideImage,
              kilometer: "25 km/40min",
              onTap: (index) {
                final pharmacy = pharmacyList[index];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PharmacyDetailsPage(pharmacy: pharmacy),
                  ),
                );
              },
            ),
            const Center(child: Text("Maglumat tab")),
          ],
        ),
      ),
    );
  }
}
