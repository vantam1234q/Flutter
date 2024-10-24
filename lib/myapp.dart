import 'package:flutter/material.dart';
import 'package:flutter_end/data/data_sources/remote/firebase/auth_service.dart';
import 'package:flutter_end/screens/home/home_screen.dart';
import 'package:flutter_end/screens/login/login_screen.dart';
import 'package:flutter_end/screens/profile/profile_screen.dart';
import 'package:flutter_end/screens/register/register_screen.dart';

import 'package:flutter_end/screens/start/start_screen.dart';

/// MyApp là widget chính của ứng dụng
class MyApp extends StatelessWidget {
  /// Constructor của MyApp
  const MyApp({super.key});

  /// Hàm build chứa nội dung của ứng dụng
  @override
  Widget build(BuildContext context) {
 final isUserLoggedIn = AuthService().isUserLoggedIn();

    /// MaterialApp là một widget cung cấp các thuộc tính cơ bản cho ứng dụng
    return MaterialApp(
      /// Tiêu đề của ứng dụng
      title: 'To-Do List',
      
     initialRoute: isUserLoggedIn ? HomeScreen.routeName : SplashScreen.routeName,
     /// Dòng code dưới đây sẽ được sử dụng để định nghĩa các route của ứng dụng
     
    onGenerateRoute: (settings) {
        switch (settings.name) {
          case HomeScreen.routeName:
            return FadeInPageRoute(builder: (context) {
              return const HomeScreen();
            });
          case SplashScreen.routeName:
            return FadeInPageRoute(builder: (context) {
              return const SplashScreen();
            });
          case LoginScreen.routeName:
            return MaterialPageRoute(builder: (context) {
              return const LoginScreen();
            });
          case RegisterScreen.routeName:
            return MaterialPageRoute(builder: (context) {
              return const RegisterScreen();
            });
          case ProfileScreen.routeName:
            return MaterialPageRoute(builder: (context) {
              return const ProfileScreen();
            });
          default:
            return null;
        }
      },
      
      /// Ẩn biểu tượng "Debug" trên màn hình
      debugShowCheckedModeBanner: false,

      /// Chủ đề của ứng dụng
      theme: ThemeData.light(useMaterial3: true),

      /// Chủ đề tối của ứng dụng
      darkTheme: ThemeData.dark(useMaterial3: true),

     
    );
  }
}
class FadeInPageRoute<T> extends MaterialPageRoute<T> {
  FadeInPageRoute({
    required super.builder,
    super.settings,
  });

  @override
  bool canTransitionTo(TransitionRoute<dynamic> nextRoute) {
    return false;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return Opacity(
      opacity: animation.value,
      child: child,
    );
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

