import 'package:crowdfunding_app/pages/auth/register_page.dart';
import 'package:crowdfunding_app/pages/campaign_create_page.dart';
import 'package:crowdfunding_app/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:crowdfunding_app/api/api_service.dart';
import 'package:crowdfunding_app/pages/home_page.dart';
import 'package:crowdfunding_app/pages/auth/login_page.dart';
import 'package:crowdfunding_app/pages/campaign_detail_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String? token = await ApiService.getToken();
  runApp(MyApp(token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp(this.isLoggedIn);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
      // home: CampaignDetailPage(id: "1"),
      // home: CampaignCreatePage(),
    );
  }
}
