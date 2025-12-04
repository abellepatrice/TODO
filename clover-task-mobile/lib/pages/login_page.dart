// lib/pages/login_page.dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/input_field.dart';

final supabase = Supabase.instance.client;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;
  bool loading = false;

  late final AnimationController _animController;
  late final Animation<double> _fadeIn;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _fadeIn = CurvedAnimation(
        parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    // basic validation
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      _showMessage("Email & password are required");
      return;
    }

    setState(() => loading = true);

    try {
      final res = await supabase.auth.signInWithPassword(
        email: emailController.text.trim(),
        password: passwordController.text,
      );

      if (res.session != null) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showMessage("Login failed. Check your credentials.");
      }
    } on AuthException catch (e) {
      _showMessage(e.message);
    } catch (e) {
      _showMessage("Unexpected error: $e");
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  void _showMessage(String msg) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: FadeTransition(
            opacity: _fadeIn,
            child: SizedBox(
              width: 420,
              child: Column(
                children: [
                  Hero(
                    tag: 'logo-hero',
                    child: Icon(Icons.edit_note,
                        size: 80, color: const Color(0xFF7AE615)),
                  ),
                  const SizedBox(height: 18),
                  const Text('Welcome Back',
                      style: TextStyle(
                          fontSize: 32, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  const Text('Log in to your Task Manager',
                      style: TextStyle(color: Colors.black54)),
                  const SizedBox(height: 28),

                  InputField(
                    label: 'Email',
                    hint: 'Enter your email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  InputField(
                    label: 'Password',
                    hint: 'Enter your password',
                    controller: passwordController,
                    obscure: obscure,
                    toggleVisibility: () {
                      setState(() => obscure = !obscure);
                    },
                  ),
                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => _showMessage(
                          'Forgot password flow not implemented.'),
                      child: Text('Forgot Password?',
                          style: TextStyle(
                              color: primary,
                              fontWeight: FontWeight.w600)),
                    ),
                  ),

                  const SizedBox(height: 6),

                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: loading
                        ? const SizedBox(
                            height: 56,
                            child: Center(
                                child: CircularProgressIndicator()),
                          )
                        : SizedBox(
                            height: 56,
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12)),
                              ),
                              onPressed: _signIn,
                              child: const Text('Login',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                  ),

                  const SizedBox(height: 14),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/signup'),
                        child: Text('Sign Up',
                            style: TextStyle(
                                color: primary,
                                fontWeight: FontWeight.w600)),
                      )
                    ],
                  )
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
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../widgets/input_field.dart';

// final supabase = Supabase.instance.client;

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   bool obscure = true;
//   bool loading = false;

//   late final AnimationController _animController;
//   late final Animation<double> _fadeIn;

//   @override
//   void initState() {
//     super.initState();
//     _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 700));
//     _fadeIn = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
//     _animController.forward();
//   }

//   @override
//   void dispose() {
//     _animController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }

//   Future<void> _signIn() async {
//     setState(() => loading = true);
//     try {
//       final res = await supabase.auth.signInWithPassword(
//         email: emailController.text.trim(),
//         password: passwordController.text,
//       );

//       if (res.session != null) {
//         final session = Supabase.instance.client.auth.currentSession;
//       Navigator.pushReplacementNamed(context, '/dashboard');

//       } else {
//         final err = res;
//         _showMessage('Login failed. Check credentials.');
//       }
//     } on AuthException catch (e) {
//       _showMessage(e.message);
//     } catch (e) {
//       _showMessage('Unexpected error: $e');
//     } finally {
//       if (mounted) setState(() => loading = false);
//     }
//   }

//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     final primary = Theme.of(context).colorScheme.primary;
//     return Scaffold(
//       body: Center(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(24),
//           child: FadeTransition(
//             opacity: _fadeIn,
//             child: SizedBox(
//               width: 420,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Hero(
//                     tag: 'logo-hero',
//                     child: Icon(Icons.edit_note, size: 80, color: const Color(0xFFB3E283)),
//                   ),
//                   const SizedBox(height: 18),
//                   const Text('Welcome Back',
//                       style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 6),
//                   const Text('Log in to your Task Manager', style: TextStyle(color: Colors.black54)),
//                   const SizedBox(height: 28),

