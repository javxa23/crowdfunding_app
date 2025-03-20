import 'package:crowdfunding_app/pages/campaign_create_page.dart';
import 'package:crowdfunding_app/styles/style.dart';
import 'package:flutter/material.dart';

class SidebarDrawer extends StatefulWidget {
  const SidebarDrawer({Key? key}) : super(key: key);

  @override
  State<SidebarDrawer> createState() => _SidebarDrawerState();
}

class _SidebarDrawerState extends State<SidebarDrawer> {
  bool isPersonalSelected = true;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              SizedBox(height: 30),
              Row(
                children: [
                  Icon(Icons.send, color: MyColors.primary, size: 30),
                  const SizedBox(width: 8),
                  const Text(
                    'Хандивын систем',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    ' v1.0',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Main navigation menu items
              _buildMenuItem(Icons.grid_view, 'Статистик'),
              _buildMenuItem(Icons.history, 'Хандивын түүх'),
              _buildMenuItem(Icons.mail_outline, 'И-мэйл'),
              _buildMenuItem(Icons.create, 'Хандивын аян үүсгэх'),
              _buildMenuItem(Icons.calendar_today_outlined, 'Календарь'),
              _buildMenuItem(Icons.person_outline, 'Харилцагчид'),

              const SizedBox(height: 24),

              // Account section header
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'ХАЯГ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Account menu items
              _buildNotificationItem(
                Icons.notifications_outlined,
                'Мэдэгдэл',
                24,
              ),
              _buildMenuItem(Icons.settings_outlined, 'Тохиргоо'),

              const Spacer(),

              // User profile section
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage(
                        'assets/images/test-imge.png',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Хүслэн',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'khuslen@gmail.com',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.more_horiz),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CampaignCreatePage()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: Colors.grey[600], size: 20),
            const SizedBox(width: 16),
            Text(
              title,
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationItem(IconData icon, String title, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 20),
          const SizedBox(width: 16),
          Text(title, style: TextStyle(color: Colors.grey[600], fontSize: 16)),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color:
                  title == 'Notifications'
                      ? Colors.green[100]
                      : Colors.orange[100],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              count.toString(),
              style: TextStyle(
                color:
                    title == 'Notifications'
                        ? Colors.green[900]
                        : Colors.orange[900],
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
