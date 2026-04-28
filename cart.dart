import 'package:flutter/material.dart';
import 'package:online_shop/address/select_address.dart';
import 'package:online_shop/home/bottom_navigationBar.dart';
import 'package:online_shop/home/home.dart';
import 'favorite.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  static List<Map<String, String>> items = [];

  static void addItem(BuildContext context, Map<String, String> product) {
    final existingIndex =
        items.indexWhere((item) => item['name'] == product['name']);

    if (existingIndex != -1) {
      int qty = int.tryParse(items[existingIndex]['qty'] ?? '1') ?? 1;
      items[existingIndex]['qty'] = (qty + 1).toString();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("បានបន្ថែមទៅកន្ត្រក់ជោគជ័យ 🛒")),
      );
    } else {
      items.add({
        ...product,
        'qty': '1',
        'selected': 'false',
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("បានបន្ថែមទៅកន្ត្រក់ជោគជ័យ 🛒")),
      );
    }
  }

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  List<Map<String, String>> get cartItems => Cart.items;

  double get totalPrice {
    return cartItems.fold(0.0, (sum, item) {
      if ((item['selected'] ?? 'false') != 'true') return sum;
      final price =
          double.tryParse(item['price']?.replaceAll(',', '') ?? "0") ?? 0.0;
      final qty = int.tryParse(item['qty'] ?? "1") ?? 1;
      return sum + (price * qty);
    });
  }

  int get selectedCount =>
      cartItems.where((e) => e['selected'] == 'true').length;

  void updateQty(int index, int change) {
    setState(() {
      int qty = int.tryParse(cartItems[index]['qty'] ?? "1") ?? 1;
      qty += change;
      if (qty < 1) qty = 1;
      cartItems[index]['qty'] = qty.toString();
    });
  }

  void toggleSelect(int index) {
    setState(() {
      final current = cartItems[index]['selected'] ?? 'false';
      cartItems[index]['selected'] = (current == 'true') ? 'false' : 'true';
    });
  }

  void deleteItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void _checkout() {
    if (selectedCount == 0) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xff1e293b),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text("បញ្ជាក់ការទិញ",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text("អ្នកបានជ្រើសរើស $selectedCount ផលិតផល",
                  style: const TextStyle(color: Colors.white70)),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white10,
                          foregroundColor: Colors.white),
                      onPressed: () => Navigator.pop(context),
                      child: const Text("បោះបង់"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xfff62f2f),
                          foregroundColor: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SelectAddress(
                                      pendingItems: [],
                                    )));
                      },
                      child: const Text("បន្ត"),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a0f1e),
      appBar: AppBar(
        backgroundColor: const Color(0xff0a0f1e),
        elevation: 0,
        centerTitle: true,
        title: const Text("កន្ត្រក់",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 22)),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(
            child: cartItems.isEmpty
                ? const Center(
                    child: Text("មិនទាន់មានផលិតផលក្នុងកន្ត្រក់",
                        style: TextStyle(color: Colors.white54, fontSize: 16)))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      final isSelected = item['selected'] == 'true';

                      return Dismissible(
                        key: Key(item['name'] ?? index.toString()),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.only(right: 30),
                          decoration: const BoxDecoration(
                              color: Colors.red,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: const Icon(Icons.delete,
                              color: Colors.white, size: 26),
                        ),
                        onDismissed: (direction) {
                          deleteItem(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("បានលុបផលិតផល")));
                        },
                        child: GestureDetector(
                          onTap: () => toggleSelect(index),
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color(0xff1e293b),
                              borderRadius: BorderRadius.circular(16),
                              border: isSelected
                                  ? Border.all(
                                      color: Colors.redAccent, width: 2.5)
                                  : null,
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                      item['img'] ?? item['image'] ?? "",
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(item['name'] ?? "",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15)),
                                      const SizedBox(height: 6),
                                      Text("\$${item['price']}",
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                          onPressed: () => updateQty(index, -1),
                                          icon: const Icon(Icons.remove,
                                              size: 18, color: Colors.white)),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 6),
                                          child: Text(item['qty'] ?? "1",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15))),
                                      IconButton(
                                          onPressed: () => updateQty(index, 1),
                                          icon: const Icon(Icons.add,
                                              size: 18, color: Colors.white)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (selectedCount > 0)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: const BoxDecoration(
                  color: Color(0xff0a0f1e),
                  border: Border(top: BorderSide(color: Colors.white24))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("បានជ្រើស $selectedCount ផលិតផល",
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 14)),
                      Text("\$${totalPrice.toStringAsFixed(2)}",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    ],
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xfff62f2f),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    onPressed: _checkout,
                    child: const Text("Checkout",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(currentPage: "cart"),
    );
  }

  // Bottom Navigation (រក្សាដដែល)
}
