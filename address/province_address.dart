import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_shop/cart.dart';
import 'package:online_shop/favorite.dart';
import 'package:online_shop/home/home.dart';

class ProvinceAddress extends StatefulWidget {
  final List<Map<String, String>> pendingItems;

  const ProvinceAddress({super.key, required this.pendingItems});

  @override
  State<ProvinceAddress> createState() => _ProvinceAddressState();
}

class _ProvinceAddressState extends State<ProvinceAddress> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  String? selectedProvince;

  bool get isValid =>
      nameController.text.trim().isNotEmpty &&
      phoneController.text.trim().isNotEmpty &&
      addressController.text.trim().isNotEmpty &&
      selectedProvince != null;

  final List<String> provinces = [
    "កណ្ដាល",
    "កែប",
    "កោះកុង",
    "កំពង់ចាម",
    "កំពង់ឆ្នាំង",
    "កំពង់ធំ",
    "កំពង់ស្ពឺ",
    "កំពត",
    "ក្រចេះ",
    "តាកែវ",
    "ត្បូងឃ្មុំ",
    "បន្ទាយមានជ័យ",
    "បាត់ដំបង",
    "ប៉ៃលិន",
    "ពោធិ៍សាត់",
    "ព្រៃវែង",
    "ព្រះសីហនុ",
    "ព្រះវិហារ",
    "មណ្ឌលគិរី",
    "រតនគិរី",
    "សៀមរាប",
    "ស្ទឹងត្រែង",
    "ស្វាយរៀង",
    "ឧត្តរមានជ័យ",
  ];

  @override
  void initState() {
    super.initState();
    nameController.addListener(() => setState(() {}));
    phoneController.addListener(() => setState(() {}));
    addressController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a0f1e),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_rounded),
                onPressed: () => Navigator.pop(context),
                color: Colors.white,
              ),
              const SizedBox(height: 10),
              const Text("អាស័យដ្ឋានតាមខេត្ត",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 8),
              const Text("សូមបំពេញព័ត៌មានខាងក្រោម",
                  style: TextStyle(fontSize: 15, color: Colors.white70)),

              const SizedBox(height: 25),

              // Province Dropdown
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xff1e293b),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedProvince,
                    isExpanded: true,
                    dropdownColor: const Color(0xff1e293b),
                    icon:
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                    hint: const Text("ជ្រើសរើសខេត្ត",
                        style: TextStyle(color: Colors.white70)),
                    items: provinces.map((province) {
                      return DropdownMenuItem(
                          value: province,
                          child: Text(province,
                              style: const TextStyle(color: Colors.white)));
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => selectedProvince = value),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Form
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xff1e293b),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                child: Column(
                  children: [
                    TextField(
                      controller: nameController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[a-zA-Z\u1780-\u17FF\s]'))
                      ],
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: "ឈ្មោះពេញ",
                          labelStyle: TextStyle(color: Colors.white70)),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                          labelText: "លេខទូរស័ព្ទ",
                          labelStyle: TextStyle(color: Colors.white70)),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: addressController,
                      maxLines: 3,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: "អាស័យដ្ឋានលម្អិត",
                        labelStyle: TextStyle(color: Colors.white70),
                        alignLabelWithHint: true,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: isValid
                      ? () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: const Color(0xff1e293b),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              title: const Text("ស្កេន QR ដើម្បីបង់ប្រាក់",
                                  style: TextStyle(color: Colors.white)),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset("assets/images/qrcode.jpg",
                                      height: 200),
                                  const SizedBox(height: 15),
                                  Text(
                                      "ខេត្ត: ${selectedProvince ?? 'មិនបានជ្រើសរើស'}",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                  const SizedBox(height: 10),
                                  const Text(
                                      "សូមស្កេន QR ដើម្បីបញ្ចប់ការបញ្ជាទិញ\n(5-10 ថ្ងៃដឹកជញ្ជូន)",
                                      style: TextStyle(color: Colors.white70),
                                      textAlign: TextAlign.center),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // លុបពី Cart
                                    Cart.items.removeWhere(
                                        (item) => item['selected'] == 'true');

                                    // 🔥 លុបពី Favorite
                                    for (var product in widget.pendingItems) {
                                      Favorite.favoriteItems.removeWhere(
                                          (item) =>
                                              item['name'] == product['name']);
                                    }

                                    Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => const Home()),
                                      (route) => false,
                                    );
                                  },
                                  child: const Text("រួចរាល់",
                                      style: TextStyle(
                                          color: Color(0xfff62f2f),
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          );
                        }
                      : null,
                  color: isValid ? const Color(0xfff62f2f) : Colors.grey,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: const Text("បញ្ជាក់ការបញ្ជាទិញ",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
