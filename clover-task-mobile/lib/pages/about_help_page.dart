import 'package:flutter/material.dart';

class AboutHelpPage extends StatelessWidget {
  const AboutHelpPage({super.key});

  final Color themeColor = const Color(0xFF7AE615);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: const Text(
          'About & Help',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // About Section
            Text(
              'About Clover Task Manager',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Clover Task Manager helps you stay organized and productive. '
              'Create tasks, set priorities, mark tasks as completed, and filter them based on importance. '
              'The app provides detailed views for each task to edit or delete easily.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 16),
            Text(
              'Key Features:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '• Create and manage tasks efficiently\n'
              '• Assign priorities: High 🔴, Medium 🟡, Low 🟢\n'
              '• Filter tasks by priority\n'
              '• Mark tasks as completed\n'
              '• Detailed task view with edit/delete options\n'
              '• Responsive and easy-to-use interface',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),

            // Help Section
            Text(
              'Help & Support',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: themeColor,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'How to Use the App:\n\n'
              '1. Add a task using the "Add Task" option in the bottom navigation.\n'
              '2. Fill in title, description, and select a priority level.\n'
              '3. Filter tasks using the priority tabs.\n'
              '4. Tap a task to view details, mark complete, edit, or delete.\n'
              '5. Refresh tasks by pulling down on the dashboard.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 16),
            const Text(
              'Need More Help?\n\n'
              'For any issues or questions, contact support via email: support@clovertaskmanager.com. '
              'Responses are typically within 24 hours.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
