import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmacy_app/components/textstyle_widget.dart';

class HorizontalList extends StatelessWidget {
  final List<String> images;
  final List<String> titles;
  final List<String> addresses;
  final double points;
  final String reviews;
  final String kilometer;

  const HorizontalList({
    super.key,
    required this.images,
    required this.titles,
    required this.addresses,
    required this.points,
    required this.reviews,
    required this.kilometer,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 282,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          final image = images[index % images.length];
          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Container(
              width: 260,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 6,
                    color: Colors.grey.shade400,
                    offset: Offset(0, 4),
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
                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(titles[index], style: KTextStyle.titleText),
                  ),
                  Gap(5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/svg/location-small.svg"),
                        Gap(4),
                        Expanded(
                          child: Text(
                            addresses[index],
                            style: KTextStyle.subtitleText,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          "$points",
                          style: KTextStyle.subtitleText.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Gap(5),
                        SvgPicture.asset("assets/svg/stars.svg"),
                        Gap(5),
                        Text(reviews, style: KTextStyle.subtitleText),
                      ],
                    ),
                  ),
                  Gap(4),
                  Divider(
                    color: Colors.grey.shade300,
                    endIndent: 10,
                    indent: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/svg/direction.svg"),
                            Gap(5),
                            Text(kilometer, style: KTextStyle.subtitleText),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset("assets/svg/plus.svg"),
                            Gap(4),
                            Text(
                              "Hospital",
                              style: KTextStyle.subtitleText.copyWith(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Gap(4),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
