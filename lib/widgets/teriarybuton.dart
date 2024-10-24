import 'package:flutter/material.dart';
import 'package:flutter_end/constants/app_colors.dart';


/// TertiaryButton là một nút tùy chỉnh
class TertiaryButton extends StatelessWidget {
  const TertiaryButton({
    super.key,
    required this.title,
    required this.onTap,
  });

  /// Tiêu đề của nút
  final String title;

  /// Hàm được gọi khi người dùng nhấn nút
  final VoidCallback onTap;

  /// Hàm build chứa nội dung của nút
  @override
  Widget build(BuildContext context) {
    /// InkWell là một widget chứa một hàm được gọi khi người dùng nhấn vào nó
    return InkWell(
      /// Hàm được gọi khi người dùng nhấn nút
      onTap: onTap,

      /// Nội dung của nút
      child: Container(
        /// Chiều cao của nút
        height: 50,

        /// Định dạng của nút
        decoration:  BoxDecoration(
          /// Gradient của nút
          color: AppColors.hex4F4F4F.withOpacity(0.8),

          /// Bo tròn mép của nút
          borderRadius: const BorderRadius.all(Radius.circular(8)),
        ),

        /// Nội dung của nút
        child: Center(
          /// Canh giữa nội dung của nút
          child: Text(
            /// Tiêu đề của nút
            title,

            /// Kiểu chữ của tiêu đề
            style: const TextStyle(
              /// Màu chữ của tiêu đề
              color: Colors.white,

              /// Kích thước chữ của tiêu đề
              fontSize: 16,

              /// Độ đậm của chữ của tiêu đề
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
