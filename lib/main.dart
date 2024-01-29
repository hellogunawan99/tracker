import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tracker/presentation/page/login_page.dart';
import 'config/session.dart';
import 'presentation/controller/c_user.dart';
import 'presentation/page/dashboard_page.dart';
// import 'presentation/page/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Session.getUser();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cUser = Get.put(CUser());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.lightBlue,
        ),
        colorScheme: const ColorScheme.dark().copyWith(
          primary: Colors.lightBlue,
        ),
      ),
      home: Obx(() {
        if (cUser.data.idUser == null) return const LoginPage();
        return const DashboardPage();
      }),
    );
  }
}
