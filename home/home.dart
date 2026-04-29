import 'package:flutter/material.dart';
import 'package:online_shop/home/bottom_navigationBar.dart';
import 'package:online_shop/pro_detail/product_detail.dart';
import 'product_data.dart';
import 'package:online_shop/favorite.dart';
import 'package:online_shop/cart.dart';
import 'package:online_shop/pf_detail/profile.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
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
  String selectedCategory = "ណែនាំ";

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
    // Filter Products
    final filteredProducts = products.where((p) {
      final matchesSearch =
          p['name']!.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory =
          (selectedCategory == "ណែនាំ") || (p['category'] == selectedCategory);
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 35, 61),
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
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return _productCard(filteredProducts[index]);
                        },
                        childCount: filteredProducts.length,
                      ),
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

  // ==================== HEADER ====================
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // Language Dropdown
          Container(
            height: 48, // ដំឡើងកម្ពស់បន្តិចដើម្បីឱ្យមើលទៅស្រឡះ
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              // ប្រើ Gradient ដើម្បីឱ្យពណ៌មើលទៅមានជម្រៅ (Depth)
              gradient: const LinearGradient(
                colors: [Color(0xfff62f2f), Color(0xffd32f2f)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16), // បង្កើនភាពមូលនៃជ្រុង
              boxShadow: [
                BoxShadow(
                  color: const Color(0xfff62f2f).withOpacity(0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4), // ស្រមោលធ្លាក់ចុះក្រោមតិចៗ
                ),
              ],
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedLanguage,
                dropdownColor:
                    const Color(0xff1b233d), // ពណ៌ផ្ទៃខាងក្រោយពេលចុចលើ Dropdown
                icon: const Icon(
                  Icons
                      .unfold_more_rounded, // ប្តូរ Icon ឱ្យមើលទៅប្លែក និងស្អាតជាងមុន
                  color: Colors.white,
                  size: 20,
                ),
                alignment: Alignment.center, // ដាក់ឱ្យអក្សរនៅកណ្តាល
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w800, // អក្សរដិតច្បាស់
                  letterSpacing: 1.2,
                ),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() => selectedLanguage = newValue);
                  }
                },
                items: ['KH', 'EN']
                    .map((v) => DropdownMenuItem(
                          value: v,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              v,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Search Field
          Expanded(
            child: Container(
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xfff8f9fa),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                onChanged: (value) => setState(() => searchQuery = value),
                style: const TextStyle(fontSize: 15, color: Colors.black87),
                decoration: const InputDecoration(
                  hintText: "ស្វែងរកផលិតផល...",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: const Color(0xfff62f2f),
                    size: 22,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 13,
                    horizontal: 4,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          // Search Button
          SizedBox(
            height: 46,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xfff62f2f),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 18),
              ),
              child: const Text(
                "ស្វែងរក",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==================== CATEGORY BAR ====================
  Widget _buildCategoryBar() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 27, 35, 61),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.05)),
        ),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = selectedCategory == category;

          return GestureDetector(
            onTap: () => setState(() => selectedCategory = category),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color:
                    isSelected ? const Color(0xfff62f2f) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 13.5,
                    color: isSelected ? Colors.white : Colors.white60,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ==================== SOCIAL SECTION ====================
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
            border: Border.all(color: color.withOpacity(0.25)),
          ),
          child: Icon(icon, color: color, size: 26),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  // ==================== PRODUCT CARD ====================
  Widget _productCard(Map<String, String> item) {
    final bool isFav = Favorite.favoriteItems.any(
      (e) => e['name'] == item['name'],
    );

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ProductDetail(product: item)),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xff1e293b),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.35),
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
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(20)),
                    child: Image.network(
                      item['img'] ?? '',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
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
                          setState(() {});
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(7),
                        decoration: const BoxDecoration(
                          color: Colors.black38,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isFav ? Icons.favorite : Icons.favorite_border,
                          color: isFav ? Colors.red : Colors.white,
                          size: 20,
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
                      fontSize: 13.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${item['price']}",
                        style: const TextStyle(
                          color: Color(0xfff62f2f),
                          fontWeight: FontWeight.w900,
                          fontSize: 16.5,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Cart.addItem(context, item),
                        child: const Icon(
                          Icons.add_shopping_cart_rounded,
                          color: Colors.blueAccent,
                          size: 22,
                        ),
                      ),
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
