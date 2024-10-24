import 'package:flutter/material.dart';
import 'package:flutter_end/constants/app_colors.dart';
import 'package:flutter_end/data/models/destination_model.dart';
import 'package:flutter_end/screens/detailScreen/detail_screen.dart';

class ItemCategory extends StatelessWidget {
  const ItemCategory({
    super.key,
    required this.product,
  });

  final DestinationModel product; // Sử dụng DestinationModel

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Điều hướng đến màn hình chi tiết
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(product: product), // Truyền thông tin địa điểm
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        child: Stack(
          children: [
            // Hình ảnh của sản phẩm
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Positioned(
              bottom: 45,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColors.hex4F4F4F,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  product.name, // Hiển thị tên địa điểm
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            // Hiển thị đánh giá với biểu tượng ngôi sao
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.star,
                      color: Colors.yellow,
                      size: 15,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      product.rating.toString(), // Hiển thị rating
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
