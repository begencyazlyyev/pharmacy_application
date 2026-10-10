// ignore_for_file: deprecated_member_use

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
  final List<String> clinic;
  final void Function(int index)? onItemTap;
  final ScrollController? scrollController;
  final int? highlightedIndex;

  // Must match: card width (260) + left padding (15)
  static const double itemExtent = 275;

  const HorizontalList({
    super.key,
    required this.images,
    required this.titles,
    required this.addresses,
    required this.points,
    required this.reviews,
    required this.kilometer,
    required this.clinic,
    this.onItemTap,
    this.scrollController,
    this.highlightedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 282,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
        itemCount: titles.length,
        itemBuilder: (context, index) {
          final image = images[index % images.length];
          final isHighlighted = highlightedIndex == index;
          final isDimmed = highlightedIndex != null && !isHighlighted;

          return Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: GestureDetector(
              onTap: onItemTap == null ? null : () => onItemTap!(index),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: isDimmed ? 0.35 : 1.0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 260,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isHighlighted
                          ? Theme.of(context).primaryColor
                          : Colors.transparent,
                      width: isHighlighted ? 3 : 0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: isHighlighted ? 14 : 6,
                        color: isHighlighted
                            ? Theme.of(context).primaryColor.withOpacity(0.45)
                            : Colors.grey.shade400,
                        offset: const Offset(0, 4),
                        spreadRadius: isHighlighted ? 1 : 0,
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
                                  clinic[index],
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
              ),
            ),
          );
        },
      ),
    );
  }
}
