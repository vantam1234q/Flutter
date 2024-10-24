import 'package:flutter/material.dart';
import 'package:flutter_end/constants/app_images.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget{
  const HomeAppBar({
    required this.onSearchChanged,
    super.key
    });
 /// Hàm được gọi khi người dùng thay đổi nội dung tìm kiếm
  final ValueChanged<String> onSearchChanged;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(
        greet(), // lay ham greet tao o ngoai
        style: const TextStyle(
          color: Colors.black,
          fontSize: 25,
          fontWeight: FontWeight.bold
        ),
      ),
      titleSpacing: 25,
      actions: [
        GestureDetector(
          // ClipRRect bo tron ava 
          child: ClipRRect( 
            borderRadius: const BorderRadius.all(Radius.circular(22.5)),
            child: Image.asset(
              AppImages.avatar,
              width: 45,
              height: 45,
            )
          ),
          // xu li su kien khi an vao avatar --> thuong la chuyen qua profileScreen
          onTap: () {
            Navigator.pushNamed(context, '/profile');
          }
        ),
        const SizedBox(width: 20)

      ]
    );
  }

  String greet() {
    var hour = DateTime.now().hour;
    var greeting = '';
    if(hour<12) {
      greeting = 'Good Morning☀️';
    }
   if(hour<18) {
    greeting = 'Good Afternoon🌤️';
   }else{
    greeting = 'Good Evening 🌃';
   }

    return "$greeting ";
  }
  /// Kích thước ưu tiên của AppBar
  @override
  Size get preferredSize => const Size.fromHeight(70);
}