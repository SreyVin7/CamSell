// ignore: file_names
import 'package:flutter/material.dart';
import 'package:online_shop/home/home.dart';
import 'package:online_shop/cart.dart';
import 'package:online_shop/favorite.dart';
import 'package:online_shop/pf_detail/profile.dart';

class CustomBottomNav extends StatelessWidget {
  final String currentPage;

  const CustomBottomNav({super.key, required this.currentPage});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xff1e293b),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(
              context,
              icon: Icons.home,
              label: "ទំព័រដើម",
              page: "home",
              currentPage: currentPage,
              screen: const Home(),
            ),
            _navItem(
              context,
              icon: Icons.favorite,
              label: "ចូលចិត្ត",
              page: "favorite",
              currentPage: currentPage,
              screen: Favorite(),
            ),
            _navItem(
              context,
              icon: Icons.shopping_cart,
              label: "កន្ត្រក់",
              page: "cart",
              currentPage: currentPage,
              screen: const Cart(),
            ),
            _navItem(
              context,
              icon: Icons.person,
              label: "របស់ខ្ញុំ",
              page: "profile",
              currentPage: currentPage,
              screen: Profile(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String page,
    required String currentPage,
    Widget? screen,
  }) {
    final bool isActive = currentPage == page;

    return GestureDetector(
      onTap: () {
        if (screen != null && !isActive) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => screen),
          );
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xfff62f2f) : Colors.white,
          ),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xfff62f2f) : Colors.white,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}
