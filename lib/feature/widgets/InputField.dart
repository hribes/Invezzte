import 'package:flutter/material.dart';

class Inputfield extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData? prefixIcon;
  final bool isDropdown;
  final VoidCallback? onTap;
  final TextEditingController? controller;

  const Inputfield({
    super.key,
    required this.label,
    required this.hintText,
    this.prefixIcon,
    this.isDropdown = false,
    this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            readOnly: isDropdown, // Se for dropdown, o usuário não digita, só clica
            onTap: onTap,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: const Color(0xFFFFB300)) : null,
              suffixIcon: isDropdown 
                  ? const Icon(Icons.keyboard_arrow_down, color: Color(0xFFB095FF)) 
                  : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFB095FF), width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFF8F64FF), width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}