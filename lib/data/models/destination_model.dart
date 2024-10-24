
import 'package:flutter_end/data/models/firebase/fb_destination_model.dart';
import 'package:intl/intl.dart';


/// DestinationModel là một lớp chứa thông tin của một điểm đến du lịch.
class DestinationModel {
  /// Constructor của DestinationModel
  const DestinationModel({
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

  /// ID của điểm đến
  final String? id;

  /// Tên của điểm đến
  final String name;

  /// Đường dẫn hình ảnh của điểm đến
  final String imageUrl;

  /// Đánh giá trung bình của điểm đến
  final double rating;

  /// Số lượng đánh giá của điểm đến
  final int reviewsCount;

  /// Mô tả về điểm đến
  final String description;

  /// Tiện ích có sẵn tại điểm đến
  final Map<String, bool> facilities;

  /// Giá trung bình cho điểm đến
  final double price;

  /// Đơn vị tiền tệ
  final String currency;

  /// Vị trí của điểm đến (latitude, longitude)
  final Map<String, double> location;

  /// Thời gian tạo
  final DateTime createdAt;

  /// Thời gian cập nhật
  final DateTime? updatedAt;

  /// Hàm copyWith tạo ra một bản sao mới của DestinationModel với các thuộc tính được cung cấp.
  DestinationModel copyWith({
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
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DestinationModel(
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

  /// Hàm toJson chuyển đổi DestinationModel sang dạng Map để lưu trữ trong Firestore.
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
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt?.millisecondsSinceEpoch,
    };
  }

  /// Factory để tạo DestinationModel từ dữ liệu JSON.
  factory DestinationModel.fromJson(Map<String, dynamic> json) {
    return DestinationModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['image_url'],
      rating: json['rating'],
      reviewsCount: json['reviews_count'],
      description: json['description'],
      facilities: (json['facilities'] as Map).map((k, v) => MapEntry(k as String, v as bool)),
      price: json['price'],
      currency: json['currency'],
      location: (json['location'] as Map).map((k, v) => MapEntry(k as String, v as double)),
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at']),
      updatedAt: json['updated_at'] != null ? DateTime.fromMillisecondsSinceEpoch(json['updated_at']) : null,
    );
  }

  @override
  String toString() {
    return 'DestinationModel{id: $id, name: $name, imageUrl: $imageUrl, rating: $rating, reviewsCount: $reviewsCount, description: $description, facilities: $facilities, price: $price, currency: $currency, location: $location, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

/// DestinationModelExtension là một extension của DestinationModel
extension DestinationModelExtension on DestinationModel {
  /// Hiển thị theo định dạng ngày tháng
  String get displayCreatedAt {
    final dateFormat = DateFormat('d MMM yyyy');
    return dateFormat.format(createdAt);
  }

  /// Tạo một FbDestinationModel từ DestinationModel
  FbDestinationModel toFbDestinationModel() {
    return FbDestinationModel(
      id: id ?? '',
      name: name,
      imageUrl: imageUrl,
      rating: rating,
      reviewsCount: reviewsCount,
      description: description,
      facilities: facilities,
      price: price,
      currency: currency,
      location: location,
      createdAt: createdAt.millisecondsSinceEpoch,
      updatedAt: updatedAt?.millisecondsSinceEpoch,
    );
  }
}
