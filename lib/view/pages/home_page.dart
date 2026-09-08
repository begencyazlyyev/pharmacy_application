import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_app/components/banner_widget.dart';
import 'package:pharmacy_app/components/dropdown_widget.dart';
import 'package:pharmacy_app/components/horizintal_list_widget.dart';
import 'package:pharmacy_app/data/pharmacy_data.dart';

List<String> insideImage = [
  "assets/images/inside-one.jpg",
  "assets/images/inside-two.jpg",
  "assets/images/inside-three.jpg",
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "Ýeri",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Dropdown button
          DropdownWidget(),
          // Searchbar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  labelText: "Gözleg...",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      "assets/svg/search.svg",
                      width: 16,
                      height: 16,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          // Banner
          buildBanner(
            imagePath: "assets/images/image-one.jpg",
            title: "We are doctors for your Bussiness",
            subtitle:
                "Schedule your appointment with us and get the best treatment",
          ),
          // Dermanhanalar section
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 0.0,
              top: 15.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Dermanhanalar",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/-pharmacy_page');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Hemmesi",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          HorizontalList(
            images: insideImage,
            titles: pharmacies,
            addresses: adresses,
            points: 5.0,
            reviews: "(58 Reviews)",
            kilometer: "25 km/40min",
          ),

          // Weterinariýa horizontal list
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 0.0,
              top: 15.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Weterinariýa",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Hemmesi",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          HorizontalList(
            images: insideImage,
            titles: pharmacies,
            addresses: adresses,
            points: 5.0,
            reviews: "(58 Reviews)",
            kilometer: "25 km/40min",
          ),
        ],
      ),
    );
  }
}
