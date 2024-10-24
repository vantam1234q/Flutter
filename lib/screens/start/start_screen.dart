import 'package:flutter/material.dart';
import 'package:flutter_end/constants/app_images.dart';
import 'package:flutter_end/screens/login/login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  static const routeName = '/start';

  @override
  Widget build(BuildContext context) {
    // Lấy kích thước màn hình
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Nền
          Container(
            width: screenSize.width, // Đặt chiều rộng bằng chiều rộng màn hình
            height: screenSize.height, // Đặt chiều cao bằng chiều cao màn hình
            color: Colors.white, // Màu nền nâu
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 200), // Khoảng cách từ trên xuống
                // Logo
                Column(
                  children: [
                    Image.asset(
                      AppImages.logo, // Đường dẫn tới logo
                      width: 250, // Kích thước logo
                    ),
                    const SizedBox(height: 20), // Khoảng cách giữa logo và tên
                    const Text(
                      'Ong Chau Lap Trinh Service',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 14, 14, 14),
                      ),
                    ),
                    const SizedBox(height: 8), // Khoảng cách giữa tên và mô tả
                    const Text(
                      'YOUR TRAVEL SERVICE',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(179, 8, 8, 8),
                      ),
                    ),
                  ],
                ),
                const Spacer(), // Đẩy nút xuống dưới
                // Nút Explore
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  child: ElevatedButton(
                    onPressed: () {
                      // Chức năng khi nhấn nút Explore
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Màu cam
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Đặt giá trị borderRadius nhỏ hơn
                      ),
                    ),
                    child: const Text(
                      'Get Started',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                const SizedBox(height: 50), // Khoảng cách dưới cùng
              ],
            ),
          ),
        ],
      ),
    );
  }
}
