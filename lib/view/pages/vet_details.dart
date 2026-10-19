import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:pharmacy_app/data/veterinary_data.dart';
import 'package:url_launcher/url_launcher.dart';

class VeterinaryDetailsPage extends StatelessWidget {
  final Veterinary veterinary;

  const VeterinaryDetailsPage({super.key, required this.veterinary});

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
        title: const Text(
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
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "Weterinariýa",
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
                          child: Image.asset(
                            veterinary.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            veterinary.name,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Gap(8),
                          Text(veterinary.address),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 15, right: 12),
              child: Text(
                vetAdditional[0],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
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
                vetAbout[0],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
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
                vetWorkingHours[0],
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
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
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FilledButton.tonal(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF1C2A3A),
                  foregroundColor: Colors.white,
                  minimumSize: const Size.fromHeight(48),
                ),
                onPressed: () => _dialNumber(context, veterinary.contact),
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
