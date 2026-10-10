// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:pharmacy_app/data/pharmacy_data.dart';
import 'package:pharmacy_app/view/pages/details_page.dart';
import 'package:pharmacy_app/view/pages/pharmacy_page.dart';
import 'package:pharmacy_app/view/widget_tree.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Pharmacy App",
      theme: ThemeData(
        appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WidgetTree(),
        '/-pharmacy_page': (context) => const PharmacyPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/-pharmacy_details_page') {
          final pharmacy = settings.arguments as Pharmacy;
          return MaterialPageRoute(
            builder: (context) => PharmacyDetailsPage(pharmacy: pharmacy),
          );
        }
        return null;
      },
    );
  }
}
