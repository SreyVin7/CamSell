import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_shop/pf_detail/profile.dart';
import 'package:online_shop/pf_detail/user_data.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  void dispose() {
    nameCtrl.dispose();
    phoneCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }

  void _register() {
    if (nameCtrl.text.trim().isEmpty ||
        phoneCtrl.text.trim().isEmpty ||
        passwordCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("សូមបំពេញព័ត៌មានឱ្យបានគ្រប់គ្រាន់")),
      );
      return;
    }

    if (passwordCtrl.text != confirmPasswordCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("ពាក្យសម្ងាត់មិនដូចគ្នា")),
      );
      return;
    }

    // ចាប់ផ្តើម Loading
    setState(() => isLoading = true);

    // Simulate API call
    Future.delayed(const Duration(seconds: 1), () {
      setState(() => isLoading = false);

      // ===== រក្សាទុកទិន្នន័យ =====
      UserData.isLoggedIn = true;
      UserData.name = nameCtrl.text.trim();
      UserData.phone = phoneCtrl.text.trim();
      // អាចបន្ថែម email បើចង់
      // UserData.email = "${nameCtrl.text.toLowerCase().replaceAll(' ', '')}@example.com";

      // ===== បង្ហាញសារ =====
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("ចុះឈ្មោះជោគជ័យ ✅")),
      );

      // ===== ទៅកាន់ Profile ភ្លាម =====
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const Profile()),
        (route) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0a0f1e),
      appBar: AppBar(
        backgroundColor: const Color(0xff0a0f1e),
        title: const Text("ចុះឈ្មោះ"),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              "មានគណនីរួចហើយ?",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              "សូមបំពេញព័ត៌មានខាងក្រោម",
              style: TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: nameCtrl,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "ឈ្មោះពេញ",
                prefixIcon:
                    const Icon(Icons.person_outline, color: Colors.white70),
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
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // ← អនុញ្ញាតតែលេខ
              ],
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "លេខទូរស័ព្ទ",
                prefixIcon:
                    const Icon(Icons.phone_android, color: Colors.white70),
                filled: true,
                fillColor: const Color(0xff1e293b),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordCtrl,
              obscureText: obscurePassword,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "ពាក្យសម្ងាត់",
                prefixIcon:
                    const Icon(Icons.lock_outline, color: Colors.white70),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white70,
                  ),
                  onPressed: () =>
                      setState(() => obscurePassword = !obscurePassword),
                ),
                filled: true,
                fillColor: const Color(0xff1e293b),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: confirmPasswordCtrl,
              obscureText: obscureConfirm,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "បញ្ជាក់ពាក្យសម្ងាត់",
                prefixIcon:
                    const Icon(Icons.lock_outline, color: Colors.white70),
                suffixIcon: IconButton(
                  icon: Icon(
                    obscureConfirm ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white70,
                  ),
                  onPressed: () =>
                      setState(() => obscureConfirm = !obscureConfirm),
                ),
                filled: true,
                fillColor: const Color(0xff1e293b),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: isLoading ? null : _register,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xfff62f2f),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "ចុះឈ្មោះ",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("មានគណនីរួចហើយ?",
                    style: TextStyle(color: Colors.white70)),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "ចូលប្រព័ន្ធ",
                    style: TextStyle(
                        color: Color(0xfff62f2f), fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
