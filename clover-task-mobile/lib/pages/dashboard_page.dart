// import 'dart:convert';
// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// import '../widgets/task_card.dart';
// import '../constants.dart';
// import 'add_task_page.dart';
// import 'profile_page.dart';

// class DashboardPage extends StatefulWidget {
//   const DashboardPage({super.key});
//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   List<Map<String, dynamic>> tasks = [];
//   bool loading = true;
//   int currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _loadTasks();
//   }

//   Future<void> _loadTasks() async {
//     setState(() => loading = true);
//     final resp = await ApiService.getTasks();

//     if (resp.statusCode == 200) {
//       final data = jsonDecode(resp.body);
//       setState(() {
//         tasks = List<Map<String, dynamic>>.from(data);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error loading tasks: ${resp.statusCode}')),
//       );
//     }

//     setState(() => loading = false);
//   }

//   void _onNavTap(int idx) {
//     setState(() => currentIndex = idx);

//     if (idx == 0) return;
//     if (idx == 1) {
//       Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTaskPage()));
//     } else if (idx == 2) {
//       Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),

//       body: RefreshIndicator(
//         onRefresh: _loadTasks,
//         child: loading
//             ? const Center(child: CircularProgressIndicator())
//             : ListView.separated(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: tasks.length,
//                 separatorBuilder: (_, __) => const SizedBox(height: 12),
//                 itemBuilder: (context, i) {
//                   final t = tasks[i];

//                   return GestureDetector(
//                     onTap: () async {
//                       final updated = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (_) => AddTaskPage(task: t),
//                         ),
//                       );
//                       if (updated == true) _loadTasks();
//                     },
//                     child: TaskCard(
//                       title: t['title'] ?? '',
//                       description: t['description'] ?? '',
//                       priority: t['priority'] ?? 'low',
//                       is_completed: t['is_complete'] == true,
//                     ),
//                   );
//                 },
//               ),
//       ),

//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final created = await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (_) => const AddTaskPage()),
//           );
//           if (created == true) _loadTasks();
//         },
//         backgroundColor: kPrimaryGreen,
//         child: const Icon(Icons.add, color: Colors.black),
//       ),

//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(icon: Icon(Icons.grid_view, color: kPrimaryGreen), onPressed: () => _onNavTap(0)),
//             IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () => _onNavTap(1)),
//             IconButton(icon: const Icon(Icons.person_outline), onPressed: () => _onNavTap(2)),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import '../services/api_service.dart';
// import '../widgets/task_card.dart';
// import '../constants.dart';
// import 'add_task_page.dart';
// import 'profile_page.dart';

// class DashboardPage extends StatefulWidget {
//   const DashboardPage({super.key});
//   @override
//   State<DashboardPage> createState() => _DashboardPageState();
// }

// class _DashboardPageState extends State<DashboardPage> {
//   List<Map<String, dynamic>> tasks = [];
//   bool loading = true;
//   int currentIndex = 0;

//   @override
//   void initState() {
//     super.initState();
//     _loadTasks();
//   }

//   Future<void> _loadTasks() async {
//     setState(() => loading = true);
//     final resp = await ApiService.getTasks();
//     if (resp.statusCode == 200) {
//       final data = jsonDecode(resp.body);
//       setState(() {
//         tasks = List<Map<String, dynamic>>.from(data);
//       });
//     } else {
//       // handle auth / error
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error loading tasks: ${resp.statusCode}')));
//     }
//     setState(() => loading = false);
//   }

//   // navigate bottom nav
//   void _onNavTap(int idx) {
//     setState(() => currentIndex = idx);
//     if (idx == 0) return; // already dashboard
//     if (idx == 1) {
//       Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTaskPage()));
//     } else if (idx == 2) {
//       Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           // theme toggle (top-right)
//           // (the toggle widget from earlier)
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: _loadTasks,
//         child: loading
//             ? const Center(child: CircularProgressIndicator())
//             : ListView.separated(
//                 padding: const EdgeInsets.all(16),
//                 itemCount: tasks.length,
//                 separatorBuilder: (_, __) => const SizedBox(height: 12),
//                 itemBuilder: (context, i) {
//                   final t = tasks[i];
//                   return GestureDetector(
//                     onTap: () async {
//                       // open edit page with task (prefill)
//                       final updated = await Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (_) => AddTaskPage(task: t)),
//                       );
//                       if (updated == true) _loadTasks();
//                     },
//                     child: TaskCard(
//                       title: t['title'] ?? '',
//                       description: t['description'] ?? '',
//                       priority: t['priority'] ?? 'low',
//                       is_completed: t['completed'] == true,
//                     ),
//                   );
//                 },
//               ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final created = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTaskPage()));
//           if (created == true) _loadTasks();
//         },
//         backgroundColor: kPrimaryGreen,
//         child: const Icon(Icons.add, color: Colors.black),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(icon: Icon(Icons.grid_view, color: kPrimaryGreen), onPressed: () => _onNavTap(0)),
//             IconButton(icon: Icon(Icons.add_circle_outline), onPressed: () => _onNavTap(1)),
//             IconButton(icon: Icon(Icons.person_outline), onPressed: () => _onNavTap(2)),
//           ],
//         ),
//       ),
//     );
//   }
// }
