import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'add_task_page.dart';

final supabase = Supabase.instance.client;

class TaskDetailPage extends StatefulWidget {
  final Map<String, dynamic> task;
  const TaskDetailPage({super.key, required this.task});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late TextEditingController titleCtrl;
  late TextEditingController descCtrl;
  String priority = 'low';
  bool isCompleted = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController(text: widget.task['title'] ?? '');
    descCtrl = TextEditingController(text: widget.task['description'] ?? '');
    priority = widget.task['priority'] ?? 'low';
    isCompleted = widget.task['is_completed'] ?? false;
  }

  Color _priorityColor(String p) {
    switch (p.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.yellow;
      case 'low':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  Future<void> _updateTask() async {
    setState(() => loading = true);
    try {
      final resp = await supabase
          .from('tasks')
          .update({
            'title': titleCtrl.text.trim(),
            'description': descCtrl.text.trim(),
            'priority': priority,
            'is_completed': isCompleted
          })
          .eq('id', widget.task['id']);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task updated successfully!')),
      );
      Navigator.pop(context, true);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error updating task: $e')));
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> _deleteTask() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Delete')),
        ],
      ),
    );
    if (confirmed == true) {
      setState(() => loading = true);
      try {
        await supabase.from('tasks').delete().eq('id', widget.task['id']);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task deleted successfully!')),
        );
        Navigator.pop(context, true);
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error deleting task: $e')));
      } finally {
        if (mounted) setState(() => loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        backgroundColor: Colors.blue,
        actions: [
          TextButton(
            onPressed: _updateTask,
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  TextField(
                    controller: titleCtrl,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Task Title',
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  TextField(
                    controller: descCtrl,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Add description...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Priority Selector
                  const Text('Priority', style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: ['low', 'medium', 'high'].map((p) {
                      final color = _priorityColor(p);
                      final isSelected = priority.toLowerCase() == p;
                      return GestureDetector(
                        onTap: () => setState(() => priority = p),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                          decoration: BoxDecoration(
                            color: isSelected ? color : Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            p[0].toUpperCase() + p.substring(1),
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.black87,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),

                  // Completed Switch
                  SwitchListTile(
                    title: const Text('Mark as Completed'),
                    value: isCompleted,
                    onChanged: (v) => setState(() => isCompleted = v),
                  ),
                  const SizedBox(height: 32),

                  // Delete Button
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400,
                        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 48),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      onPressed: _deleteTask,
                      child: const Text('Delete Task', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
