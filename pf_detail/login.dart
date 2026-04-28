import 'package:flutter/material.dart';
import 'package:online_shop/home/home.dart';
import 'package:online_shop/pf_detail/profile.dart';
import 'package:online_shop/pf_detail/user_data.dart';
import 'package:online_shop/pf_detail/register.dart'; // ← បន្ថែម import

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  bool isLoading = false;
  bool obscurePassword = true;

  @override
  void dispose() {
    phoneCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  void _login() {
    if (phoneCtrl.text.isEmpty || passwordCtrl.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("សូមបំពេញលេខទូរស័ព្ទ និងពាក្យសម្ងាត់")),
      );
      return;
    }

    setState(() => isLoading = true);

    Future.delayed(const Duration(seconds: 1), () {
      setState(() => isLoading = false);

      // ===== រក្សាទុកស្ថានភាព Login =====
      UserData.isLoggedIn = true;
      UserData.phone = phoneCtrl.text.trim();
      if (UserData.name.isEmpty) {
        UserData.name = "អ្នកប្រើប្រាស់";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("ចូលប្រព័ន្ធជោគជ័យ ✅")),
      );

      // ===== ទៅ Profile ភ្លាម =====
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              const Center(
                child: Icon(Icons.shopping_bag,
                    size: 80, color: Color(0xfff62f2f)),
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  "សូមចូលប្រព័ន្ធ",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(height: 8),
              const Center(
                child: Text(
                  "ស្វាគមន៍មកកាន់ CamSell",
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
              ),
              const SizedBox(height: 50),

              // Phone Number
              TextField(
                controller: phoneCtrl,
                keyboardType: TextInputType.phone,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "លេខទូរស័ព្ទ",
                  labelStyle: const TextStyle(color: Colors.white70),
                  prefixIcon:
                      const Icon(Icons.phone_android, color: Colors.white70),
                  filled: true,
                  fillColor: const Color(0xff1e293b),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password
              TextField(
                controller: passwordCtrl,
                obscureText: obscurePassword,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "ពាក្យសម្ងាត់",
                  labelStyle: const TextStyle(color: Colors.white70),
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
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.white24),
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Login Button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xfff62f2f),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "ចូលប្រព័ន្ធ",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              // Register Link (កែត្រឹមត្រូវ)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("បង្កើតគណនីថ្មី",
                      style: TextStyle(color: Colors.white70)),
                  TextButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const Register()), // ← កែទៅ Register
                    ),
                    child: const Text(
                      "ចុះឈ្មោះ",
                      style: TextStyle(
                          color: Color(0xfff62f2f),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
