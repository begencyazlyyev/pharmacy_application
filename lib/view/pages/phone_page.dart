// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_app/data/pharmacy_data.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pharmacy_app/components/textstyle_widget.dart';

class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _dialNumber(String number) async {
    final uri = Uri(scheme: 'tel', path: number);
    try {
      final launched = await launchUrl(uri);
      if (!launched && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open dialer for $number')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error opening dialer: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filtered = pharmacyList
        .where((p) => query.isEmpty || p.name.toLowerCase().contains(query))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Ähli belgiler",
            style: KTextStyle.titleText.copyWith(fontSize: 18),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.10),
                  blurRadius: 1,
                  spreadRadius: 0.2,
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() {}),
              decoration: InputDecoration(
                hintText: 'Gözleg...',
                hintStyle: TextStyle(color: Colors.grey.shade500),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    "assets/svg/search.svg",
                    height: 22,
                    width: 22,
                  ),
                ),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close, color: Colors.grey.shade500),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {});
                        },
                      )
                    : null,
                filled: true,
                fillColor: const Color(0xFFF3F4F6),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
            ),
          ),
        ),
        const Gap(10),
        Divider(color: Colors.grey.shade300, thickness: 1.4),
        Expanded(
          child: filtered.isEmpty
              ? const Center(child: Text('Netije tapylmady'))
              : ListView.separated(
                  separatorBuilder: (context, _) => Divider(
                    indent: 80,
                    color: Colors.grey.shade300,
                    thickness: 1.4,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final pharmacy = filtered[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 8,
                      ),
                      leading: ClipOval(
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.fromBorderSide(
                              BorderSide(width: 1, color: Colors.grey),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: ClipOval(
                              child: Image.asset(
                                pharmacy.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        pharmacy.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        pharmacy.address,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () => _dialNumber(pharmacy.contact),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SvgPicture.asset(
                                "assets/svg/dial-phone.svg",
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              "assets/svg/show-location.svg",
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
