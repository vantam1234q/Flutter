class DbCartModel {
  const DbCartModel({
    required this.isAvailable,
    required this.id,
    required this.description,
    required this.price,
    required this.rating,
    required this.locationName,
    this.quantity = 1, // Giá trị mặc định là 1
    this.imageUrl,
    this.category,
    this.discount = 0, // Giảm giá mặc định là 0%
    this.createdAt,
    this.updatedAt,
  });

  final int? id; // id của cart
  final String locationName; // tên sản phẩm
  final String description; // mô tả sản phẩm
  final String price; // giá của sản phẩm 
  final String rating;
  final bool isAvailable; // còn hàng hay hết hàng
  final int quantity; // số lượng sản phẩm trong giỏ hàng
  final String? imageUrl; // đường dẫn hình ảnh của sản phẩm
  final String? category; // phân loại sản phẩm
  final double discount; // giảm giá cho sản phẩm
  final DateTime? createdAt; // thời gian sản phẩm được thêm vào giỏ
  final DateTime? updatedAt; // thời gian cập nhật giỏ hàng
  
  // Phương thức tính tổng giá với giảm giá (nếu cần)
  String get totalPrice {
    double priceValue = double.tryParse(price) ?? 0.0;
    double finalPrice = priceValue * quantity * (1 - discount / 100);
    return finalPrice.toStringAsFixed(2);
  }
}
