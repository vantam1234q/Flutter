import 'package:flutter/material.dart';
import 'package:flutter_end/screens/favorite/favorite_service.dart';


class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wishlistItems = WishlistService().wishlist; // Lấy danh sách yêu thích

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Wishlist'),
      ),
      body: wishlistItems.isEmpty
          ? const Center(child:  Text('Your wishlist is empty.')) // Thông báo nếu không có địa điểm nào
          : ListView.builder(
              itemCount: wishlistItems.length,
              itemBuilder: (context, index) {
                final item = wishlistItems[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.imageUrl,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Price: \$${item.price}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.yellow, size: 16),
                                  Text('${item.rating} (${item.reviewsCount} Reviews)'),
                                ],
                              ),
                              const SizedBox(height: 4),
                              // Giới hạn phần mô tả hiển thị tối đa 1 dòng
                              Text(
                                item.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis, // Hiển thị dấu "..."
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.favorite, color: Colors.red), // Biểu tượng trái tim
                          onPressed: () {
                            // Xử lý bỏ yêu thích
                            WishlistService().removeFromWishlist(item);
                            // Cập nhật giao diện người dùng
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('${item.name} removed from wishlist.')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
