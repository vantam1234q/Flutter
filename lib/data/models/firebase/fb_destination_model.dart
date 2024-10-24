import 'package:flutter_end/data/models/destination_model.dart';

/// FbDestinationModel đại diện cho cấu trúc dữ liệu của điểm đến khi lưu trữ trong Firebase.
class FbDestinationModel {
  const FbDestinationModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.rating,
    required this.reviewsCount,
    required this.description,
    required this.facilities,
    required this.price,
    required this.currency,
    required this.location,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id; // ID của điểm đến
  final String name; // Tên điểm đến
  final String imageUrl; // Đường dẫn hình ảnh
  final double rating; // Đánh giá trung bình
  final int reviewsCount; // Số lượng đánh giá
  final String description; // Mô tả
  final Map<String, bool> facilities; // Tiện ích có sẵn
  final double price; // Giá trung bình
  final String currency; // Đơn vị tiền tệ
  final Map<String, double> location; // Vị trí (latitude, longitude)
  final int createdAt; // Thời gian tạo (dạng timestamp)
  final int? updatedAt; // Thời gian cập nhật (dạng timestamp)

  FbDestinationModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    double? rating,
    int? reviewsCount,
    String? description,
    Map<String, bool>? facilities,
    double? price,
    String? currency,
    Map<String, double>? location,
    int? createdAt,
    int? updatedAt,
  }) {
    return FbDestinationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      description: description ?? this.description,
      facilities: facilities ?? this.facilities,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image_url': imageUrl,
      'rating': rating,
      'reviews_count': reviewsCount,
      'description': description,
      'facilities': facilities,
      'price': price,
      'currency': currency,
      'location': location,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  factory FbDestinationModel.fromJson(Map<String, dynamic> json, String id) {
    return FbDestinationModel(
      id: id,
      name: json['name'],
      imageUrl: json['image_url'],
      rating: json['rating'],
      reviewsCount: json['reviews_count'],
      description: json['description'],
      facilities: (json['facilities'] as Map).map((k, v) => MapEntry(k as String, v as bool)),
      price: json['price'],
      currency: json['currency'],
      location: (json['location'] as Map).map((k, v) => MapEntry(k as String, v as double)),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  @override
  String toString() {
    return 'FbDestinationModel{id: $id, name: $name, imageUrl: $imageUrl, rating: $rating, reviewsCount: $reviewsCount, description: $description, facilities: $facilities, price: $price, currency: $currency, location: $location, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

/// FbDestinationModelExtension là một extension của FbDestinationModel
extension FbDestinationModelExtension on FbDestinationModel {
  /// Phương thức toDestinationModel chuyển đổi FbDestinationModel sang DestinationModel
  DestinationModel toDestinationModel() {
    return DestinationModel(
      id: id,
      name: name,
      imageUrl: imageUrl,
      rating: rating,
      reviewsCount: reviewsCount,
      description: description,
      facilities: facilities,
      price: price,
      currency: currency,
      location: location,
      createdAt: DateTime.fromMillisecondsSinceEpoch(createdAt),
      updatedAt: updatedAt != null ? DateTime.fromMillisecondsSinceEpoch(updatedAt!) : null,
    );
  }
}
