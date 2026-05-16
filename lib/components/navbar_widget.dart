// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmacy_app/data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPageNotifier,
      builder: (context, int selectedPage, child) {
        return NavigationBarTheme(
          data: NavigationBarThemeData(
            // 1. Hide the default, un-resizable pill indicator
            indicatorColor: Colors.transparent,
            backgroundColor: Colors.transparent,
          ),
          child: NavigationBar(
            selectedIndex: selectedPage,
            onDestinationSelected: (value) {
              selectedPageNotifier.value = value;
            },
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            destinations: [
              NavigationDestination(
                selectedIcon: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 226, 226, 231),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/svg/vector.svg',
                      width: 22,
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                        Color(0xFF4B5563),
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),

                icon: SvgPicture.asset(
                  'assets/svg/vector.svg',
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    Colors.grey,
                    BlendMode.srcIn,
                  ),
                ),

                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.location_on, color: Colors.blue),
                ),
                icon: const Icon(Icons.location_on),
                label: "Location",
              ),
              NavigationDestination(
                selectedIcon: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.phone, color: Colors.blue),
                ),
                icon: const Icon(Icons.phone),
                label: "Phone",
              ),
              NavigationDestination(
                selectedIcon: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.phone, color: Colors.blue),
                ),
                icon: const Icon(Icons.person),
                label: "Person",
              ),
            ],
          ),
        );
      },
    );
  }
}
