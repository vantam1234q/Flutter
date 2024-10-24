import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// Lấy người dùng hiện tại
  User? get currentUser => _firebaseAuth.currentUser;

  /// Kiểm tra người dùng đã đăng nhập chưa
  bool isUserLoggedIn() {
    return currentUser != null;
  }

  /// Đăng ký với email và mật khẩu
  Future<User?> createUser({
    required String email,
    required String password,

  }) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
     
    );
    return userCredential.user;
  }

  /// Đăng nhập với email và mật khẩu
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    UserCredential userCredential =
        await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return userCredential.user;
  }

  /// Đăng xuất
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
