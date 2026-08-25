import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

Widget buildBanner({
  required String imagePath,
  required String title,
  required String subtitle,
}) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
    child: Container(
      clipBehavior: Clip.antiAlias,
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          // Background Image
          Image.asset(
            imagePath,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          // Content Layer
          Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 150.0, top: 25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Left-align text
              children: [
                const Gap(22),
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
