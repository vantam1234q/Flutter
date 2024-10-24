
import 'package:flutter_end/data/models/destination_model.dart';

class WishlistService {
  static final WishlistService _instance = WishlistService._internal();

  factory WishlistService() {
    return _instance;
  }

  WishlistService._internal();

  final List<DestinationModel> _wishlist = [];

  List<DestinationModel> get wishlist => _wishlist;

  void addToWishlist(DestinationModel destination) {
    if (!_wishlist.contains(destination)) {
      _wishlist.add(destination);
    }
  }

  void removeFromWishlist(DestinationModel destination) {
    _wishlist.remove(destination);
  }

  bool isFavorite(DestinationModel destination) {
    return _wishlist.contains(destination);
  }
}
