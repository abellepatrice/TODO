import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/theme_service.dart';
import 'package:provider/provider.dart' as app_provider;

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeService = app_provider.Provider.of<ThemeService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),

      body: ListView(
        children: [

          // Theme Switch (Dark / Light Mode)
          // SwitchListTile(
          //   title: const Text("Dark Mode"),
          //   value: themeService.isDarkMode,
          //   onChanged: (value) {
          //     themeService.toggleTheme();
          //   },
          //   secondary: const Icon(Icons.dark_mode),
          // ),

          const Divider(),

          // Profile Section
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.pushNamed(context, "/profile");
            },
          ),

          const Divider(),

          // About
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text("About"),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              showAboutDialog(
                context: context,
                applicationName: "Clover To-Do",
                applicationVersion: "1.0.0",
                applicationLegalese: "Developed by Patrice Oyende",
              );
            },
          ),

          const Divider(),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text("Logout", style: TextStyle(color: Colors.red)),
            onTap: () async {
              await Supabase.instance.client.auth.signOut();
              if (context.mounted) {
                Navigator.pushNamedAndRemoveUntil(context, "/", (_) => false);
              }
            },
          ),
        ],
      ),
    );
  }
}
