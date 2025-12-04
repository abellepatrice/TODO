// lib/pages/signup_page.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/input_field.dart';

final supabase = Supabase.instance.client;

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> with SingleTickerProviderStateMixin {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;
  bool loading = false;

  late final AnimationController _animController;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _slide = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    setState(() => loading = true);
    final email = emailController.text.trim();
    final password = passwordController.text;
    final fullName = nameController.text.trim();

    try {
      final res = await supabase.auth.signUp(
        email: email,
        password: password,
        // pass user metadata with the signup
        data: {'full_name': fullName},
      );

      if (res.user != null || res.session != null) {
        // optionally navigate directly to home if session exists
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showMessage('Check your email for verification (if enabled).');
        Navigator.pop(context);
      }
    } on AuthException catch (e) {
      _showMessage(e.message);
    } catch (e) {
      _showMessage('Unexpected error: $e');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  void _showMessage(String m) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SlideTransition(
            position: _slide,
            child: SizedBox(
              width: 420,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Hero(tag: 'logo-hero', child: Icon(Icons.edit_note, size: 72, color: const Color(0xFFB3E283))),
                  const SizedBox(height: 20),
                  const Text('Create Account', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  const Text('Join the Clover Task Manager', style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 24),

                  InputField(label: 'Full Name', hint: 'Enter your name', controller: nameController),
                  const SizedBox(height: 14),
                  InputField(label: 'Email', hint: 'Enter your email', controller: emailController, keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 14),
                  InputField(label: 'Password', hint: 'Create a password', controller: passwordController, obscure: obscure, toggleVisibility: () { setState(() => obscure = !obscure); }),
                  const SizedBox(height: 20),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: loading
                        ? const SizedBox(height: 56, child: Center(child: CircularProgressIndicator()))
                        : SizedBox(
                            height: 56,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(backgroundColor: primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                              onPressed: _signUp,
                              child: const Text('Sign Up', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                            ),
                          ),
                  ),

                  const SizedBox(height: 12),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    const Text('Already have an account? '),
                    GestureDetector(onTap: () => Navigator.pop(context), child: Text('Login', style: TextStyle(color: primary, fontWeight: FontWeight.w600))),
                  ]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import '../widgets/input_field.dart';

// class SignupPage extends StatefulWidget {
//   const SignupPage({super.key});

//   @override
//   State<SignupPage> createState() => _SignupPageState();
// }

// class _SignupPageState extends State<SignupPage> {
//   final nameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool obscure = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: SizedBox(
//             width: 400,
//             child: Column(
//               children: [
//                 const Icon(Icons.health_and_safety,
//                     size: 70, color: Color(0xFFB3E283)),
//                 const SizedBox(height: 24),

//                 const Text(
//                   "Create Account",
//                   style: TextStyle(
//                       fontSize: 32, fontWeight: FontWeight.bold),
//                 ),

//                 const SizedBox(height: 8),
//                 const Text(
//                   "Join the Health Hub community",
//                   style: TextStyle(fontSize: 16, color: Colors.black54),
//                 ),

//                 const SizedBox(height: 32),

//                 InputField(
//                   label: "Full Name",
//                   hint: "Enter your name",
//                   controller: nameController,
//                 ),

//                 const SizedBox(height: 20),

//                 InputField(
//                   label: "Email",
//                   hint: "Enter your email",
//                   controller: emailController,
//                 ),

//                 const SizedBox(height: 20),

//                 InputField(
//                   label: "Password",
//                   hint: "Enter your password",
//                   controller: passwordController,
//                   obscure: obscure,
//                   toggleVisibility: () {
//                     setState(() {
//                       obscure = !obscure;
//                     });
//                   },
//                 ),

//                 const SizedBox(height: 32),

//                 SizedBox(
//                   width: double.infinity,
//                   height: 56,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor:
//                           Theme.of(context).colorScheme.primary,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     onPressed: () {},
//                     child: const Text(
//                       "Sign Up",
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 18),
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 16),

//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: Text(
//                     "Already have an account? Login",
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.primary,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
