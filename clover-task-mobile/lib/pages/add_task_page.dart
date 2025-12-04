import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../constants.dart';

class AddTaskPage extends StatefulWidget {
  final Map<String, dynamic>? task;
  const AddTaskPage({super.key, this.task});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final titleCtrl = TextEditingController();
  final descCtrl = TextEditingController();
  String priority = 'low';
  bool is_completed = false;
  bool loading = false;
  int currentIndex = 1; 

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      titleCtrl.text = widget.task!['title'] ?? '';
      descCtrl.text = widget.task!['description'] ?? '';
      priority = widget.task!['priority'] ?? 'low';
      is_completed = widget.task!['is_completed'] == true;
    }
  }

  Future<void> _save() async {
    if (titleCtrl.text.trim().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Title required')));
      return;
    }

    setState(() => loading = true);
    final body = {
      'title': titleCtrl.text.trim(),
      'description': descCtrl.text.trim(),
      'priority': priority,
      'is_completed': is_completed,
    };

    try {
      final resp = widget.task != null
          ? await ApiService.updateTask(widget.task!['id'].toString(), body)
          : await ApiService.createTask(body);

      if (resp.statusCode == 200 || resp.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.task != null
                ? 'Task updated successfully'
                : 'Task created successfully'),
            backgroundColor: kPrimaryGreen,
          ),
        );
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${resp.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  void _onNavTap(int idx) {
    if (idx == currentIndex) return;
    switch (idx) {
      case 0:
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1:
        // Already on Add Task
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
    setState(() => currentIndex = idx);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.task != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Task' : 'New Task'),
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context)),
        actions: [
          TextButton(
              onPressed: _save,
              child: Text(
                isEdit ? 'Save' : 'Create',
                style: const TextStyle(color: kPrimaryGreen, fontSize: 16),
              ))
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  TextField(
                    controller: titleCtrl,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'Enter task title',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descCtrl,
                    minLines: 3,
                    maxLines: 6,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: 'Add a description...',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: priority,
                    items: const [
                      DropdownMenuItem(value: 'low', child: Text('Low')),
                      DropdownMenuItem(value: 'medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'high', child: Text('High')),
                    ],
                    onChanged: (v) => setState(() => priority = v ?? 'low'),
                    decoration: InputDecoration(
                        labelText: 'Priority',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12))),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Mark as Completed'),
                    value: is_completed,
                    onChanged: (v) => setState(() => is_completed = v),
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
}


// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../services/api_service.dart';
// import '../constants.dart';

// class AddTaskPage extends StatefulWidget {
//   final Map<String, dynamic>? task;
//   const AddTaskPage({super.key, this.task});

//   @override
//   State<AddTaskPage> createState() => _AddTaskPageState();
// }

// class _AddTaskPageState extends State<AddTaskPage> {
//   final titleCtrl = TextEditingController();
//   final descCtrl = TextEditingController();

//   String priority = 'low';
//   bool is_completed= false;
//   bool loading = false;

//   @override
//   void initState() {
//     super.initState();

//     if (widget.task != null) {
//       titleCtrl.text = widget.task!['title'] ?? '';
//       descCtrl.text = widget.task!['description'] ?? '';
//       priority = widget.task!['priority'] ?? 'low';
//     is_completed = widget.task!['is_completed'] == true;
//     }
//   }

//   Future<void> _save() async {
//     if (titleCtrl.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Title required')),
//       );
//       return;
//     }

//     setState(() => loading = true);

//     final body = {
//       'title': titleCtrl.text.trim(),
//       'description': descCtrl.text.trim(),
//       'priority': priority,
//       'is_completed': is_completed,
//     };

//     try {
//       http.Response resp;

//       if (widget.task != null) {
//         resp = await ApiService.updateTask(
//           widget.task!['id'].toString(),
//           body,
//         );
//       } else {
//         resp = await ApiService.createTask(body);
//       }

//       if (resp.statusCode == 200 || resp.statusCode == 201) {
//         Navigator.pop(context, true);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${resp.statusCode}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     } finally {
//       if (mounted) setState(() => loading = false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isEdit = widget.task != null;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isEdit ? 'Edit Task' : 'New Task'),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back),
//           onPressed: () => Navigator.pop(context),
//         ),
//         actions: [
//           TextButton(
//             onPressed: _save,
//             child: Text(
//               isEdit ? 'Save' : 'Create',
//               style: TextStyle(color: kPrimaryGreen),
//             ),
//           ),
//         ],
//       ),

//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView(
//           children: [
//             TextField(
//               controller: titleCtrl,
//               decoration: const InputDecoration(
//                   labelText: 'Title', hintText: 'Enter task title'),
//             ),
//             const SizedBox(height: 12),

//             TextField(
//               controller: descCtrl,
//               minLines: 3,
//               maxLines: 6,
//               decoration: const InputDecoration(
//                 labelText: 'Description',
//                 hintText: 'Add a description...',
//               ),
//             ),
//             const SizedBox(height: 12),

//             DropdownButtonFormField<String>(
//               value: priority,
//               items: const [
//                 DropdownMenuItem(value: 'low', child: Text('Low')),
//                 DropdownMenuItem(value: 'medium', child: Text('Medium')),
//                 DropdownMenuItem(value: 'high', child: Text('High')),
//               ],
//               onChanged: (v) => setState(() => priority = v ?? 'low'),
//               decoration: const InputDecoration(labelText: 'Priority'),
//             ),
//             const SizedBox(height: 12),

//             SwitchListTile(
//               title: const Text('Mark as Completed'),
//               value: is_completed,
//               onChanged: (v) => setState(() => is_completed = v),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../services/api_service.dart';
// import '../constants.dart';

// class AddTaskPage extends StatefulWidget {
//   final Map<String, dynamic>? task; // if provided => edit
//   const AddTaskPage({super.key, this.task});

//   @override
//   State<AddTaskPage> createState() => _AddTaskPageState();
// }

// class _AddTaskPageState extends State<AddTaskPage> {
//   final titleCtrl = TextEditingController();
//   final descCtrl = TextEditingController();
//   String priority = 'low';
//   bool completed = false;
//   bool loading = false;

//   @override
//   void initState() {
//     super.initState();
//     if (widget.task != null) {
//       // prefill the controllers with existing values as placeholder (user can edit)
//       titleCtrl.text = widget.task!['title'] ?? '';
//       descCtrl.text = widget.task!['description'] ?? '';
//       priority = widget.task!['priority'] ?? 'low';
//       completed = widget.task!['completed'] == true;
//     }
//   }

//   Future<void> _save() async {
//     if (titleCtrl.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Title required')));
//       return;
//     }
//     setState(() => loading = true);
//     final body = {
//       'title': titleCtrl.text.trim(),
//       'description': descCtrl.text.trim(),
//       'priority': priority,
//       'completed': completed,
//     };

//     try {
//       http.Response resp;
//       if (widget.task != null) {
//         resp = await ApiService.updateTask(widget.task!['id'].toString(), body);
//       } else {
//         resp = await ApiService.createTask(body);
//       }
//       if (resp.statusCode == 200 || resp.statusCode == 201) {
//         Navigator.pop(context, true);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${resp.statusCode}')));
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
//     } finally {
//       if (mounted) setState(() => loading = false);
//     }
//   }

//   @override
//   void dispose() {
//     titleCtrl.dispose();
//     descCtrl.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isEdit = widget.task != null;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isEdit ? 'Edit Task' : 'New Task'),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         actions: [
//           TextButton(onPressed: _save, child: Text(isEdit ? 'Save' : 'Create', style: TextStyle(color: kPrimaryGreen))),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ListView(children: [
//           TextField(controller: titleCtrl, decoration: InputDecoration(labelText: 'Title', hintText: 'Enter task title')),
//           const SizedBox(height: 12),
//           TextField(
//             controller: descCtrl,
//             minLines: 3,
//             maxLines: 6,
//             decoration: InputDecoration(labelText: 'Description', hintText: 'Add a description...'),
//           ),
//           const SizedBox(height: 12),
//           DropdownButtonFormField<String>(
//             value: priority,
//             items: const [
//               DropdownMenuItem(value: 'low', child: Text('Low')),
//               DropdownMenuItem(value: 'medium', child: Text('Medium')),
//               DropdownMenuItem(value: 'high', child: Text('High')),
//             ],
//             onChanged: (v) => setState(() => priority = v ?? 'low'),
//             decoration: const InputDecoration(labelText: 'Priority'),
//           ),
//           const SizedBox(height: 12),
//           SwitchListTile(
//             title: const Text('Mark as Completed'),
//             value: completed,
//             onChanged: (v) => setState(() => completed = v),
//           ),
//         ]),
//       ),
//     );
//   }
// }


// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import '../widgets/input_field.dart';

// final supabase = Supabase.instance.client;

// class AddTaskPage extends StatefulWidget {
//   const AddTaskPage({super.key});

//   @override
//   State<AddTaskPage> createState() => _AddTaskPageState();
// }

// class _AddTaskPageState extends State<AddTaskPage> {
//   final titleController = TextEditingController();
//   final descController = TextEditingController();
//   String priority = 'low';
//   bool loading = false;

//   Future<void> _createTask() async {
//     if (titleController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Title required')));
//       return;
//     }
//     setState(() => loading = true);
//     try {
//       await supabase.from('tasks').insert({
//         'title': titleController.text.trim(),
//         'description': descController.text.trim(),
//         'priority': priority,
//         'created_at': DateTime.now().toIso8601String(),
//       });
//       if (mounted) Navigator.pop(context, true);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error creating task: $e')));
//     } finally {
//       if (mounted) setState(() => loading = false);
//     }
//   }

//   @override
//   void dispose() {
//     titleController.dispose();
//     descController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final primary = Theme.of(context).colorScheme.primary;
//     return Scaffold(
//       appBar: AppBar(title: const Text('Add Task'), backgroundColor: primary),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(children: [
//           InputField(label: 'Title', hint: 'Task title', controller: titleController),
//           const SizedBox(height: 12),
//           InputField(label: 'Description', hint: 'Short description', controller: descController),
//           const SizedBox(height: 12),
//           Row(children: [
//             const Text('Priority: ', style: TextStyle(fontWeight: FontWeight.w600)),
//             const SizedBox(width: 12),
//             DropdownButton<String>(
//               value: priority,
//               items: const [
//                 DropdownMenuItem(value: 'low', child: Text('Low')),
//                 DropdownMenuItem(value: 'medium', child: Text('Medium')),
//                 DropdownMenuItem(value: 'high', child: Text('High')),
//               ],
//               onChanged: (v) => setState(() => priority = v ?? 'low'),
//             )
//           ]),
//           const SizedBox(height: 16),
//           SizedBox(
//             width: double.infinity,
//             height: 48,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(backgroundColor: primary),
//               onPressed: loading ? null : _createTask,
//               child: loading ? const CircularProgressIndicator() : const Text('Add Task'),
//             ),
//           )
//         ]),
//       ),
//     );
//   }
// }
