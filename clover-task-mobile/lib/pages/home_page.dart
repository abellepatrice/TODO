import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/task_card.dart';
import 'add_task_page.dart';
import 'profile_page.dart';
import 'task_detail_page.dart';

final supabase = Supabase.instance.client;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> tasks = [];
  bool loading = true;
  String selectedPriority = 'All';
  int currentIndex = 0;
  String username = 'Abelle'; // Replace with actual username if available
  final Color themeColor = const Color(0xFF7AE615);

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    setState(() => loading = true);
    try {
      final resp = await supabase
          .from('tasks')
          .select()
          .order('created_at', ascending: false);
      if (resp is List) {
        setState(() {
          tasks = List<Map<String, dynamic>>.from(resp);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error loading tasks: $e')));
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Color _priorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  void _onNavTap(int idx) async {
    setState(() => currentIndex = idx);
    if (idx == 1) {
      final created = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTaskPage()));
      if (created == true) _loadTasks();
    } else if (idx == 2) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredTasks = selectedPriority == 'All'
        ? tasks
        : tasks.where((t) => (t['priority'] ?? '').toString().toLowerCase() == selectedPriority.toLowerCase()).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text(
          'Welcome back, $username',
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _loadTasks,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Priority Tabs
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['All', 'High', 'Medium', 'Low']
                      .map((p) => GestureDetector(
                            onTap: () => setState(() => selectedPriority = p),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                              decoration: BoxDecoration(
                                color: selectedPriority == p ? themeColor : Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                p,
                                style: TextStyle(
                                  color: selectedPriority == p ? Colors.black87 : Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ))
                      .toList(),
                ),
              ),
              const SizedBox(height: 12),
              // Task List
              Expanded(
                child: loading
                    ? const Center(child: CircularProgressIndicator())
                    : filteredTasks.isEmpty
                        ? ListView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            children: const [
                              SizedBox(height: 120),
                              Center(child: Text('No tasks yet — add one!')),
                            ],
                          )
                        : ListView.separated(
                            itemCount: filteredTasks.length,
                            separatorBuilder: (_, __) => const SizedBox(height: 12),
                            itemBuilder: (context, idx) {
                              final t = filteredTasks[idx];
                              return GestureDetector(
                                onTap: () async {
                                  final updated = await Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => TaskDetailPage(task: t)),
                                  );
                                  if (updated == true) _loadTasks();
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      )
                                    ],
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      // Full-height Priority Indicator
                                      Container(
                                        width: 8,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          color: _priorityColor(t['priority'] ?? ''),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              t['title'] ?? '',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                decoration: t['is_completed'] == true
                                                    ? TextDecoration.lineThrough
                                                    : null,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              t['description'] ?? '',
                                              style: TextStyle(
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      if (t['is_completed'] == true)
                                        const Icon(Icons.check_circle, color: Colors.green),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.dashboard, color: currentIndex == 0 ? themeColor : Colors.grey),
              onPressed: () => _onNavTap(0),
            ),
            IconButton(
              icon: Icon(Icons.add_circle_outline, color: currentIndex == 1 ? themeColor : Colors.grey),
              onPressed: () => _onNavTap(1),
            ),
            IconButton(
              icon: Icon(Icons.person_outline, color: currentIndex == 2 ? themeColor : Colors.grey),
              onPressed: () => _onNavTap(2),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../widgets/task_card.dart';
// import 'add_task_page.dart';
// import 'profile_page.dart';
// import 'task_detail_page.dart';

// final supabase = Supabase.instance.client;

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
//   List<Map<String, dynamic>> tasks = [];
//   bool loading = true;
//   String selectedPriority = 'All';
//   int currentIndex = 0;
//   String username = 'Abelle'; // Replace with actual username if available

//   @override
//   void initState() {
//     super.initState();
//     _loadTasks();
//   }

//   Future<void> _loadTasks() async {
//     setState(() => loading = true);
//     try {
//       final resp = await supabase
//           .from('tasks')
//           .select()
//           .order('created_at', ascending: false);
//       if (resp is List) {
//         setState(() {
//           tasks = List<Map<String, dynamic>>.from(resp);
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Error loading tasks: $e')));
//     } finally {
//       if (mounted) setState(() => loading = false);
//     }
//   }

//   Color _priorityColor(String priority) {
//     switch (priority.toLowerCase()) {
//       case 'high':
//         return Colors.red;
//       case 'medium':
//         return Colors.yellow;
//       case 'low':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }

//   void _onNavTap(int idx) async {
//     setState(() => currentIndex = idx);
//     if (idx == 1) {
//       final created = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTaskPage()));
//       if (created == true) _loadTasks();
//     } else if (idx == 2) {
//       Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final filteredTasks = selectedPriority == 'All'
//         ? tasks
//         : tasks.where((t) => (t['priority'] ?? '').toString().toLowerCase() == selectedPriority.toLowerCase()).toList();

//     final themeColor = Colors.blue; // Theme color for header and FAB

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: themeColor,
//         title: Text(
//           'Welcome back, $username' ,
//           style: const TextStyle(fontWeight: FontWeight.bold),
//         ),
//       ),
//       body: RefreshIndicator(
//         onRefresh: _loadTasks,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               // Priority Tabs
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: ['All', 'High', 'Medium', 'Low']
//                       .map((p) => GestureDetector(
//                             onTap: () => setState(() => selectedPriority = p),
//                             child: AnimatedContainer(
//                               duration: const Duration(milliseconds: 300),
//                               padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
//                               decoration: BoxDecoration(
//                                 color: selectedPriority == p ? themeColor : Colors.grey.shade200,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Text(
//                                 p,
//                                 style: TextStyle(
//                                   color: selectedPriority == p ? Colors.white : Colors.black87,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ))
//                       .toList(),
//                 ),
//               ),
//               const SizedBox(height: 12),
//               // Task List
//               Expanded(
//                 child: loading
//                     ? const Center(child: CircularProgressIndicator())
//                     : filteredTasks.isEmpty
//                         ? ListView(
//                             physics: const AlwaysScrollableScrollPhysics(),
//                             children: const [
//                               SizedBox(height: 120),
//                               Center(child: Text('No tasks yet — add one!')),
//                             ],
//                           )
//                         : ListView.separated(
//                             itemCount: filteredTasks.length,
//                             separatorBuilder: (_, __) => const SizedBox(height: 12),
//                             itemBuilder: (context, idx) {
//                               final t = filteredTasks[idx];
//                               return GestureDetector(
//                                 onTap: () async {
//                                   final updated = await Navigator.push(
//                                     context,
//                                     MaterialPageRoute(builder: (_) => TaskDetailPage(task: t)),
//                                   );
//                                   if (updated == true) _loadTasks();
//                                 },
//                                 child: AnimatedContainer(
//                                   duration: const Duration(milliseconds: 300),
//                                   padding: const EdgeInsets.all(16),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(16),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black12,
//                                         blurRadius: 8,
//                                         offset: const Offset(0, 4),
//                                       )
//                                     ],
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       // Full-height Priority Indicator
//                                       Container(
//                                         width: 8,
//                                         height: 80,
//                                         decoration: BoxDecoration(
//                                           color: _priorityColor(t['priority'] ?? ''),
//                                           borderRadius: BorderRadius.circular(4),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 12),
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               t['title'] ?? '',
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold,
//                                                 decoration: t['is_completed'] == true
//                                                     ? TextDecoration.lineThrough
//                                                     : null,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 6),
//                                             Text(
//                                               t['description'] ?? '',
//                                               style: TextStyle(
//                                                 color: Colors.grey.shade700,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       if (t['is_completed'] == true)
//                                         const Icon(Icons.check_circle, color: Colors.green),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final created = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTaskPage()));
//           if (created == true) _loadTasks();
//         },
//         backgroundColor: themeColor,
//         child: const Icon(Icons.add),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       bottomNavigationBar: BottomAppBar(
//         shape: const CircularNotchedRectangle(),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               icon: Icon(Icons.dashboard, color: currentIndex == 0 ? themeColor : Colors.grey),
//               onPressed: () => _onNavTap(0),
//             ),
//             IconButton(
//               icon: Icon(Icons.add_circle_outline, color: currentIndex == 1 ? themeColor : Colors.grey),
//               onPressed: () => _onNavTap(1),
//             ),
//             IconButton(
//               icon: Icon(Icons.person_outline, color: currentIndex == 2 ? themeColor : Colors.grey),
//               onPressed: () => _onNavTap(2),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../widgets/task_card.dart';
// import 'add_task_page.dart';
// import 'task_detail_page.dart';

// final supabase = Supabase.instance.client;

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
//   List<Map<String, dynamic>> tasks = [];
//   bool loading = true;
//   String selectedPriority = 'All';

//   @override
//   void initState() {
//     super.initState();
//     _loadTasks();
//   }

//   Future<void> _loadTasks() async {
//     setState(() => loading = true);
//     try {
//       final resp = await supabase
//           .from('tasks')
//           .select()
//           .order('created_at', ascending: false);
//       if (resp is List) {
//         setState(() {
//           tasks = List<Map<String, dynamic>>.from(resp);
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Error loading tasks: $e')));
//     } finally {
//       if (mounted) setState(() => loading = false);
//     }
//   }

//   Color _priorityColor(String priority) {
//     switch (priority.toLowerCase()) {
//       case 'high':
//         return Colors.red;
//       case 'medium':
//         return Colors.orange;
//       case 'low':
//         return Colors.green;
//       default:
//         return Colors.grey;
//     }
//   }

//   // Future<void> _logout() async {
//   //   final confirmed = await showDialog<bool>(
//   //     context: context,
//   //     builder: (_) => AlertDialog(
//   //       title: const Text('Logout Confirmation'),
//   //       content: const Text('Are you sure you want to logout?'),
//   //       actions: [
//   //         TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
//   //         TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Logout')),
//   //       ],
//   //     ),
//   //   );
//   //   if (confirmed == true) {
//   //     await supabase.auth.signOut();
//   //     if (mounted) Navigator.pushReplacementNamed(context, '/');
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final filteredTasks = selectedPriority == 'All'
//         ? tasks
//         : tasks.where((t) => t['priority']?.toLowerCase() == selectedPriority.toLowerCase()).toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//         // actions: [
//         //   IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
//         // ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: _loadTasks,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             children: [
//               // Priority Tabs
//               Container(
//                 padding: const EdgeInsets.symmetric(vertical: 8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: ['All', 'High', 'Medium', 'Low']
//                       .map((p) => GestureDetector(
//                             onTap: () => setState(() => selectedPriority = p),
//                             child: Container(
//                               padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
//                               decoration: BoxDecoration(
//                                 color: selectedPriority == p ? Colors.blue : Colors.grey.shade200,
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                               child: Text(
//                                 p,
//                                 style: TextStyle(
//                                   color: selectedPriority == p ? Colors.white : Colors.black87,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ))
//                       .toList(),
//                 ),
//               ),
//               const SizedBox(height: 12),

//               // Task List
//               Expanded(
//                 child: loading
//                     ? const Center(child: CircularProgressIndicator())
//                     : filteredTasks.isEmpty
//                         ? ListView(
//                             physics: const AlwaysScrollableScrollPhysics(),
//                             children: const [
//                               SizedBox(height: 120),
//                               Center(child: Text('No tasks yet — add one!')),
//                             ],
//                           )
//                         : ListView.separated(
//                             itemCount: filteredTasks.length,
//                             separatorBuilder: (_, __) => const SizedBox(height: 12),
//                             itemBuilder: (context, idx) {
//                               final t = filteredTasks[idx];
//                               return GestureDetector(
//                                 onTap: () async {
//                                   final updated = await Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (_) => TaskDetailPage(task: t)),
//                                   );
//                                   if (updated == true) _loadTasks();
//                                 },
//                                 child: AnimatedContainer(
//                                   duration: const Duration(milliseconds: 300),
//                                   padding: const EdgeInsets.all(16),
//                                   decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     borderRadius: BorderRadius.circular(12),
//                                     boxShadow: [
//                                       BoxShadow(
//                                         color: Colors.black12,
//                                         blurRadius: 6,
//                                         offset: const Offset(0, 3),
//                                       )
//                                     ],
//                                   ),
//                                   child: Row(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       // Priority Indicator
//                                       Container(
//                                         width: 8,
//                                         height: 60,
//                                         decoration: BoxDecoration(
//                                           color: _priorityColor(t['priority'] ?? ''),
//                                           borderRadius: BorderRadius.circular(4),
//                                         ),
//                                       ),
//                                       const SizedBox(width: 12),
//                                       // Task Content
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Text(
//                                               t['title'] ?? '',
//                                               style: TextStyle(
//                                                 fontSize: 16,
//                                                 fontWeight: FontWeight.bold,
//                                                 decoration: t['is_completed'] == true
//                                                     ? TextDecoration.lineThrough
//                                                     : null,
//                                               ),
//                                             ),
//                                             const SizedBox(height: 6),
//                                             Text(
//                                               t['description'] ?? '',
//                                               style: TextStyle(
//                                                 color: Colors.grey.shade700,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       if (t['is_completed'] == true)
//                                         const Icon(Icons.check_circle, color: Colors.green),
//                                     ],
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//               ),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final created = await Navigator.push(
//               context, MaterialPageRoute(builder: (_) => const AddTaskPage()));
//           if (created == true) _loadTasks();
//         },
//         backgroundColor: Colors.blue,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../widgets/task_card.dart';
// import 'add_task_page.dart';

// final supabase = Supabase.instance.client;

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<Map<String, dynamic>> tasks = [];
//   bool loading = true;

//   @override
//   void initState() {
//     super.initState();
//     _loadTasks();
//   }

//   Future<void> _loadTasks() async {
//     setState(() => loading = true);
//     try {
//       final resp = await supabase.from('tasks').select().order('created_at', ascending: false);
//       if (resp is List) {
//         setState(() {
//           tasks = List<Map<String, dynamic>>.from(resp);
//         });
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error loading tasks: $e')));
//     } finally {
//       if (mounted) setState(() => loading = false);
//     }
//   }

//   Future<void> _logout() async {
//     await supabase.auth.signOut();
//     if (mounted) Navigator.pushReplacementNamed(context, '/');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final primary = Theme.of(context).colorScheme.primary;
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Dashboard'),
//         backgroundColor: primary,
//         actions: [
//           IconButton(icon: const Icon(Icons.logout), onPressed: _logout),
//         ],
//       ),
//       body: RefreshIndicator(
//         onRefresh: _loadTasks,
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: loading
//               ? const Center(child: CircularProgressIndicator())
//               : tasks.isEmpty
//                   ? ListView(
//                       physics: const AlwaysScrollableScrollPhysics(),
//                       children: const [
//                         SizedBox(height: 120),
//                         Center(child: Text('No tasks yet — add one!')),
//                       ],
//                     )
//                   : ListView.separated(
//                       itemCount: tasks.length,
//                       separatorBuilder: (_, __) => const SizedBox(height: 12),
//                       itemBuilder: (context, idx) {
//                         final t = tasks[idx];
//                         return TaskCard(
//                           title: t['title'] ?? '',
//                           description: t['description'] ?? '',
//                           priority: (t['priority'] ?? 'low').toString(),
//                           is_completed: t['is_completed'] ?? '',
//                         );
//                       },
//                     ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final created = await Navigator.push(context, MaterialPageRoute(builder: (_) => const AddTaskPage()));
//           if (created == true) {
//             _loadTasks();
//           }
//         },
//         backgroundColor: primary,
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
