import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> memberImages;
  final int memberCount;
  final VoidCallback onJoinPressed;

  const GroupCard({super.key, 
    required this.title,
    required this.description,
    required this.memberImages,
    required this.memberCount,
    required this.onJoinPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minWidth: double.infinity,
          maxWidth: double.infinity,
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.pink,
                      radius: 10.0,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[700],
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  children: [
                    Stack(
                      children: memberImages.asMap().entries.map((entry) {
                        int idx = entry.key;
                        String imageUrl = entry.value;
                        return Positioned(
                          left: idx * 20.0,
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(imageUrl),
                            radius: 16.0,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(width: 8.0.h),
                    Text(
                      '$memberCount',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                ElevatedButton(
                  onPressed: onJoinPressed,
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.pink),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Join Conversation',
                        style: TextStyle(color: Colors.pink),
                      ),
                      Icon(Icons.arrow_forward, color: Colors.pink),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
