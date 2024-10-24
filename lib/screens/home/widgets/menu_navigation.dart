import 'package:flutter/material.dart';
import 'package:flutter_end/constants/app_colors.dart';

class MenuNavigation extends StatefulWidget {
  const MenuNavigation({super.key});

  @override
  State<MenuNavigation> createState() => _MenuNavigationState();
}

class _MenuNavigationState extends State<MenuNavigation> {
  // Danh sách các danh mục
  final List<String> categories = ["Location", "Hotels", "Adventure", "Food" ,"Adventure .."];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index; // Cập nhật chỉ số mục đã chọn
              });
            },
            child: Container(
             
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 23),
          
              child: Text(
                categories[index],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: selectedIndex == index ? Colors.orange : AppColors.hex4F4F4F // Màu chữ
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
