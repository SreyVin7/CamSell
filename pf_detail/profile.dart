// profile.dart
import 'package:flutter/material.dart';
import 'package:online_shop/home/bottom_navigationBar.dart';
import 'package:online_shop/pf_detail/user_data.dart';
import 'package:online_shop/pf_detail/guest.dart'; // បើមាន

class Profile extends StatelessWidget {
  const Profile({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xff1e293b),
        title:
            const Text("ចាកចេញពីគណនី", style: TextStyle(color: Colors.white)),
        content: const Text(
          "តើអ្នកពិតជាចង់ចាកចេញពីគណនីនេះមែនទេ?",
          style: TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text("បោះបង់", style: TextStyle(color: Colors.white70)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              UserData.logout();

              // ត្រឡប់ទៅ Guest ភ្លាមៗ
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const Guest()),
                (route) => false,
              );
            },
            child: const Text(
              "ចាកចេញ",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: Colors.white.withOpacity(0.08),
        radius: 24,
        child: Icon(icon, color: const Color(0xfff62f2f), size: 28),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16.5,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.white38),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a0f1e),
      appBar: AppBar(
        backgroundColor: const Color(0xff0a0f1e),
        elevation: 0,
        title: const Text("ប្រវត្តិរូប",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),

          // Profile Header
          Column(
            children: [
              CircleAvatar(
                radius: 58,
                backgroundColor: Colors.white12,
                backgroundImage:
                    const NetworkImage("https://i.pravatar.cc/300"),
              ),
              const SizedBox(height: 16),
              Text(
                UserData.name.isNotEmpty ? UserData.name : "អ្នកប្រើប្រាស់",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                UserData.phone,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 15,
                ),
              ),
            ],
          ),

          const SizedBox(height: 40),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildMenuItem(Icons.person_outline, "កែប្រវត្តិរូប", () {}),
                _buildMenuItem(
                    Icons.shopping_bag_outlined, "ការបញ្ជាទិញ", () {}),
                _buildMenuItem(Icons.location_on_outlined, "អាសយដ្ឋាន", () {}),
                _buildMenuItem(Icons.help_outline, "ជំនួយ & សំណួរ", () {}),

                const SizedBox(height: 50),

                // Logout Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () => _showLogoutDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "ចាកចេញពីគណនី",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNav(currentPage: "profile"),
    );
  }
}
