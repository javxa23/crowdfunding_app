import 'package:flutter/material.dart';

import '../styles/style.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Hero(
          tag: 'search-field', // Use the same tag as in the previous widget
          child: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: "Хандивын аян хайх",
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey),
            ),
            onChanged: (value) {
              if (value.length > 2) {
                performSearch(value);
              } else if (value.isEmpty) {
                setState(() {
                  searchResults = [];
                  isSearching = false;
                });
              }
            },
            onSubmitted: (value) {
              performSearch(value);
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.grey),
            onPressed: () {
              _searchController.clear();
              setState(() {
                searchResults = [];
                isSearching = false;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Хайлтын үр дүнгийн жагсаалт
          Expanded(
            child:
                isSearching
                    ? const Center(child: CircularProgressIndicator())
                    : searchResults.isEmpty
                    ? _buildEmptyState()
                    : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search, size: 80, color: Colors.grey.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            _searchController.text.isEmpty
                ? "Хайх үгээ оруулна уу"
                : "Хайлтын үр дүн олдсонгүй",
            style: TextStyle(fontSize: 16, color: Colors.grey.withOpacity(0.8)),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final campaign = searchResults[index];
        return GestureDetector(
          onTap: () {
            // Хандивын аяны дэлгэрэнгүй хуудас руу шилжих
            // Navigator.push(context, MaterialPageRoute(builder: (context) => CampaignDetailPage(id: campaign['id'])));
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Зураг
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    bottomLeft: Radius.circular(16),
                  ),
                  child:
                      campaign['imageUrl'] != null &&
                              campaign['imageUrl'].startsWith('http')
                          ? Image.network(
                            campaign['imageUrl'],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (context, error, stackTrace) => Container(
                                  width: 100,
                                  height: 100,
                                  color: Colors.grey[300],
                                  child: Icon(
                                    Icons.image,
                                    color: Colors.grey[500],
                                  ),
                                ),
                          )
                          : Container(
                            width: 100,
                            height: 100,
                            color: Colors.grey[300],
                            child: Icon(Icons.image, color: Colors.grey[500]),
                          ),
                ),

                // Мэдээлэл
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          campaign['title'] ?? 'Нэргүй аян',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text(
                              campaign['currentAmount'] ?? '0 ₮',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                            Text(
                              ' / ${campaign['targetAmount'] ?? '0 ₮'}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Үлдсэн хугацаа: ${campaign['timeLeft'] ?? 'Тодорхойгүй'}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void performSearch(String query) {
    setState(() {
      isSearching = true;
    });

    // API хүсэлт явуулах эсвэл дотоодын өгөгдлөөс хайлт хийх
    // Энд API хүсэлт илгээх код бичнэ, жишээнд туршилтын өгөгдөл ашиглая
    Future.delayed(const Duration(seconds: 1), () {
      // Хайлтын үр дүнгийн жишээ
      // final results = [
      //   // Яаралтай хандивын аянуудаас хайх
      //   ...urgentCampaigns.where(
      //     (campaign) => campaign['title'].toString().toLowerCase().contains(
      //       query.toLowerCase(),
      //     ),
      //   ),

      //   // Онцлох хандивын аянуудаас хайх
      //   ...featuredCampaigns.where(
      //     (campaign) => campaign['title'].toString().toLowerCase().contains(
      //       query.toLowerCase(),
      //     ),
      //   ),
      // ];

      setState(() {
        // searchResults = results;
        isSearching = false;
      });
    });
  }
}
