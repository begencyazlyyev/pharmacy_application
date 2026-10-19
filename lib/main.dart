// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pharmacy_app/data/pharmacy_data.dart';
import 'package:pharmacy_app/view/pages/details_page.dart';
import 'package:pharmacy_app/view/pages/pharmacy_page.dart';
import 'package:pharmacy_app/view/widget_tree.dart';

const SystemUiOverlayStyle _appOverlayStyle = SystemUiOverlayStyle(
  // Status bar
  statusBarColor: Colors.transparent,
  statusBarIconBrightness: Brightness.dark, // Android icons
  statusBarBrightness: Brightness.light, // iOS
  // Navigation bar
  systemNavigationBarColor: Colors.white,
  systemNavigationBarDividerColor: Colors.transparent,
  systemNavigationBarIconBrightness: Brightness.dark,
  systemNavigationBarContrastEnforced: false, // removes the grey scrim
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Draw behind system bars so your white background shows through
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(_appOverlayStyle);

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
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          systemOverlayStyle: _appOverlayStyle,
        ),
        // Material 3 NavigationBar is tinted by default, force it to white
        navigationBarTheme: const NavigationBarThemeData(
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.transparent,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
        ),
      ),
      // Keeps the style applied on every screen
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: _appOverlayStyle,
          child: child!,
        );
      },
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
