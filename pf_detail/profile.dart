import 'package:flutter/material.dart';
import 'package:online_shop/favorite.dart';
import 'package:online_shop/home/bottom_navigationBar.dart';
import 'package:online_shop/home/home.dart';
import 'package:online_shop/cart.dart';
import 'package:online_shop/pf_detail/change_password.dart';
import 'package:online_shop/pf_detail/edit_profile.dart';
import 'package:online_shop/pf_detail/login.dart';
import 'package:online_shop/pf_detail/register.dart';
import 'package:online_shop/pf_detail/user_data.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh ពេលត្រឡប់មក Profile វិញ
    setState(() {});
  }

  void _editProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EditProfilePage()),
    ).then((_) => setState(() {}));
  }

  void _changePassword() {
    showDialog(
      context: context,
      builder: (context) => const ChangePasswordDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLoggedIn = UserData.isLoggedIn;

    return Scaffold(
      backgroundColor: const Color(0xff0a0f1e),
      appBar: AppBar(
        backgroundColor: const Color(0xff1e3a8a),
        elevation: 0,
        title: const Text("My Account",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: isLoggedIn ? _buildLoggedInUI() : _buildLoginPromptUI(),
      bottomNavigationBar: const CustomBottomNav(currentPage: "profile"),
    );
  }

  // ================== UI ពេលបាន Login ==================
  Widget _buildLoggedInUI() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
            decoration: const BoxDecoration(
              color: Color(0xff1e3a8a),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: NetworkImage(UserData.profileImage),
                      backgroundColor: Colors.grey[800],
                    ),
                    GestureDetector(
                      onTap: _editProfile,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xfff62f2f),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt,
                            size: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  UserData.name.isNotEmpty ? UserData.name : "អ្នកប្រើប្រាស់",
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 6),
                Text(UserData.phone,
                    style:
                        const TextStyle(fontSize: 16, color: Colors.white70)),
              ],
            ),
          ),
          const SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Personal Info",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                _buildInfoTile(
                    Icons.person_outline, "Your name", UserData.name),
                _buildInfoTile(
                    Icons.phone_outlined, "Phone Number", UserData.phone),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _editProfile,
                    icon: const Icon(Icons.edit),
                    label: const Text("Edit Profile"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xfff62f2f),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text("Setting",
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 12),
                _buildSettingTile(Icons.lock_outline, "Password",
                    "Change Account password", _changePassword),
                _buildSettingTile(
                    Icons.language, "Language", "ភាសាខ្មែរ", () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================== UI ពេលមិនទាន់ Login ==================
  Widget _buildLoginPromptUI() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_outline, size: 100, color: Colors.white38),
            const SizedBox(height: 30),
            const Text(
              "សូមចូលគណនីជាមុនសិន",
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              "ដើម្បីមើលព័ត៌មានផ្ទាល់ខ្លួន",
              style: TextStyle(color: Colors.white70, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Login())),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xfff62f2f),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("ចូលប្រព័ន្ធ", style: TextStyle(fontSize: 17)),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => const Register())),
              child: const Text(
                "ចុះឈ្មោះគណនីថ្មី",
                style: TextStyle(
                    color: Color(0xfff62f2f),
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xff1e293b),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 26),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style:
                        const TextStyle(color: Colors.white70, fontSize: 13)),
                const SizedBox(height: 4),
                Text(
                  value.isNotEmpty ? value : "មិនទាន់មាន",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 18),
        ],
      ),
    );
  }

  Widget _buildSettingTile(
      IconData icon, String title, String subtitle, VoidCallback onTap) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: Colors.white70),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      subtitle: Text(subtitle,
          style: const TextStyle(color: Colors.white60, fontSize: 13)),
      trailing:
          const Icon(Icons.arrow_forward_ios, color: Colors.white38, size: 18),
    );
  }
}
