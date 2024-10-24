import 'package:flutter/material.dart';
import 'package:flutter_end/data/models/destination_model.dart';
import 'package:flutter_end/screens/favorite/favorite_service.dart';

class DetailScreen extends StatelessWidget {
  final DestinationModel product; // Nhận đối tượng DestinationModel

  const DetailScreen({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hình ảnh lớn của địa điểm
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 350, // Chiều cao cho hình ảnh lớn hơn
                  ),
                ),
                const SizedBox(height: 20), // Khoảng cách
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.yellow, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        '${product.rating} (${product.reviewsCount} Reviews)', // Hiển thị đánh giá
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    product.description, // Mô tả địa điểm
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20), // Khoảng cách
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Facilities', // Tiêu đề cho danh sách dịch vụ
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Wrap(
                    spacing: 10,
                    children: product.facilities.entries
                        .where((entry) => entry.value) // Chỉ lấy các dịch vụ có sẵn
                        .map((entry) => Chip(
                              avatar: Icon(getFacilityIcon(entry.key)), // Lấy biểu tượng cho dịch vụ
                              label: Text(entry.key), // Hiển thị tên dịch vụ
                              backgroundColor: Colors.orange.shade100,
                            ))
                        .toList(),
                  ),
                ),
                const SizedBox(height: 20), // Khoảng cách
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Text(
                        'Price: \$${product.price} ${product.currency}', // Giá của địa điểm
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(), // Đẩy nút "Book Now" sang bên phải
                      ElevatedButton(
                        onPressed: () {
                          debugPrint("Book Now button pressed"); // Thông báo khi nút "Book Now" được nhấn
                        },
                        child: const Text('Book Now'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20), // Khoảng cách
              ],
            ),
          ),
          // Vị trí cho các biểu tượng quay lại và trái tim
          Positioned(
            top: 40,
            left: 16,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context); // Quay lại màn hình trước
              },
            ),
          ),
          Positioned(
            top: 40,
            right: 16,
            child: IconButton(
              icon: Icon(
                WishlistService().isFavorite(product) 
                  ? Icons.favorite 
                  : Icons.favorite_border, 
                color: Colors.red, size: 30),
              onPressed: () {
                if (WishlistService().isFavorite(product)) {
                  WishlistService().removeFromWishlist(product);
                } else {
                  WishlistService().addToWishlist(product);
                }
                debugPrint("Favorite button pressed");
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData getFacilityIcon(String facility) {
    switch (facility) {
      case 'Internet':
        return Icons.wifi; // Biểu tượng ví dụ cho internet
      case 'Dinner':
        return Icons.fastfood; // Biểu tượng ví dụ cho bữa tối
      case 'Tub':
        return Icons.hot_tub; // Biểu tượng ví dụ cho bồn tắm
      case 'Pool':
        return Icons.pool; // Biểu tượng ví dụ cho bể bơi
      default:
        return Icons.room_service; // Biểu tượng mặc định
    }
  }
}
