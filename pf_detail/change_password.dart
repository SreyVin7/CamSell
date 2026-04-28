// change_password.dart
import 'package:flutter/material.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final oldPassCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();

  @override
  void dispose() {
    oldPassCtrl.dispose();
    newPassCtrl.dispose();
    confirmPassCtrl.dispose();
    super.dispose();
  }

  void _submit() {
    if (newPassCtrl.text != confirmPassCtrl.text) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("ពាក្យសម្ងាត់ថ្មីមិនដូចគ្នា")));
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("ពាក្យសម្ងាត់ត្រូវបានផ្លាស់ប្តូរជោគជ័យ")));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xff1e293b),
      title: const Text("ផ្លាស់ប្តូរពាក្យសម្ងាត់",
          style: TextStyle(color: Colors.white)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
              controller: oldPassCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: "ពាក្យសម្ងាត់ចាស់",
                  labelStyle: TextStyle(color: Colors.white70))),
          const SizedBox(height: 12),
          TextField(
              controller: newPassCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: "ពាក្យសម្ងាត់ថ្មី",
                  labelStyle: TextStyle(color: Colors.white70))),
          const SizedBox(height: 12),
          TextField(
              controller: confirmPassCtrl,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: "បញ្ជាក់ពាក្យសម្ងាត់ថ្មី",
                  labelStyle: TextStyle(color: Colors.white70))),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text("បោះបង់", style: TextStyle(color: Colors.white70))),
        TextButton(
            onPressed: _submit,
            child: const Text("រក្សាទុក",
                style: TextStyle(color: Color(0xfff62f2f)))),
      ],
    );
  }
}
