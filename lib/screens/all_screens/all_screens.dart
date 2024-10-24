import 'package:flutter/material.dart';
import 'package:flutter_end/data/models/destination_model.dart';
import 'package:flutter_end/data/models/firebase/firebase_service.dart';
import 'package:flutter_end/screens/detailScreen/detail_screen.dart';
import 'package:flutter_end/screens/home/widgets/item_category.dart';

class AllDestinationsScreen extends StatelessWidget {
   AllDestinationsScreen({super.key});
  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tất Cả Chuyến Đi'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Nút quay lại
          onPressed: () {
            Navigator.pop(context); // Quay lại màn hình trước đó
          },
        ),
      ),
      body: StreamBuilder<List<DestinationModel>>(
        stream: _firebaseService.getDestinations(), // Lấy tất cả các chuyến đi
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có chuyến đi nào.'));
          }

          final destinations = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(10), // Padding cho GridView
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Số cột trong grid
              childAspectRatio: 0.75, // Tỷ lệ chiều rộng và chiều cao của mỗi ô
            ),
            itemCount: destinations.length,
            itemBuilder: (context, index) {
              final destination = destinations[index];
              return GestureDetector(
                onTap: () {
                  debugPrint("HIhi");
                  // Điều hướng đến màn hình chi tiết
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(product: destination), // Truyền thông tin địa điểm
                    ),
                  );
                },
                child: ItemCategory(product: destination), // Sử dụng ItemCategory
              );
            },
          );
        },
      ),
    );
  }
}
