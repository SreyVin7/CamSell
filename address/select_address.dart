import 'package:flutter/material.dart';
import 'package:online_shop/address/city_address.dart';
import 'package:online_shop/address/province_address.dart';

class SelectAddress extends StatefulWidget {
  final List<Map<String, String>> pendingItems; // ← ទទួលទិន្នន័យពី Favorite

  const SelectAddress({super.key, required this.pendingItems});

  @override
  State<SelectAddress> createState() => _SelectAddressState();
}

class _SelectAddressState extends State<SelectAddress> {
  bool isPhnomPenh = false;
  bool isProvince = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a0f1e),
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => Navigator.pop(context),
                color: Colors.white,
                iconSize: 20,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "សូមជ្រើសរើសទីតាំងរបស់អ្នក",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xff1e293b),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildLocationItem(
                    title: "សម្រាប់អ្នកនៅភ្នំពេញ",
                    value: isPhnomPenh,
                    onChanged: (val) {
                      setState(() {
                        isPhnomPenh = val!;
                        if (val) isProvince = false;
                      });
                      if (val == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CityAddress(
                              pendingItems: widget.pendingItems,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  const Divider(
                      color: Colors.white10, indent: 20, endIndent: 20),
                  _buildLocationItem(
                    title: "សម្រាប់អ្នកនៅតាមខេត្ត",
                    value: isProvince,
                    onChanged: (val) {
                      setState(() {
                        isProvince = val!;
                        if (val) isPhnomPenh = false;
                      });
                      if (val == true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ProvinceAddress(
                              pendingItems: widget.pendingItems,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationItem({
    required String title,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 15, color: Colors.white70),
          ),
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xfff62f2f),
            checkColor: Colors.white,
            side: const BorderSide(color: Colors.white30),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
        ],
      ),
    );
  }
}
