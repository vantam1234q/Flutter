import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: Divider(height: 1, color: Colors.black),
        ),
        SizedBox(width: 4),
        Text(
          'OR',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 16,
          ),
        ),
        SizedBox(width: 4),
        Expanded(
          child: Divider(height: 1, color: Colors.black),
        ),
      ],
    );
  }
}
