import 'package:flutter/material.dart';
import 'package:online_shop/home/bottom_navigationBar.dart';
import 'package:online_shop/pro_detail/product_detail.dart';
import 'product_data.dart';
import 'package:online_shop/favorite.dart';
import 'package:online_shop/cart.dart';
import 'package:online_shop/pf_detail/profile.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: false, home: Home()));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // --- Data Management ---
  String searchQuery = "";
  String selectedLanguage = "KH";
  String selectedCategory = "ណែនាំ"; // សម្រាប់គ្រប់គ្រងការរើស Category

  final List<String> categories = [
    "ណែនាំ",
    "គ្រឿងអគ្គិសនី",
    "ទំនិញទូទៅ",
    "ស្បែកជើង",
    "កាបូប",
    "កុមារ",
    "ឧបករណ៍",
    "គ្រឿងបំពាក់",
    "សម្លៀកបំពាក់",
    "ឡាន/ម៉ូតូ",
  ];

  @override
  Widget build(BuildContext context) {
    // Logic សម្រាប់ Filter ទំនិញតាមឈ្មោះ និងតាម Category
    final filteredProducts = products.where((p) {
      final matchesSearch = p['name']!.toLowerCase().contains(
            searchQuery.toLowerCase(),
          );
      final matchesCategory =
          (selectedCategory == "ណែនាំ") || (p['category'] == selectedCategory);
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xff0a0f1e),
      bottomNavigationBar: const CustomBottomNav(currentPage: "home"),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildCategoryBar(),
            _buildSocialSection(),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(12),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.78,
                      ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        return _productCard(filteredProducts[index]);
                      }, childCount: filteredProducts.length),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- ១. Header (Red Glassmorphism Style) ---
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
      ),
      child: Row(
        children: [
          // Dropdown ភាសា
          Container(
            height: 45,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 0, 0).withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white24),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedLanguage,
                dropdownColor: const Color(0xfff62f2f),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white,
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                onChanged: (String? newValue) =>
                    setState(() => selectedLanguage = newValue!),
                items: ['KH', 'EN']
                    .map((v) => DropdownMenuItem(value: v, child: Text(v)))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // ប្រអប់ស្វែងរក
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                onChanged: (value) => setState(() => searchQuery = value),
                decoration: const InputDecoration(
                  hintText: "ស្វែងរក...",
                  hintStyle: TextStyle(fontSize: 13, color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Color(0xfff62f2f),
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          // ប៊ូតុងស្វែងរក (បន្ថែមថ្មី)
          SizedBox(
            height: 45,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xfff62f2f),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              child: const Text(
                "ស្វែងរក",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- ២. Category Bar (Logic Filtering) ---
  Widget _buildCategoryBar() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color(0xff111827),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCategory == categories[index];
          return GestureDetector(
            onTap: () => setState(() => selectedCategory = categories[index]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xfff62f2f) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  categories[index],
                  style: TextStyle(
                    fontSize: 13,
                    color: isSelected ? Colors.white : Colors.white60,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // --- ៣. Social Section ---
  Widget _buildSocialSection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _socialItem(Icons.send_rounded, "Telegram", Colors.blue),
          _socialItem(Icons.messenger_rounded, "Messenger", Colors.blueAccent),
          _socialItem(Icons.facebook_rounded, "Facebook", Colors.indigo),
          _socialItem(Icons.groups_rounded, "Group", Colors.orange),
        ],
      ),
    );
  }

  Widget _socialItem(IconData icon, String label, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.2)),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
              fontSize: 11, color: Color.fromARGB(162, 255, 255, 255)),
        ),
      ],
    );
  }

  // --- ៤. Product Card (Premium Dark Design) ---
  Widget _productCard(Map<String, String> item) {
    bool isFav = Favorite.favoriteItems.any(
      (e) => e['name'] == item['name'],
    );

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductDetail(product: item)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff1e293b),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                    child: Image.network(
                      item['img'] ?? '',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  /// ❤️ FAVORITE BUTTON (FIXED)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: () {
                        if (!isFav) {
                          Favorite.addItem(context, {
                            "name": item['name'] ?? "",
                            "price": item['price'] ?? "",
                            "image": item['img'] ?? "",
                          });

                          setState(() {}); // 🔥 update UI
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${item['price']}",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 111, 255, 0),
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Cart.addItem(context, item); // ✅ NO MORE ERROR
                        },
                        child: const Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Colors.blueAccent,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
