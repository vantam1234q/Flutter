import 'package:flutter/material.dart';
import 'package:flutter_end/constants/app_icons.dart';
import 'package:flutter_end/data/models/destination_model.dart'; // Nhập DestinationModel
import 'package:flutter_end/data/models/firebase/firebase_service.dart';
import 'package:flutter_end/screens/all_screens/all_screens.dart';
import 'package:flutter_end/screens/favorite/favorite_screen.dart';
import 'package:flutter_end/screens/home/widgets/header_item.dart';
import 'package:flutter_end/screens/home/widgets/home_app_bar.dart';
import 'package:flutter_end/screens/home/widgets/item_category.dart';
import 'package:flutter_end/screens/home/widgets/menu_navigation.dart';
import 'package:flutter_end/screens/home/widgets/search_field.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = '/home';
  
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Biến lưu trữ chỉ số tab hiện tại
  final FirebaseService firebaseService = FirebaseService(); // Khởi tạo dịch vụ Firebase

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        onSearchChanged: (value) {
          debugPrint("Search text changed: $value");
        },
      ),
      body: SafeArea(
        child: _getSelectedPage(), // Hiển thị nội dung dựa trên tab được chọn
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index; // Cập nhật chỉ số tab đã chọn
            });
          },
          selectedFontSize: 15,
          selectedItemColor: Colors.orange, // Màu cho item được chọn
          unselectedItemColor: Colors.black, // Màu cho item không được chọn
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Image.asset(
                AppIcons.home,
                width: 20,
                height: 20,
                color: _currentIndex == 0 ? Colors.orange : Colors.black, // Màu icon cho Home
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                AppIcons.favorite,
                width: 20,
                height: 20,
                color: _currentIndex == 1 ? Colors.orange : Colors.black, // Màu icon cho Favorite
              ),
              label: "Favorite",
            ),
          ],
        ),
      ),
    );
  }

  // Hàm trả về widget tương ứng với tab được chọn
  Widget _getSelectedPage() {
    switch (_currentIndex) {
      case 0:
        return _buildHomeContent();
      case 1:
        return const WishlistScreen(); // Hiển thị màn hình yêu thích
      default:
        return _buildHomeContent();
    }
  }

  // Nội dung của màn hình Home
  Widget _buildHomeContent() {
    return StreamBuilder<List<DestinationModel>>(
      stream: firebaseService.getDestinations(), // Lấy danh sách địa điểm từ Firestore
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No destinations found.'));
        }

        final destinations = snapshot.data!;

        return SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: SearchField(
                  hintText: "Search Here",
                  onChangd: (value) {
                    debugPrint("Search text changed: $value");
                  },
                ),
              ),
              const MenuNavigation(),
              HeaderItem(
                title: "Popular",
                onSeeAll: () {
                   Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllDestinationsScreen()), // Điều hướng đến màn hình hiển thị tất cả chuyến đi
              );
                },
              ),
              // Hiển thị danh sách sản phẩm
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: destinations.length > 2 ? 2 : destinations.length,
                  itemBuilder: (context, index) {
                    final product = destinations[index];
                    return ItemCategory(product: product); // Sử dụng DestinationModel
                  },
                ),
              ),
              HeaderItem(title: "Recommended", onSeeAll: () {
                     Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AllDestinationsScreen()), // Điều hướng đến màn hình hiển thị tất cả chuyến đi
              );
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: destinations.length > 2 ? 2 : destinations.length,
                  itemBuilder: (context, index) {
                    final product = destinations[index + 2]; // Lấy sản phẩm từ danh sách
                    return ItemCategory(product: product);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
