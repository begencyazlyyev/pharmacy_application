// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pharmacy_app/components/navbar_widget.dart';
import 'package:pharmacy_app/data/notifiers.dart';
import 'package:pharmacy_app/view/pages/home_page.dart';
import 'package:pharmacy_app/view/pages/location_page.dart';
import 'package:pharmacy_app/view/pages/phone_page.dart';
import 'package:pharmacy_app/view/pages/profile_page.dart';

List<Widget> pages = [HomePage(), LocationPage(), PhonePage(), ProfilePage()];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedPageNotifier,
          builder: (context, selectedPage, child) {
            return pages[selectedPage];
          },
        ),
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
