import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_app/components/banner_widget.dart';
import 'package:pharmacy_app/components/dropdown_widget.dart';
import 'package:pharmacy_app/components/horizintal_list_widget.dart';

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
                  ), //Change here
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
          // // Banner
          buildBanner(
            imagePath: "assets/images/image-one.jpg",
            title: "We are doctors for your Bussiness",
            subtitle:
                "Schedule your appointment with us and get the best treatment",
          ),
          // Second midle items
          Padding(
            padding: EdgeInsetsGeometry.only(
              left: 15.0,
              right: 15.0,
              bottom: 0.0,
              top: 15.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dermanhanalar",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, // Removes internal padding
                    minimumSize:
                        Size.zero, // Allows it to shrink smaller than default
                    tapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, // Shrinks the hit test area to content
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
          // Dermanhanalar horizontal list
          HorizontalList(
            title: "Dertdeş",
            address: "123 Oak Street, CA 98765",
            points: 5.0,
            reviews: "(58 Reviews)",
            images: insideImage,
            kilometer: "25 km/40min",
          ),

          // Weterinariya horizontal list
          Padding(
            padding: EdgeInsetsGeometry.only(
              left: 15.0,
              right: 15.0,
              bottom: 0.0,
              top: 15.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
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
                    padding: EdgeInsets.zero, // Removes internal padding
                    minimumSize:
                        Size.zero, // Allows it to shrink smaller than default
                    tapTargetSize: MaterialTapTargetSize
                        .shrinkWrap, // Shrinks the hit test area to content
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
            title: "Tebip",
            address: "123 Oak Street, CA 98765",
            points: 6.2,
            reviews: "(58 Reviews)",
            images: insideImage,
            kilometer: "25 km/40min",
          ),
        ],
      ),
    );
  }
}
