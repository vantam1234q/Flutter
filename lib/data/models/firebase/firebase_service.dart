import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_end/data/models/destination_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Thêm thông tin điểm đến vào Firestore
  Future<void> addDestination(DestinationModel destination) async {
    await _firestore.collection('destinations').doc(destination.id).set(destination.toJson());
  }

  // Hàm thêm dữ liệu mẫu vào Firestore nếu chưa có
  Future<void> addSampleDestinations() async {
    // Kiểm tra xem có dữ liệu mẫu hay chưa
    final snapshot = await _firestore.collection('destinations').get();
    if (snapshot.docs.isNotEmpty) {
      debugPrint("Dữ liệu mẫu đã tồn tại. Không thêm nữa.");
      return; // Nếu đã có dữ liệu, không thêm nữa
    }

    // Nếu không có dữ liệu, thêm dữ liệu mẫu
    final List<DestinationModel> destinations = [
      DestinationModel(
        id: '1',
        name: 'Hoi An',
        imageUrl: 'https://hoianheritage.net/uploads/bao-chi/2022_04/pho-co-hoi-an.jpg',
        rating: 4.1,
        reviewsCount: 250,
        description: 'A charming ancient town known for its preserved architecture and vibrant lanterns. Experience delicious local cuisine and explore bustling night markets.',
        facilities: {'Internet': true, 'Dinner': true, 'Parking': true, 'Swimming Pool': true, 'Spa': true},
        price: 500.0,
        currency: 'USD',
        location: {'latitude': 15.8801, 'longitude': 108.3380},
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      DestinationModel(
        id: '2',
        name: 'Da Nang',
        imageUrl: 'https://intourcoresort.com.vn/wp-content/uploads/2022/11/AP13-Rong-Vang-Phun-Lua.jpeg',
        rating: 4.2,
        reviewsCount: 300,
        description: 'A vibrant coastal city with stunning beaches and rich cultural heritage. Don\'t miss the famous Golden Bridge and local seafood delicacies.',
        facilities: {'Internet': true, 'Dinner': true, 'Gym': true, 'Beach Access': true, 'Airport Shuttle': true},
        price: 300.0,
        currency: 'USD',
        location: {'latitude': 16.0583, 'longitude': 108.2208},
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      DestinationModel(
        id: '3',
        name: 'Ba Na Hills',
        imageUrl: 'https://d2sx1calt21doo.cloudfront.net/xxt/experience/image/SW-Ba-Na-Hill-jpg-1017x720-FIT-ad7f758d85a12ffe1633b5de80cb3322.jpeg',
        rating: 4.5,
        reviewsCount: 150,
        description: 'A hill station offering breathtaking views and a unique French village experience. Enjoy thrilling rides and explore beautiful gardens.',
        facilities: {'Internet': true, 'Dinner': true, 'Cable Car': true, 'Entertainment': true, 'Shopping': true},
        price: 500.0,
        currency: 'USD',
        location: {'latitude': 15.8752, 'longitude': 107.7009},
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      DestinationModel(
        id: '4',
        name: 'Phong Nha Ke Bang',
        imageUrl: 'https://th.bing.com/th/id/R.faf639d5f0ae879b9e454574d2ca63f1?rik=mvV%2bNdNnxNzSHQ&pid=ImgRaw&r=0',
        rating: 4.4,
        reviewsCount: 180,
        description: 'A UNESCO World Heritage Site famous for its stunning caves and diverse ecosystems. Explore breathtaking landscapes and unique wildlife.',
        facilities: {'Internet': false, 'Dinner': true, 'Camping': true, 'Guided Tours': true, 'Cave Exploration': true},
        price: 300.0,
        currency: 'USD',
        location: {'latitude': 17.4668, 'longitude': 106.1315},
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      DestinationModel(
        id: '5',
        name: 'Halong Bay',
        imageUrl: 'https://realbiz.vn/wp-content/uploads/2023/06/ha-long-bay-vinh-ha-long-la-mot-trong-nhung-diem-du-lich-noi-tieng-va-dep-nhat-o-viet-nam.jpg',
        rating: 4.7,
        reviewsCount: 400,
        description: 'Famous for emerald waters and thousands of limestone islands. Enjoy cruises, explore hidden caves, and soak in the breathtaking scenery.',
        facilities: {'Internet': true, 'Dinner': true, 'Kayaking': true, 'Fishing': true, 'Boat Tours': true},
        price: 600.0,
        currency: 'USD',
        location: {'latitude': 20.3448, 'longitude': 107.4663},
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
      DestinationModel(
        id: '6',
        name: 'Sapa',
        imageUrl: 'https://th.bing.com/th/id/R.be1891e2fee4a4d6a26762414e88227b?rik=YnHvBadYb%2bW5OQ&pid=ImgRaw&r=0',
        rating: 4.5,
        reviewsCount: 350,
        description: 'Known for stunning terraced rice fields and rich cultural diversity. Trek through beautiful landscapes and engage with local ethnic groups.',
        facilities: {'Internet': true, 'Dinner': true, 'Trekking': true, 'Cultural Experiences': true, 'Transport Services': true},
        price: 400.0,
        currency: 'USD',
        location: {'latitude': 22.3475, 'longitude': 103.8440},
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ];

    // Thêm từng địa điểm vào Firestore
    for (final destination in destinations) {
      await addDestination(destination);
    }
  }

  // Lấy danh sách điểm đến từ Firestore
  Stream<List<DestinationModel>> getDestinations() {
    return _firestore.collection('destinations').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return DestinationModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
