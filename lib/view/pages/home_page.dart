import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pharmacy_app/components/banner_widget.dart';
import 'package:pharmacy_app/components/dropdown_widget.dart';
import 'package:pharmacy_app/components/horizintal_list_widget.dart';
import 'package:pharmacy_app/data/pharmacy_data.dart';
import 'package:pharmacy_app/data/veterinary_data.dart' hide pharmacyList;
import 'package:pharmacy_app/view/pages/details_page.dart';

List<String> pharmacyImage = [
  "assets/images/inside-one.jpg",
  "assets/images/inside-two.jpg",
  "assets/images/inside-three.jpg",
];

List<String> veterinarImage = [
  "assets/images/aybolit.jpg",
  "assets/images/vet-second.jpg",
  "assets/images/vet-third.jpg",
  "assets/images/vet-fourth.jpg",
];

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _pharmacyScrollController = ScrollController();
  final ScrollController _veterinaryScrollController = ScrollController();

  int? _highlightedIndex;
  int? _veterinaryHighlightedIndex;
  bool _noResult = false;

  @override
  void dispose() {
    _searchController.dispose();
    _pharmacyScrollController.dispose();
    _veterinaryScrollController.dispose();
    super.dispose();
  }

  void _scrollToIndex(ScrollController controller, int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!controller.hasClients) return;
      final targetOffset = (index * HorizontalList.itemExtent).clamp(
        0.0,
        controller.position.maxScrollExtent,
      );
      controller.animateTo(
        targetOffset,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  void _onSearchChanged(String query) {
    final trimmed = query.trim().toLowerCase();

    if (trimmed.isEmpty) {
      setState(() {
        _highlightedIndex = null;
        _veterinaryHighlightedIndex = null;
        _noResult = false;
      });
      return;
    }

    final pharmacyIndex = pharmacies.indexWhere(
      (title) => title.toLowerCase().contains(trimmed),
    );
    final veterinaryIndex = veterinaryName.indexWhere(
      (title) => title.toLowerCase().contains(trimmed),
    );

    setState(() {
      _highlightedIndex = pharmacyIndex == -1 ? null : pharmacyIndex;
      _veterinaryHighlightedIndex = veterinaryIndex == -1
          ? null
          : veterinaryIndex;
      _noResult = pharmacyIndex == -1 && veterinaryIndex == -1;
    });

    if (pharmacyIndex != -1) {
      _scrollToIndex(_pharmacyScrollController, pharmacyIndex);
    }
    if (veterinaryIndex != -1) {
      _scrollToIndex(_veterinaryScrollController, veterinaryIndex);
    }
  }

  int _indexForCity(List<String> addresses, List<String> places, String city) {
    for (int i = 0; i < addresses.length; i++) {
      final inAddress = addresses[i].toLowerCase().contains(city);
      final inPlace =
          i < places.length && places[i].toLowerCase().contains(city);
      if (inAddress || inPlace) return i;
    }
    return -1;
  }

  void _onCityChanged(String city) {
    final c = city.trim().toLowerCase();

    final pharmacyIndex = _indexForCity(adresses, location, c);
    final veterinaryIndex = _indexForCity(veterinaryAdress, vetLocation, c);

    setState(() {
      _searchController.clear();
      _highlightedIndex = pharmacyIndex == -1 ? null : pharmacyIndex;
      _veterinaryHighlightedIndex = veterinaryIndex == -1
          ? null
          : veterinaryIndex;
      _noResult = pharmacyIndex == -1 && veterinaryIndex == -1;
    });

    if (pharmacyIndex != -1) {
      _scrollToIndex(_pharmacyScrollController, pharmacyIndex);
    }
    if (veterinaryIndex != -1) {
      _scrollToIndex(_veterinaryScrollController, veterinaryIndex);
    }
  }

  // X button pressed: remove the city filter and bring everything back
  void _onCityCleared() {
    setState(() {
      _searchController.clear();
      _highlightedIndex = null;
      _veterinaryHighlightedIndex = null;
      _noResult = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: Text(
              "Ýeri",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Dropdown button
          DropdownWidget(
            onCityChanged: _onCityChanged,
            onCleared: _onCityCleared,
          ),
          // Searchbar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                onChanged: _onSearchChanged,
                decoration: InputDecoration(
                  labelText: "Gözleg...",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SvgPicture.asset(
                      "assets/svg/search.svg",
                      width: 16,
                      height: 16,
                    ),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            _onSearchChanged('');
                          },
                        )
                      : null,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
          ),
          if (_noResult)
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 6.0),
              child: Text(
                "Netije tapylmady",
                style: TextStyle(fontSize: 13, color: Colors.red.shade400),
              ),
            ),
          // Banner
          buildBanner(
            imagePath: "assets/images/image-one.jpg",
            title: "Biz lukmanlar gije-gündiz hyzmatyňyzda",
            subtitle:
                "Saglygy goramak we bu ugurda alnyp barylýan işleri durmuşa geçirmek biziň üçin möhümdir",
          ),
          // Dermanhanalar section
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 0.0,
              top: 15.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Dermanhanalar",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/-pharmacy_page');
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Hemmesi",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          HorizontalList(
            images: pharmacyImage,
            titles: pharmacies,
            addresses: adresses,
            points: 5.0,
            reviews: "(58 Halandy)",
            kilometer: "25 km/40min",
            clinic: location, // Todo here
            scrollController: _pharmacyScrollController,
            highlightedIndex: _highlightedIndex,
            onItemTap: (index) {
              final pharmacy = pharmacyList[index];
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PharmacyDetailsPage(pharmacy: pharmacy),
                ),
              );
            },
          ),

          // Weterinariýa horizontal list
          Padding(
            padding: const EdgeInsets.only(
              left: 15.0,
              right: 15.0,
              bottom: 0.0,
              top: 15.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Weterinariýa",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    "Hemmesi",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          HorizontalList(
            images: veterinarImage,
            titles: veterinaryName,
            addresses: veterinaryAdress,
            points: 5.0,
            reviews: "(58 Reviews)",
            kilometer: "25 km/40min",
            clinic: vetLocation,
            scrollController: _veterinaryScrollController,
            highlightedIndex: _veterinaryHighlightedIndex,
          ),
        ],
      ),
    );
  }
}
