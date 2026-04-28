import 'package:flutter/material.dart';
import 'package:online_shop/home/product_data.dart';
import 'package:online_shop/address/select_address.dart';

class ProductDetail extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetail({super.key, required this.product});

  // ================= ACTION SHEET =================
  void _showActionSheet(BuildContext context, String buttonTitle) {
    double basePrice =
        double.tryParse(product['price']?.replaceAll(',', '') ?? "0") ?? 0.0;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xff0f172a),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        int quantity = 1;

        return StatefulBuilder(
          builder: (context, setModalState) {
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
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),

                  // PRODUCT
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          product['img'] ?? '',
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name'] ?? '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "\$${product['price']}",
                              style: const TextStyle(
                                color: Color.fromARGB(255, 111, 255, 0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // QUANTITY
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Quantity",
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (quantity > 1) {
                                setModalState(() => quantity--);
                              }
                            },
                            icon: const Icon(Icons.remove, color: Colors.white),
                          ),
                          Text(
                            "$quantity",
                            style: const TextStyle(color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () => setModalState(() => quantity++),
                            icon: const Icon(Icons.add, color: Colors.red),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // TOTAL
                  Text(
                    "Total: \$${(basePrice * quantity).toStringAsFixed(2)}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // BUTTON
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const SelectAddress(
                              pendingItems: [],
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xfff62f2f),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(buttonTitle),
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

  // ================= RELATED =================
  List<Map<String, String>> getRelatedProducts() {
    final category = product['category'];

    return products
        .where((p) => p['category'] == category && p != product)
        .toList();
  }

  // ================= META =================
  Map<String, String> getMeta() {
    switch (product['category']) {
      case "ស្បែកជើង":
        return {
          "size": "39 - 44 EU",
          "color": "Black / White / Grey",
          "desc": "ស្បែកជើងស្រាល និងទាន់សម័យ",
        };

      case "សម្លៀកបំពាក់":
        return {
          "size": "S - XL",
          "color": "Various",
          "desc": "សម្លៀកបំពាក់ទាន់សម័យ",
        };

      case "កាបូប":
        return {
          "size": "Medium",
          "color": "Brown / Black",
          "desc": "កាបូបមានគុណភាពខ្ពស់",
        };

      default:
        return {
          "size": "Standard",
          "color": "Mixed",
          "desc": "ផលិតផលមានគុណភាពល្អ",
        };
    }
  }

  @override
  Widget build(BuildContext context) {
    final related = getRelatedProducts();
    final meta = getMeta();

    return Scaffold(
      backgroundColor: const Color(0xff0b1220),

      // APPBAR
      floatingActionButton: Container(
        margin: const EdgeInsets.only(top: 20),
        child: SizedBox(
          width: 42,
          height: 42,
          child: FloatingActionButton(
            onPressed: () => Navigator.pop(context),
            backgroundColor: Colors.white.withOpacity(0.9),
            elevation: 6,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
              size: 18,
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,

      // ================= BOTTOM BUTTON =================
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: const Color(0xff0f172a),
        child: Row(
          children: [
            // ADD TO CART
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: TextButton(
                  onPressed: () => _showActionSheet(context, "បន្ថែមទៅរទេះ"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_shopping_cart, color: Colors.black),
                      SizedBox(width: 6),
                      Text(
                        "បន្ថែមទៅរទេះ",
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            // BUY NOW
            Expanded(
              child: ElevatedButton(
                onPressed: () => _showActionSheet(context, "ទិញវាឥឡូវនេះ"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xfff62f2f),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.shopping_bag, color: Colors.white),
                    SizedBox(width: 6),
                    Text("ទិញវាឥឡូវនេះ"),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ================= BODY =================
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // IMAGE (FULL WIDTH)
            Image.network(
              product['img'] ?? '',
              height: 300,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            const SizedBox(height: 12),

            // ================= PRODUCT INFO =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: const Color(0xff111827),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['name'] ?? '',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "\$${product['price']}",
                      style: const TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Size: ${meta['size']}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    Text(
                      "Color: ${meta['color']}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      meta['desc']!,
                      style: const TextStyle(color: Colors.white60),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            // ================= TITLE =================
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Related Products",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),

            const SizedBox(height: 10),

            // ================= GRID =================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: related.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.70,
                ),
                itemBuilder: (context, index) {
                  final item = related[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetail(product: item),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xff1e293b),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12),
                              ),
                              child: Image.network(
                                item['img'] ?? '',
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['name'] ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  "\$${item['price']}",
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
