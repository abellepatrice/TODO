import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String priority; // "High", "Medium", "Low"
  final bool is_completed;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.priority,
    required this.is_completed,
  });

  Color getPriorityColor() {
    switch (priority) {
      case "High":
        return Colors.redAccent;
      case "Medium":
        return Colors.yellow.shade700;
      case "Low":
        return Colors.blueAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Check Icon
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: is_completed ? const Color(0xFF7AE615) : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: const Color(0xFF7AE615),
                width: 2,
              ),
            ),
            child: is_completed
                ? const Icon(Icons.check, size: 20, color: Colors.black)
                : null,
          ),

          const SizedBox(width: 16),

          // Title + date
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Priority Pill
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: getPriorityColor(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              priority,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// class TaskCard extends StatelessWidget {
//   final String title;
//   final String description;
//   final String priority;

//   const TaskCard({super.key, required this.title, required this.description, required this.priority});

//   Color getPriorityColor() {
//     switch (priority.toLowerCase()) {
//       case 'high':
//         return Colors.redAccent;
//       case 'medium':
//         return Colors.orange;
//       default:
//         return Colors.green;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final badgeColor = getPriorityColor();
//     return Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Container(
//             width: 8,
//             height: 56,
//             decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(6)),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
//               const SizedBox(height: 6),
//               Text(description, style: const TextStyle(color: Colors.black54)),
//               const SizedBox(height: 8),
//               Align(
//                 alignment: Alignment.centerRight,
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
//                   decoration: BoxDecoration(color: badgeColor.withOpacity(0.12), borderRadius: BorderRadius.circular(20)),
//                   child: Text(priority.toUpperCase(), style: TextStyle(color: badgeColor, fontWeight: FontWeight.bold)),
//                 ),
//               ),
//             ]),
//           )
//         ]),
//       ),
//     );
//   }
// }