//                   InputField(
//                     label: 'Email',
//                     hint: 'Enter your email',
//                     controller: emailController,
//                     keyboardType: TextInputType.emailAddress,
//                   ),
//                   const SizedBox(height: 16),
//                   InputField(
//                     label: 'Password',
//                     hint: 'Enter your password',
//                     controller: passwordController,
//                     obscure: obscure,
//                     toggleVisibility: () {
//                       setState(() => obscure = !obscure);
//                     },
//                   ),
//                   const SizedBox(height: 10),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () => _showMessage('Forgot password flow not implemented.'),
//                       child: Text(
//                         'Forgot Password?',
//                         style: TextStyle(color: primary, fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 6),

//                   // Animated login button
//                   AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 300),
//                     child: loading
//                         ? const SizedBox(
//                             height: 56,
//                             child: Center(child: CircularProgressIndicator()),
//                           )
//                         : SizedBox(
//                             height: 56,
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: primary,
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                               ),
//                               onPressed: _signIn,
//                               child: const Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//                             ),
//                           ),
//                   ),

//                   const SizedBox(height: 14),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Don't have an account? "),
//                       GestureDetector(
//                         onTap: () => Navigator.pushNamed(context, '/signup'),
//                         child: Text('Sign Up', style: TextStyle(color: primary, fontWeight: FontWeight.w600)),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import '../widgets/input_field.dart';
// import 'signup_page.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
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
//                 const Icon(Icons.edit_note,
//                     size: 70, color: Color(0xFFB3E283)),
//                 const SizedBox(height: 24),

//                 const Text(
//                   "Welcome Back",
//                   style: TextStyle(
//                       fontSize: 32, fontWeight: FontWeight.bold),
//                 ),

//                 const SizedBox(height: 8),
//                 const Text(
//                   "Log in to Clover Task Manager",
//                   style: TextStyle(fontSize: 16, color: Colors.black54),
//                 ),

//                 const SizedBox(height: 32),

//                 // Email
//                 InputField(
//                   label: "Email",
//                   hint: "Enter your email",
//                   controller: emailController,
//                 ),

//                 const SizedBox(height: 20),

//                 // Password
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

//                 const SizedBox(height: 12),
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: Text(
//                     "Forgot Password?",
//                     style: TextStyle(
//                       color: Theme.of(context).colorScheme.primary,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),

//                 const SizedBox(height: 24),

//                 // Login button
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
//                       "Login",
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
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const SignupPage()),
//                     );
//                   },
//                   child: Text(
//                     "Don't have an account? Sign Up",
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



// import 'package:flutter/material.dart';

// void main() {
//   runApp(const CloverApp());
// }

// class CloverApp extends StatelessWidget {
//   const CloverApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Clover To-Do',
//       theme: ThemeData(
//         brightness: Brightness.light,
//         scaffoldBackgroundColor: const Color(0xFFF9F9F9),
//         colorScheme: const ColorScheme.light(
//           primary: Color(0xFFA0D2EB),
//           secondary: Color(0xFFB3E283),
//           surface: Colors.white,
//           onSurface: Color(0xFF333333),
//         ),
//         fontFamily: "Inter",
//         useMaterial3: true,
//       ),
//       home: const LoginPage(),
//     );
//   }
// }
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   bool obscure = true; // password visibility

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               "Welcome Back ",
//               style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 10),
//             const Text(
//               "Login to continue",
//               style: TextStyle(fontSize: 16, color: Colors.black54),
//             ),
//             const SizedBox(height: 40),

//             // Email input
//             TextField(
//               controller: emailController,
//               decoration: const InputDecoration(
//                 labelText: "Email",
//                 border: OutlineInputBorder(),
//               ),
//             ),

//             const SizedBox(height: 20),

//             // Password field with eye icon
//             TextField(
//               controller: passwordController,
//               obscureText: obscure,
//               decoration: InputDecoration(
//                 labelText: "Password",
//                 border: const OutlineInputBorder(),
//                 suffixIcon: IconButton(
//                   icon: Icon(
//                     obscure ? Icons.visibility_off : Icons.visibility,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       obscure = !obscure;
//                     });
//                   },
//                 ),
//               ),
//             ),

//             const SizedBox(height: 30),

//             // Login button
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   padding: const EdgeInsets.symmetric(vertical: 16),
//                 ),
//                 onPressed: () {},
//                 child: const Text("Login"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
