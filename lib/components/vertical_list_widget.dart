import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmacy_app/components/textstyle_widget.dart';

class VerticalList extends StatelessWidget {
  final List<String> images;
  final String title;
  final String address;
  final double points;
  final String reviews;
  final String kilometer;
  const VerticalList({
    super.key,
    required this.title,
    required this.address,
    required this.points,
    required this.reviews,
    required this.images,
    required this.kilometer,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      itemCount: 10,
      itemBuilder: (context, index) {
        final image = images[index % images.length];
        return Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  blurRadius: 6,
                  color: Colors.grey.shade400,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(image),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    title,
                    style: KTextStyle.titleText.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Gap(5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/svg/location-small.svg"),
                      const Gap(4),
                      Text(
                        address,
                        style: KTextStyle.subtitleText.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const Gap(5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        "$points",
                        style: KTextStyle.subtitleText.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                      const Gap(5),
                      SvgPicture.asset("assets/svg/stars.svg", height: 12),
                      const Gap(5),
                      Text(
                        reviews,
                        style: KTextStyle.subtitleText.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                const Gap(4),
                Divider(color: Colors.grey.shade300, endIndent: 10, indent: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            "assets/svg/direction.svg",
                            height: 18,
                          ),
                          const Gap(5),
                          Text(
                            kilometer,
                            style: KTextStyle.subtitleText.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          SvgPicture.asset("assets/svg/plus.svg", height: 20),
                          const Gap(4),
                          Text(
                            "Hospital",
                            style: KTextStyle.subtitleText.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          const Gap(4),
                        ],
                      ),
                    ],
                  ),
                ),
                const Gap(10),
              ],
            ),
          ),
        );
      },
    );
  }
}
