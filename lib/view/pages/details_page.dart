import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:pharmacy_app/data/pharmacy_data.dart';
import 'package:url_launcher/url_launcher.dart';

class PharmacyDetailsPage extends StatelessWidget {
  final Pharmacy pharmacy;

  const PharmacyDetailsPage({super.key, required this.pharmacy});
  Future<void> _dialNumber(BuildContext context, String number) async {
    final uri = Uri(scheme: 'tel', path: number);
    try {
      final launched = await launchUrl(uri);
      if (!launched && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open dialer for $number')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error opening dialer: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Maglumat",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                "Dermanhana",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipOval(
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
                          child: Image.asset(pharmacy.image, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          pharmacy.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Gap(8),
                        Text(pharmacy.address),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15, right: 12),
              child: Text(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                additional[0],
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                top: 18,
                bottom: 8,
                right: 15,
              ),
              child: Text(
                "Hakkynda",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 12),
              child: Text(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                about[0],
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                top: 18,
                bottom: 8,
                right: 15,
              ),
              child: Text(
                "Iş sagatlary",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 12),
              child: Text(
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                workingHours[0],
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                top: 18,
                bottom: 14,
                right: 15,
              ),
              child: Text(
                "Ýerleşýän ýeri",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),

            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.asset(
                "assets/images/instantDelivery.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Gap(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton.tonal(
                style: FilledButton.styleFrom(
                  backgroundColor: Color(0xFF1C2A3A),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () => _dialNumber(context, pharmacy.contact),
                child: const Text(
                  "Jaň etmek",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
