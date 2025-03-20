import 'package:crowdfunding_app/styles/style.dart';
import 'package:flutter/material.dart';

class CampaignDetailPage extends StatefulWidget {
  final String id;
  const CampaignDetailPage({Key? key, required this.id}) : super(key: key);
  @override
  _CampaignDetailPageState createState() => _CampaignDetailPageState();
}

class _CampaignDetailPageState extends State<CampaignDetailPage> {
  double _amount = 100.0;

  void _showDonationBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // const Text(
                  //   "Payout",
                  //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  // ),
                  // const SizedBox(height: 4),
                  // const Text(
                  //   "Pay out your balance now",
                  //   style: TextStyle(fontSize: 16, color: Colors.grey),
                  // ),
                  // const SizedBox(height: 20),
                  Row(
                    children: const [
                      Text(
                        "\$4,240,310/",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "\$8,000,000",
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Progress bar
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Stack(
                      children: [
                        LinearProgressIndicator(
                          value: ((4240310 + _amount.toInt()) / 8000000),
                          minHeight: 8,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blue[400]!,
                          ),
                        ),
                        LinearProgressIndicator(
                          value: 4240310 / 8000000,
                          minHeight: 8,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.green[400]!,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  // Amount Input Field
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _amount = double.tryParse(value) ?? 100.0;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Мөнгөн дүн (₮)",
                      prefixText: "₮ ",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Withdraw Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Хандивлах"),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Featured image with favorite icon
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 220,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/test-image.png',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.arrow_back, size: 20),
                                  onPressed: () {
                                    Navigator.pop(
                                      context,
                                    ); // This pops the current screen
                                  },
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                child: const Icon(
                                  Icons.favorite_border,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Campaign Info
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Хүүхдийн асрамжийн газрын сэргээн засах үйл ажиллагаа",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 12),

                              // Fundraising progress
                              Row(
                                children: const [
                                  Text(
                                    "\₮4,240,310/",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    "\₮8,000,000",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),

                              // Progress bar
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: 4240310 / 8000000,
                                  minHeight: 8,
                                  backgroundColor: Colors.grey[200],
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    MyColors.secondary,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Organization info
                              Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: MyColors.textPrimary,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "X",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "Гэрэл асрамжийн газар",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Icon(
                                            Icons.verified,
                                            size: 14,
                                            color: Colors.blue[500],
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "Хандивын аян үүсгэгч",
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[200],
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Text(
                                      "Зочилох",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),

                              // About section
                              const Text(
                                "Хандивын аяны дэлгэрэнгүй",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                " Улсын хэмжээнд нийт 820 гаруй хүүхэд асрамжийн төвийг гэрээ болгон амьдарч байна. Тэдний 179 нь Хүүхэд асран хүмүүжүүлэх Өнөр бүл хүүхдийн төвд бий. Асрамжийн газарт зөвхөн хагас болон бүтэн өнчин хүүхдүүд ирдэггүй. Эцэг эх нь амьд сэрүүн боловч үл хайхардаг, хүчирхийлдэг гэсэн шалтгаанаар тэнд очих хүүхэд олон байдаг. Олон талаас цугласан, өөр өөр амьдралтай хүүхдүүд нэгэн дээвэр дор гэр бүл болон амьдрах Өнөр бүл хүүхдийн төвөөс тэдэнд тулгарах нийгмийн асуудал, төгсөөд хаачдаг талаар сурвалжилга бэлтгэлээ.",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Image
                              Container(
                                width: double.infinity,
                                height: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/images/test-image.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Floating Donate Now Button in Center
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: FloatingActionButton.extended(
                backgroundColor: MyColors.primary,
                foregroundColor: Colors.white,
                onPressed: () {
                  _showDonationBottomSheet(context);
                },
                icon: const Icon(Icons.volunteer_activism),
                label: const Text(
                  "Хандив өгөх",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
