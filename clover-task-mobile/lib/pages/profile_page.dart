import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../constants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  final supabase = Supabase.instance.client;
  int currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    _user = supabase.auth.currentUser;
    setState(() {});
  }

  void _comingSoon() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Coming Soon"),
        content: const Text("This feature is under development."),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK")),
        ],
      ),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await supabase.auth.signOut();
              if (mounted) Navigator.pushReplacementNamed(context, '/home');
            },
            child: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _onNavTap(int idx) {
    if (idx == currentIndex) return;
    switch (idx) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/add');
        break;
      case 2:
        // Already profile
        break;
    }
    setState(() => currentIndex = idx);
  }

  @override
  Widget build(BuildContext context) {
    final email = _user?.email ?? 'Unknown';
    final metadata = _user?.userMetadata ?? {};
    final name = metadata['full_name'] ?? metadata['username'] ?? 'User';
    final avatarLetter = (name.isNotEmpty ? name[0] : 'U').toUpperCase();

    return Scaffold(
      backgroundColor: const Color(0xfff7f8f6),
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.4,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[300],
                  child: Text(
                    avatarLetter,
                    style: const TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xff79e515),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: const Icon(Icons.edit, color: Colors.white, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(email, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 24),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: Column(
                children: [
                  _buildMenuItem(Icons.person, "Edit Profile", _comingSoon),
                  _divider(),
                  _buildMenuItem(Icons.lock, "Change Password", _comingSoon),
                  _divider(),
                  _buildMenuItem(Icons.notifications, "Notifications", _comingSoon),
                  _divider(),
                  _buildMenuItem(Icons.help_outline, "About & Help", _comingSoon),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _confirmLogout,
              icon: const Icon(Icons.logout),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade100,
                foregroundColor: Colors.red.shade600,
                minimumSize: const Size(double.infinity, 52),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.grid_view,
                  color: currentIndex == 0 ? kPrimaryGreen : Colors.grey),
              onPressed: () => _onNavTap(0),
            ),
            IconButton(
              icon: Icon(Icons.add_circle_outline,
                  color: currentIndex == 1 ? kPrimaryGreen : Colors.grey),
              onPressed: () => _onNavTap(1),
            ),
            IconButton(
              icon: Icon(Icons.person_outline,
                  color: currentIndex == 2 ? kPrimaryGreen : Colors.grey),
              onPressed: () => _onNavTap(2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Row(
          children: [
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                color: const Color(0xff79e515).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: const Color(0xff79e515)),
            ),
            const SizedBox(width: 16),
            Expanded(child: Text(label, style: const TextStyle(fontSize: 16))),
            Icon(Icons.chevron_right, color: Colors.grey.shade500),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(color: Colors.grey.shade300, height: 1);
  }
}


// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});

//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   User? _user;
//   final supabase = Supabase.instance.client;
//   int currentIndex = 2; // Profile page index in bottom nav

//   @override
//   void initState() {
//     super.initState();
//     _loadUser();
//   }

//   void _loadUser() {
//     _user = supabase.auth.currentUser;
//     setState(() {});
//   }

//   // ------------------ DIALOGS ------------------
//   void _comingSoon() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Coming Soon"),
//         content: const Text("This feature is under development."),
//         actions: [
//           TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("OK")),
//         ],
//       ),
//     );
//   }

//   void _confirmLogout() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: const Text("Confirm Logout"),
//         content: const Text("Are you sure you want to log out?"),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("Cancel"),
//           ),
//           TextButton(
//             onPressed: () async {
//               Navigator.pop(context);
//               await supabase.auth.signOut();
//               if (mounted) Navigator.pushReplacementNamed(context, '/');
//             },
//             child: const Text(
//               "Logout",
//               style: TextStyle(color: Colors.red),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ------------------ NAVIGATION ------------------
//   void _onNavTap(int idx) {
//     if (idx == currentIndex) return;
//     if (idx == 0) {
//       Navigator.pushReplacementNamed(context, '/home');
//     } else if (idx == 1) {
//       _comingSoon();
//     } else if (idx == 2) {
//       // Already on profile
//     }
//     setState(() => currentIndex = idx);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final email = _user?.email ?? 'Unknown';
//     final metadata = _user?.userMetadata ?? {};
//     final name = metadata['full_name'] ?? metadata['username'] ?? 'User';
//     final avatarLetter = (name.isNotEmpty ? name[0] : 'U').toUpperCase();

//     return Scaffold(
//       backgroundColor: const Color(0xfff7f8f6),
//       appBar: AppBar(
//         title: const Text(
//           "Profile",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         elevation: 0.4,
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             const SizedBox(height: 20),
//             Stack(
//               alignment: Alignment.bottomRight,
//               children: [
//                 CircleAvatar(
//                   radius: 60,
//                   backgroundColor: Colors.grey[300],
//                   child: Text(
//                     avatarLetter,
//                     style: const TextStyle(
//                         fontSize: 45,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black),
//                   ),
//                 ),
//                 Container(
//                   height: 36,
//                   width: 36,
//                   decoration: BoxDecoration(
//                     color: const Color(0xff79e515),
//                     borderRadius: BorderRadius.circular(50),
//                     border: Border.all(color: Colors.white, width: 2),
//                   ),
//                   child: const Icon(Icons.edit, color: Colors.white, size: 20),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 14),
//             Text(
//               name,
//               style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               email,
//               style: const TextStyle(color: Colors.grey),
//             ),
//             const SizedBox(height: 24),

//             // ---------- MAIN CARD ----------
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 6,
//                     offset: const Offset(0, 3),
//                   )
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   _buildMenuItem(
//                       icon: Icons.person,
//                       label: "Edit Profile",
//                       onTap: _comingSoon),
//                   _divider(),
//                   _buildMenuItem(
//                       icon: Icons.lock,
//                       label: "Change Password",
//                       onTap: _comingSoon),
//                   _divider(),
//                   _buildMenuItem(
//                       icon: Icons.notifications,
//                       label: "Notifications",
//                       onTap: _comingSoon),
//                   _divider(),
//                   _buildMenuItem(
//                       icon: Icons.help_outline,
//                       label: "About & Help",
//                       onTap: _comingSoon),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 32),

//             ElevatedButton.icon(
//               onPressed: _confirmLogout,
//               icon: const Icon(Icons.logout),
//               label: const Text("Logout"),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.red.shade100,
//                 foregroundColor: Colors.red.shade600,
//                 minimumSize: const Size(double.infinity, 52),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(14),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),

//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               icon: Icon(Icons.grid_view,
//                   color: currentIndex == 0 ? const Color(0xff79e515) : Colors.grey),
//               onPressed: () => _onNavTap(0),
//             ),
//             IconButton(
//               icon: Icon(Icons.add_circle_outline,
//                   color: currentIndex == 1 ? const Color(0xff79e515) : Colors.grey),
//               onPressed: () => _onNavTap(1),
//             ),
//             IconButton(
//               icon: Icon(Icons.person_outline,
//                   color: currentIndex == 2 ? const Color(0xff79e515) : Colors.grey),
//               onPressed: () => _onNavTap(2),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildMenuItem(
//       {required IconData icon,
//       required String label,
//       required VoidCallback onTap}) {
//     return InkWell(
//       onTap: onTap,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
//         child: Row(
//           children: [
//             Container(
//               height: 42,
//               width: 42,
//               decoration: BoxDecoration(
//                 color: const Color(0xff79e515).withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(icon, color: const Color(0xff79e515)),
//             ),
//             const SizedBox(width: 16),
//             Expanded(
//               child: Text(
//                 label,
//                 style: const TextStyle(fontSize: 16, color: Colors.black),
//               ),
//             ),
//             Icon(Icons.chevron_right, color: Colors.grey.shade500),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _divider() {
//     return Divider(color: Colors.grey.shade300, height: 1);
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class ProfilePage extends StatefulWidget {
//   const ProfilePage({super.key});
//   @override
//   State<ProfilePage> createState() => _ProfilePageState();
// }

// class _ProfilePageState extends State<ProfilePage> {
//   User? _user;
//   final supabase = Supabase.instance.client;

//   @override
//   void initState() {
//     super.initState();
//     _loadUser();
//   }

//   void _loadUser() {
//     final u = supabase.auth.currentUser;
//     setState(() {
//       _user = u;
//     });
//   }

//   Future<void> _logout() async {
//     await supabase.auth.signOut();
//     if (mounted) Navigator.pushReplacementNamed(context, '/');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final email = _user?.email ?? 'Unknown';

//     // SAFE metadata access
//     final metadata = _user?.userMetadata ?? {};

//     final name = metadata['full_name'] ??
//         metadata['username'] ??
//         'User';

//     // safe initial for avatar
//     final avatarLetter = (name.isNotEmpty ? name[0] : 'U').toUpperCase();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Profile'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             CircleAvatar(
//               radius: 42,
//               backgroundColor: Colors.grey[300],
//               child: Text(
//                 avatarLetter,
//                 style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
//               ),
//             ),
//             const SizedBox(height: 12),
//             Text(
//               name,
//               style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 6),
//             Text(email),
//             const SizedBox(height: 24),
//             ElevatedButton(
//               onPressed: _logout,
//               child: const Text('Logout'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
