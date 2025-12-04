import 'package:flutter/material.dart';
import 'widgets/input_field.dart';
import 'pages/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SizedBox(
            width: 400,
            child: Column(
              children: [
                const Icon(Icons.health_and_safety,
                    size: 70, color: Color(0xFFB3E283)),
                const SizedBox(height: 24),

                const Text(
                  "Welcome Back",
                  style: TextStyle(
                      fontSize: 32, fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 8),
                const Text(
                  "Log in to Clover Task Manager",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),

                const SizedBox(height: 32),

                // Email
                InputField(
                  label: "Email",
                  hint: "Enter your email",
                  controller: emailController,
                ),

                const SizedBox(height: 20),

                // Password
                InputField(
                  label: "Password",
                  hint: "Enter your password",
                  controller: passwordController,
                  obscure: obscure,
                  toggleVisibility: () {
                    setState(() {
                      obscure = !obscure;
                    });
                  },
                ),

                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Login button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupPage()),
                    );
                  },
                  child: Text(
                    "Don't have an account? Sign Up",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}



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
