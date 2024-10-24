  import 'package:flutter/material.dart';

class HeaderItem extends StatelessWidget {
  const HeaderItem({
    super.key,
    required this.title,
    required this.onSeeAll
    });
  
  final String title ;
  final VoidCallback onSeeAll;
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding:  const  EdgeInsets.symmetric(
        vertical: 13,
        horizontal: 25,
      ),
      child: Row(
        children: [
          Expanded(child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold

            )
          ),
          ),
          GestureDetector(
            onTap: onSeeAll,
            child: const Text(
              'See all',
              style:  TextStyle(
                fontSize: 20,
                color : Colors.orange
              ),
            ),
          )
        ],
      ),
    );
  }
}