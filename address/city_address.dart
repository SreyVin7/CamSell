import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_shop/cart.dart';
import 'package:online_shop/favorite.dart';
import 'package:online_shop/home/home.dart';

class CityAddress extends StatefulWidget {
  final List<Map<String, String>> pendingItems;

  const CityAddress({super.key, required this.pendingItems});

  @override
  State<CityAddress> createState() => _CityAddressState();
}

class _CityAddressState extends State<CityAddress> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController addressCtrl = TextEditingController();

  bool get isValid =>
      nameCtrl.text.trim().isNotEmpty &&
      phoneCtrl.text.trim().isNotEmpty &&
      addressCtrl.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    nameCtrl.addListener(() => setState(() {}));
    phoneCtrl.addListener(() => setState(() {}));
    addressCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    addressCtrl.dispose();
    super.dispose();
  }

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
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                "ភ្នំពេញ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xff1e293b),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: nameCtrl,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[a-zA-Z\u1780-\u17FF\s]'))
                    ],
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    decoration: const InputDecoration(
                        labelText: "ឈ្មោះ",
                        labelStyle: TextStyle(color: Colors.white70)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phoneCtrl,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    decoration: const InputDecoration(
                        labelText: "លេខទូរស័ព្ទ",
                        labelStyle: TextStyle(color: Colors.white70)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: addressCtrl,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                    decoration: const InputDecoration(
                        labelText: "អាស័យដ្ឋាន",
                        labelStyle: TextStyle(color: Colors.white70)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: MaterialButton(
                onPressed: isValid
                    ? () {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            backgroundColor: const Color(0xff1e293b),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                            title: const Row(
                              children: [
                                Icon(Icons.check_circle, color: Colors.green),
                                SizedBox(width: 10),
                                Text("ជោគជ័យ",
                                    style: TextStyle(color: Colors.white)),
                              ],
                            ),
                            content: const Text(
                              "បានបញ្ជាទិញជោគជ័យ សូមរង់ចាំរយៈពេល 3-4 ថ្ងៃ",
                              style: TextStyle(color: Colors.white70),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  // លុបពី Cart
                                  Cart.items.removeWhere(
                                      (item) => item['selected'] == 'true');

                                  // 🔥 លុបពី Favorite
                                  for (var product in widget.pendingItems) {
                                    Favorite.favoriteItems.removeWhere((item) =>
                                        item['name'] == product['name']);
                                  }

                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => const Home()),
                                    (route) => false,
                                  );
                                },
                                child: const Text("យល់ព្រម",
                                    style: TextStyle(color: Color(0xfff62f2f))),
                              ),
                            ],
                          ),
                        );
                      }
                    : null,
                color: isValid ? const Color(0xfff62f2f) : Colors.grey,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding: const EdgeInsets.all(16),
                child: const Text("បញ្ជាក់",
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
