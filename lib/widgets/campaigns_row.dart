import 'package:crowdfunding_app/pages/campaign_detail_page.dart';
import 'package:flutter/material.dart';

Widget CampaignsRow(
  BuildContext context,
  String title,
  List<Map<String, dynamic>> campaigns,
  Function() onViewAll,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: onViewAll,
              child: const Text(
                'Бүгд',
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 16),

      campaigns.isEmpty
          ? Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text('Аян олдсонгүй'),
            ),
          )
          : SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: campaigns.length,
              itemBuilder: (context, index) {
                final campaign = campaigns[index];
                return Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: CampaignCard(
                    context,
                    campaign['imageUrl'] ?? '',
                    campaign['title'] ?? '',
                    campaign['currentAmount'] ?? '',
                    campaign['targetAmount'] ?? '',
                    campaign['progress'] ?? 0.0,
                    campaign['timeLeft'] ?? '',
                    campaign['id'] ?? '',
                  ),
                );
              },
            ),
          ),
    ],
  );
}

Widget CampaignCard(
  BuildContext context,
  String imageUrl,
  String title,
  String currentAmount,
  String targetAmount,
  double progress,
  int timeLeft,
  String campaignId,
) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CampaignDetailPage(id: campaignId),
        ),
      );
    },
    child: Container(
      width: 280,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: Image.asset(
                  'assets/images/test-image.png',
                  height: 130,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              if (timeLeft > 0)
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          timeLeft < 10
                              ? Colors.red[300]
                              : Colors.white, // Light grey background
                      borderRadius: BorderRadius.circular(8), // Rounded corners
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Үлдсэн хугацаа: ',
                          style: TextStyle(
                            fontSize: 12,
                            color: timeLeft < 10 ? Colors.white70 : Colors.grey,
                          ),
                        ),
                        Text(
                          "$timeLeft өдөр",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: timeLeft < 10 ? Colors.white : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          const Spacer(),
          // Content
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 10),

                // Amount
                Row(
                  children: [
                    Text(
                      currentAmount,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    Text(
                      ' / $targetAmount',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
                // Progress bar
                Stack(
                  children: [
                    Container(
                      height: 6,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    Container(
                      height: 6,
                      width: 256 * progress,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Colors.blue, Colors.lightBlueAccent],
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}
