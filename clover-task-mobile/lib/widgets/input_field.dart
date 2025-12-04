// lib/widgets/input_field.dart
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool obscure;
  final VoidCallback? toggleVisibility;
  final TextInputType keyboardType;

  const InputField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.obscure = false,
    this.toggleVisibility,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            )),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Theme.of(context).colorScheme.surface,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: borderRadius,
              borderSide:
                  BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
            ),
            suffixIcon: toggleVisibility == null
                ? null
                : IconButton(
                    icon: Icon(obscure ? Icons.visibility_off : Icons.visibility),
                    onPressed: toggleVisibility,
                  ),
          ),
        ),
      ],
    );
  }
}


// import 'package:flutter/material.dart';

// class InputField extends StatelessWidget {
//   final String label;
//   final String hint;
//   final TextEditingController controller;
//   final bool obscure;
//   final VoidCallback? toggleVisibility;

//   const InputField({
//     super.key,
//     required this.label,
//     required this.hint,
//     required this.controller,
//     this.obscure = false,
//     this.toggleVisibility,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           label,
//           style: const TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w500,
//             color: Color(0xFF333333),
//           ),
//         ),
//         const SizedBox(height: 8),
//         TextField(
//           controller: controller,
//           obscureText: obscure,
//           decoration: InputDecoration(
//             hintText: hint,
//             filled: true,
//             fillColor: Colors.white,
//             border: OutlineInputBorder(
//               borderRadius: BorderRadius.circular(12),
//               borderSide:
//                   const BorderSide(color: Color(0xFFE5E7EB), width: 1),
//             ),
//             suffixIcon: toggleVisibility != null
//                 ? IconButton(
//                     icon: Icon(
//                       obscure ? Icons.visibility_off : Icons.visibility,
//                       color: Colors.grey,
//                     ),
//                     onPressed: toggleVisibility,
//                   )
//                 : null,
//           ),
//         ),
//       ],
//     );
//   }
// }
