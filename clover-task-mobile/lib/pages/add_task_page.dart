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

  static const Color primary = Color(0xFF7AE615);

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
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          isEdit ? 'Edit Task' : 'New Task',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: primary,
        elevation: 3,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: titleCtrl,
                          decoration: InputDecoration(
                            labelText: 'Title',
                            hintText: 'Enter task title',
                            floatingLabelStyle:
                                const TextStyle(color: primary),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: primary, width: 2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
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
                            floatingLabelStyle:
                                const TextStyle(color: primary),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: primary, width: 2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        DropdownButtonFormField<String>(
                          value: priority,
                          items: const [
                            DropdownMenuItem(
                                value: 'low', child: Text('Low')),
                            DropdownMenuItem(
                                value: 'medium', child: Text('Medium')),
                            DropdownMenuItem(
                                value: 'high', child: Text('High')),
                          ],
                          onChanged: (v) =>
                              setState(() => priority = v ?? 'low'),
                          decoration: InputDecoration(
                            labelText: 'Priority',
                            floatingLabelStyle:
                                const TextStyle(color: primary),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: primary, width: 2),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        SwitchListTile(
                          title: const Text('Mark as Completed'),
                          activeColor: primary,
                          value: is_completed,
                          onChanged: (v) =>
                              setState(() => is_completed = v),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Create/Save button BELOW the form
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _save,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: Text(
                        isEdit ? 'Save Task' : 'Create Task',
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(
                Icons.grid_view,
                color: currentIndex == 0 ? kPrimaryGreen : Colors.grey,
              ),
              onPressed: () => _onNavTap(0),
            ),
            IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: currentIndex == 1 ? kPrimaryGreen : Colors.grey,
              ),
              onPressed: () => _onNavTap(1),
            ),
            IconButton(
              icon: Icon(
                Icons.person_outline,
                color: currentIndex == 2 ? kPrimaryGreen : Colors.grey,
              ),
              onPressed: () => _onNavTap(2),
            ),
          ],
        ),
      ),
    );
  }
}


// import 'package:flutter/material.dart';
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
//   bool is_completed = false;
//   bool loading = false;
//   int currentIndex = 1; 

//   @override
//   void initState() {
//     super.initState();
//     if (widget.task != null) {
//       titleCtrl.text = widget.task!['title'] ?? '';
//       descCtrl.text = widget.task!['description'] ?? '';
//       priority = widget.task!['priority'] ?? 'low';
//       is_completed = widget.task!['is_completed'] == true;
//     }
//   }

//   Future<void> _save() async {
//     if (titleCtrl.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Title required')));
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
//       final resp = widget.task != null
//           ? await ApiService.updateTask(widget.task!['id'].toString(), body)
//           : await ApiService.createTask(body);

//       if (resp.statusCode == 200 || resp.statusCode == 201) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text(widget.task != null
//                 ? 'Task updated successfully'
//                 : 'Task created successfully'),
//             backgroundColor: kPrimaryGreen,
//           ),
//         );
//         Navigator.pushReplacementNamed(context, '/home');
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${resp.statusCode}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Error: $e')));
//     } finally {
//       if (mounted) setState(() => loading = false);
//     }
//   }

//   void _onNavTap(int idx) {
//     if (idx == currentIndex) return;
//     switch (idx) {
//       case 0:
//         Navigator.pushReplacementNamed(context, '/home');
//         break;
//       case 1:
//         // Already on Add Task
//         break;
//       case 2:
//         Navigator.pushReplacementNamed(context, '/profile');
//         break;
//     }
//     setState(() => currentIndex = idx);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isEdit = widget.task != null;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(isEdit ? 'Edit Task' : 'New Task'),
//         backgroundColor: Colors.white,
//         elevation: 0.5,
//         leading: IconButton(
//             icon: const Icon(Icons.arrow_back, color: Colors.black),
//             onPressed: () => Navigator.pop(context)),
//         actions: [
//           TextButton(
//               onPressed: _save,
//               child: Text(
//                 isEdit ? 'Save' : 'Create',
//                 style: const TextStyle(color: kPrimaryGreen, fontSize: 16),
//               ))
//         ],
//       ),
//       body: loading
//           ? const Center(child: CircularProgressIndicator())
//           : Padding(
//               padding: const EdgeInsets.all(16),
//               child: ListView(
//                 children: [
//                   TextField(
//                     controller: titleCtrl,
//                     decoration: InputDecoration(
//                       labelText: 'Title',
//                       hintText: 'Enter task title',
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12)),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   TextField(
//                     controller: descCtrl,
//                     minLines: 3,
//                     maxLines: 6,
//                     decoration: InputDecoration(
//                       labelText: 'Description',
//                       hintText: 'Add a description...',
//                       border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12)),
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   DropdownButtonFormField<String>(
//                     value: priority,
//                     items: const [
//                       DropdownMenuItem(value: 'low', child: Text('Low')),
//                       DropdownMenuItem(value: 'medium', child: Text('Medium')),
//                       DropdownMenuItem(value: 'high', child: Text('High')),
//                     ],
//                     onChanged: (v) => setState(() => priority = v ?? 'low'),
//                     decoration: InputDecoration(
//                         labelText: 'Priority',
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12))),
//                   ),
//                   const SizedBox(height: 16),
//                   SwitchListTile(
//                     title: const Text('Mark as Completed'),
//                     value: is_completed,
//                     onChanged: (v) => setState(() => is_completed = v),
//                   ),
//                 ],
//               ),
//             ),
//       bottomNavigationBar: BottomAppBar(
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             IconButton(
//               icon: Icon(Icons.grid_view,
//                   color: currentIndex == 0 ? kPrimaryGreen : Colors.grey),
//               onPressed: () => _onNavTap(0),
//             ),
//             IconButton(
//               icon: Icon(Icons.add_circle_outline,
//                   color: currentIndex == 1 ? kPrimaryGreen : Colors.grey),
//               onPressed: () => _onNavTap(1),
//             ),
//             IconButton(
//               icon: Icon(Icons.person_outline,
//                   color: currentIndex == 2 ? kPrimaryGreen : Colors.grey),
//               onPressed: () => _onNavTap(2),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
