// edit_profile.dart
import 'package:flutter/material.dart';
import 'package:online_shop/pf_detail/user_data.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameCtrl;
  late TextEditingController phoneCtrl;

  @override
  void initState() {
    super.initState();
    nameCtrl = TextEditingController(text: UserData.name);
    phoneCtrl = TextEditingController(text: UserData.phone);
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    super.dispose();
  }

  void _saveChanges() {
    UserData.name = nameCtrl.text.trim();
    UserData.phone = phoneCtrl.text.trim();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("បានរក្សាទុកព័ត៌មានជោគជ័យ ✅")),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a0f1e),
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: const Color(0xff1e3a8a),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(UserData.profileImage),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: nameCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "ឈ្មោះពេញ",
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: const Color(0xff1e293b),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "លេខទូរស័ព្ទ",
                labelStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: const Color(0xff1e293b),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _saveChanges,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xfff62f2f),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("រក្សាទុក",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
