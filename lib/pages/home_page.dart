import 'package:crowdfunding_app/widgets/sidebar_drawer.dart';
import 'package:crowdfunding_app/pages/campaign_detail_page.dart';
import 'package:crowdfunding_app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:crowdfunding_app/api/api_service.dart';
import 'package:crowdfunding_app/pages/auth/login_page.dart';
import 'package:crowdfunding_app/widgets/campaigns_row.dart';

import 'search_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userName = "Хүслэн";
  List<Map<String, dynamic>> urgentCampaigns = [];
  List<Map<String, dynamic>> featuredCampaigns = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    setState(() {
      isLoading = true;
    });

    try {
      await Future.delayed(Duration(seconds: 2));
      final urgent = [
        {
          'id': '1',
          'title': 'Хүүхдийн эмнэлэгт тоног төхөөрөмж худалдан авах',
          'imageUrl': 'https://example.com/urgent1.jpg',
          'currentAmount': '8.2 сая ₮',
          'targetAmount': '10 сая ₮',
          'progress': 0.82,
          'timeLeft': 2,
          'category': 'Эрүүл мэнд',
        },
        {
          'id': '2',
          'title': 'Үерт өртсөн гэр бүлүүдэд туслах аян',
          'imageUrl': 'https://example.com/urgent2.jpg',
          'currentAmount': '5.7 сая ₮',
          'targetAmount': '15 сая ₮',
          'progress': 0.38,
          'timeLeft': 5,
          'category': 'Байгаль орчин',
        },
        {
          'id': '3',
          'title': 'Осолд орсон малчин Болдын эмчилгээ',
          'imageUrl': 'https://example.com/urgent3.jpg',
          'currentAmount': '2.4 сая ₮',
          'targetAmount': '3 сая ₮',
          'progress': 0.8,
          'timeLeft': 1,
          'category': 'Эрүүл мэнд',
        },
      ];
      final featured = [
        {
          'id': '1',
          'title': 'Хөдөө орон нутгийн сургуульд номын сан байгуулах',
          'imageUrl': 'https://example.com/featured1.jpg',
          'currentAmount': '12.8 сая ₮',
          'targetAmount': '25 сая ₮',
          'progress': 0.51,
          'timeLeft': 14,
          'category': 'Боловсрол',
        },
        {
          'id': '2',
          'title': 'Тэнэмэл амьтдыг хамгаалах төв байгуулах',
          'imageUrl': 'https://example.com/featured2.jpg',
          'currentAmount': '9.2 сая ₮',
          'targetAmount': '20 сая ₮',
          'progress': 0.46,
          'timeLeft': 21,
          'category': 'Амьтан',
        },
        {
          'id': '3',
          'title':
              'Олон улсын математикийн олимпиадад оролцох сурагчдад туслах',
          'imageUrl': 'https://example.com/featured3.jpg',
          'currentAmount': '4.5 сая ₮',
          'targetAmount': '6 сая ₮',
          'progress': 0.75,
          'timeLeft': 10,
          'category': 'Боловсрол',
        },
        {
          'id': '4',
          'title': 'Мод тарих хөдөлгөөн - 10,000 мод',
          'imageUrl': 'https://example.com/featured4.jpg',
          'currentAmount': '7.4 сая ₮',
          'targetAmount': '8 сая ₮',
          'progress': 0.93,
          'timeLeft': 7,
          'category': 'Байгаль орчин',
        },
      ];

      setState(() {
        urgentCampaigns = urgent;
        featuredCampaigns = featured;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Өгөгдөл ачаалахад алдаа гарлаа')));
    }
  }

  void logout() async {
    // await ApiService.logout();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      endDrawer: const SidebarDrawer(),
      key: _scaffoldKey,
      backgroundColor: MyColors.primary,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  const CircleAvatar(backgroundColor: Colors.white, radius: 22),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Сайн байна уу!',
                        style: TextStyle(fontSize: 12, color: Colors.white70),
                      ),
                      Text(
                        userName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.menu),
                    color: Colors.white,
                    onPressed: () {
                      _scaffoldKey.currentState?.openEndDrawer();
                    },
                    iconSize: 28,
                  ),
                ],
              ),
            ),

            // Search bar
            // Search bar section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder:
                          (context, animation, secondaryAnimation) =>
                              const SearchPage(),
                      transitionsBuilder: (
                        context,
                        animation,
                        secondaryAnimation,
                        child,
                      ) {
                        // Defining the transition animation
                        const begin = Offset(
                          0.0,
                          1.0,
                        ); // Start from bottom of the screen
                        const end =
                            Offset.zero; // End at the center of the screen
                        const curve = Curves.easeInOut;

                        var tween = Tween(
                          begin: begin,
                          end: end,
                        ).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Hero(
                  tag: 'search-field', // Unique tag for the shared element
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const TextField(
                      enabled: false,
                      decoration: InputDecoration(
                        hintText: 'Хандивын аян хайх',
                        hintStyle: TextStyle(color: Colors.grey),
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            // Main content with white background
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child:
                    isLoading
                        ? Center(child: CircularProgressIndicator())
                        : RefreshIndicator(
                          onRefresh: () async {
                            // loadData();
                          },
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Хандивын аяны төрөл',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 16),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            _buildCategoryItem(
                                              Icons.medical_services,
                                              'Эрүүл мэнд',
                                              Colors.blue,
                                            ),
                                            _buildCategoryItem(
                                              Icons.book,
                                              'Боловсрол',
                                              Colors.blue,
                                            ),
                                            _buildCategoryItem(
                                              Icons.pets,
                                              'Амьтан',
                                              Colors.blue,
                                            ),
                                            _buildCategoryItem(
                                              Icons.nature,
                                              'Байгаль орчин',
                                              Colors.blue,
                                            ),
                                            _buildCategoryItem(
                                              Icons.grid_view,
                                              'Бүгд',
                                              Colors.blue,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  // Urgent campaigns section
                                  CampaignsRow(
                                    context,
                                    'Яаралтай хандивын аянууд',
                                    urgentCampaigns,
                                    () {
                                      // Navigate to all urgent campaigns
                                    },
                                  ),

                                  const SizedBox(height: 20),

                                  // Featured campaigns section
                                  CampaignsRow(
                                    context,
                                    'Онцлох хандивын аянууд',
                                    featuredCampaigns,
                                    () {
                                      // Navigate to all featured campaigns
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, Color color) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
