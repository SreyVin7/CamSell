import 'package:flutter/material.dart';
import 'package:online_shop/address/select_address.dart';
import 'package:online_shop/cart.dart';
import 'package:online_shop/home/bottom_navigationBar.dart';
import 'package:online_shop/home/home.dart';

class Favorite extends StatefulWidget {
  static List<Map<String, String>> favoriteItems = [];

  static void addItem(BuildContext context, Map<String, String> product) {
    if (!favoriteItems.any((item) => item['name'] == product['name'])) {
      favoriteItems.add(product);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("បានបន្ថែមទៅចូលចិត្តជោគជ័យ ❤️")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("ផលិតផលនេះមាននៅក្នុងចូលចិត្តរួចហើយ")),
      );
    }
  }

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final Set<int> _selectedIndices = {};

  bool get _hasItems => Favorite.favoriteItems.isNotEmpty;
  bool get _hasSelection => _selectedIndices.isNotEmpty;

  // ================== ACTION SHEET ==================
  void _showActionSheet(
      BuildContext context, List<Map<String, String>> selectedProducts) {
    if (selectedProducts.isEmpty) return;

    final Map<String, int> quantities = {};
    for (var p in selectedProducts) {
      quantities[p['name'] ?? ''] = 1;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xff0f172a),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            double totalPrice = 0.0;
            for (var p in selectedProducts) {
              final qty = quantities[p['name'] ?? ''] ?? 1;
              totalPrice +=
                  (double.tryParse(p['price']?.replaceAll(',', '') ?? "0") ??
                          0.0) *
                      qty;
            }

            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 40,
                    height: 5,
                    margin: const EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  Text(
                    "ផលិតផលដែលបានជ្រើសរើស (${selectedProducts.length})",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 280),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: selectedProducts.length,
                      itemBuilder: (context, index) {
                        final p = selectedProducts[index];
                        final name = p['name'] ?? '';
                        final qty = quantities[name] ?? 1;

                        return Card(
                          color: Colors.white10,
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                p['img'] ?? p['image'] ?? '',
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(name,
                                style: const TextStyle(color: Colors.white)),
                            subtitle: Text("\$${p['price']}",
                                style:
                                    const TextStyle(color: Color(0xfff62f2f))),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  onPressed: () => qty > 1
                                      ? setModalState(
                                          () => quantities[name] = qty - 1)
                                      : null,
                                  icon: const Icon(Icons.remove,
                                      color: Colors.white),
                                ),
                                Text("$qty",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                IconButton(
                                  onPressed: () => setModalState(
                                      () => quantities[name] = qty + 1),
                                  icon:
                                      const Icon(Icons.add, color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(color: Colors.white24),
                  const SizedBox(height: 12),
                  Text(
                    "សរុប: \$${totalPrice.toStringAsFixed(2)}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);

                        // បញ្ជូនទិន្នន័យទៅ SelectAddress ដោយផ្ទាល់
                        final selectedProductsCopy =
                            List<Map<String, String>>.from(selectedProducts);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SelectAddress(
                                pendingItems: selectedProductsCopy),
                          ),
                        );

                        // សម្អាតការជ្រើសរើស
                        setState(() => _selectedIndices.clear());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xfff62f2f),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Text(
                        "ទិញឥឡូវនេះ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Bottom Navigation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a0f1e),
      bottomNavigationBar: const CustomBottomNav(currentPage: "favorite"),
      body: Column(
        children: [
          const SizedBox(height: 16),
          const Text("ចូលចិត្ត",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Expanded(
            child: _hasItems
                ? GridView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: Favorite.favoriteItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.45,
                    ),
                    itemBuilder: (context, index) {
                      final item = Favorite.favoriteItems[index];
                      final isSelected = _selectedIndices.contains(index);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected
                                ? _selectedIndices.remove(index)
                                : _selectedIndices.add(index);
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff1e293b),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: isSelected
                                      ? const Color(0xfff62f2f)
                                      : Colors.white.withOpacity(0.08),
                                  width: isSelected ? 2.5 : 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                          top: Radius.circular(20)),
                                      child: Image.network(
                                          item['img'] ?? item['image'] ?? "",
                                          width: double.infinity,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item['name'] ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          "\$${item['price']}",
                                          style: const TextStyle(
                                              color: Color(0xfff62f2f),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Positioned(
                              top: 12,
                              right: 12,
                              child: Icon(Icons.favorite,
                                  color: Color(0xfff62f2f), size: 24),
                            ),
                            if (_hasSelection)
                              Positioned(
                                top: 12,
                                left: 12,
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 2.5),
                                    color: isSelected
                                        ? const Color(0xfff62f2f)
                                        : Colors.transparent,
                                  ),
                                  child: isSelected
                                      ? const Icon(Icons.check,
                                          color: Colors.white, size: 18)
                                      : null,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  )
                : const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.favorite_border,
                            size: 90, color: Colors.white38),
                        SizedBox(height: 20),
                        Text("មិនមានទិន្នន័យ",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 17)),
                      ],
                    ),
                  ),
          ),
          if (_hasItems && _hasSelection)
            Container(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              color: const Color(0xff0a0f1e),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              if (_selectedIndices.length ==
                                  Favorite.favoriteItems.length) {
                                _selectedIndices.clear();
                              } else {
                                _selectedIndices.clear();
                                for (int i = 0;
                                    i < Favorite.favoriteItems.length;
                                    i++) {
                                  _selectedIndices.add(i);
                                }
                              }
                            });
                          },
                          icon: const Icon(Icons.select_all,
                              color: Colors.white70),
                          label: Text(
                            _selectedIndices.length ==
                                    Favorite.favoriteItems.length
                                ? "លុបការជ្រើសរើស"
                                : "ជ្រើសរើសទាំងអស់",
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                        ),
                        Text(
                          "បានជ្រើសរើស ${_selectedIndices.length}/${Favorite.favoriteItems.length}",
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14)),
                          child: TextButton(
                            onPressed: () {
                              final selectedItems = _selectedIndices
                                  .map((i) => Favorite.favoriteItems[i])
                                  .toList();

                              for (var product in selectedItems) {
                                Cart.addItem(context, product);
                                Favorite.favoriteItems.removeWhere(
                                    (item) => item['name'] == product['name']);
                              }

                              setState(() => _selectedIndices.clear());

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        "បានបន្ថែម ${selectedItems.length} ផលិតផលទៅកន្ត្រក់ 🛒"),
                                    duration: const Duration(seconds: 1)),
                              );
                            },
                            style: TextButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                foregroundColor: Colors.black),
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_shopping_cart),
                                SizedBox(width: 8),
                                Text("បន្ថែមទៅរទេះ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            final selected = _selectedIndices
                                .map((i) => Favorite.favoriteItems[i])
                                .toList();
                            _showActionSheet(context, selected);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xfff62f2f),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14)),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.shopping_bag),
                              SizedBox(width: 8),
                              Text("ទិញឥឡូវនេះ",
                                  style:
                                      TextStyle(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
