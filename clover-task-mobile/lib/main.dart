import 'package:clover_todo/pages/about_help_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'package:provider/provider.dart' as app_provider;

import 'pages/add_task_page.dart';
// import 'pages/dashboard_page.dart';
import 'pages/home_page.dart';
import 'pages/profile_page.dart';
import 'pages/settings_page.dart';
import 'pages/signup_page.dart';
import 'services/theme_service.dart';
import 'pages/login_page.dart';


// ignore: constant_identifier_names
const String SUPABASE_URL='https://vuwkfirvrcbxqadnkpop.supabase.co';
// ignore: constant_identifier_names
const String SUPABASE_ANNON_KEY='eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InZ1d2tmaXJ2cmNieHFhZG5rcG9wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk0MzAzMTYsImV4cCI6MjA3NTAwNjMxNn0.RhpxtSL05XFdwETU85k1IPbWpmPy49H2R1gHkearXjI';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: SUPABASE_URL, anonKey: SUPABASE_ANNON_KEY);
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeService(),
      child: const CloverApp(),
    ),
  );
}

class CloverApp extends StatelessWidget {
  const CloverApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = app_provider.Provider.of<ThemeService>(context);
    return MaterialApp(
      title: 'Clover To-Do',
      debugShowCheckedModeBanner: false,
      theme: themeService.theme,
      initialRoute: '/',
      routes: {
        '/': (_) => const LoginPage(),
        '/signup': (_) => const SignupPage(),
    // '/home': (_) => const DashboardPage(),
    '/home': (_) => const HomePage(),
    '/profile': (_) => const ProfilePage(),
    '/settings': (_) => const SettingsPage(),
    '/add': (_) => const AddTaskPage(),
    '/about_help': (_) => const AboutHelpPage(),

      },
    );
  }
}


// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'constants.dart';
// import 'pages/login_page.dart';
// import 'pages/home_page.dart';
// import 'pages/signup_page.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Supabase.initialize(
//     url: SUPABASE_URL,
//     anonKey: SUPABASE_ANNON_KEY,
//     // Optionally add auth callback host if you use OAuth redirect flows:
//     // authCallbackUrlHostname: 'login-callback',
//   );

//   runApp(const CloverApp());
// }

// class CloverApp extends StatelessWidget {
//   const CloverApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Clover To-Do',
//       debugShowCheckedModeBanner: false,
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
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const LoginPage(),
//         '/signup': (context) => const SignupPage(),
//         '/home': (context) => const HomePage(),
//       },
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'login_page.dart';

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
