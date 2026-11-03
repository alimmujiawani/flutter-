import 'package:flutter/material.dart';

class Latihan3 extends StatelessWidget {
  Latihan3({super.key});

  final List<Map<String, dynamic>> galleryFilm = [
    {
      "title": "James Boggie black",
      "description": "Pariatur mollit consequat minim aliqua. Aute ex do sint sint ex do. Qui elit elit aliqua enim commodo sunt nulla cillum in deserunt laboris labore sint amet. Aliqua incididunt ex consequat consectetur exercitation enim.",
      "cover": "https://cdn.shopify.com/s/files/1/0602/9272/6979/files/s_1_of_1.jpg?v=1671532909",
      "duration": 120,
    },
    {
      "title": "James Boggie Amber",
      "description": "Pariatur mollit consequat minim aliqua. Aute ex do sint sint ex do. Qui elit elit aliqua enim commodo sunt nulla cillum in deserunt laboris labore sint amet. Aliqua incididunt ex consequat consectetur exercitation enim.",
      "cover": "https://cdn.shopify.com/s/files/1/0602/9272/6979/files/neww_1_of_2.jpg?v=1671535910&width=2000",
      "duration": 120,
    },
    {
      "title": "James Boggie Corong",
      "description": "Miliarder dan ilmuwan jenius Tony Stark menciptakan baju zirah berteknologi tinggi untuk membasmi kejahatan setelah disandera di gua.",
      "cover": "https://cdn.shopify.com/s/files/1/0602/9272/6979/files/WEB_HEADER_4.jpg?v=1660808220&width=1500",
      "duration": 126,
    },
    {
      "title": "James Boggie X Maternal Disaster",
      "description": "Identitas Spider-Man terungkap, Peter meminta bantuan Doctor Strange, namun mantranya salah dan membuka pintu dari semesta lain.",
      "cover": "https://www.maternaldisaster.com/wp-content/uploads/2025/07/1.jpg",
      "duration": 148,
    },
    {
      "title": "James Boggie ",
      "description": "Setelah kejadian tragis di Infinity War, Avengers yang tersisa berupaya kembali untuk memulihkan tindakan Thanos dan memulihkan alam semesta.",
      "cover": "https://jamesboogie.com/_next/image?url=https:%2F%2Fvps.jamesboogie.com%2Fwp-content%2Fuploads%2F2025%2F07%2FJBxMtrnl_ThumbVid_Youtube-1-of-1-scaled-1.jpg&w=3840&q=75",
      "duration": 181,
    },
    {
      "title": "Thor: Ragnarok",
      "description": "Terjebak di planet Sakaar, Thor harus berjuang dengan waktu untuk kembali ke Asgard dan menghentikan Ragnarok dari tangan Hela.",
      "cover": "https://tse4.mm.bing.net/th/id/OIP.tkCYVGyVQQeIpGOvwnxLQAHaEK?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
      "duration": 130,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              margin: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: galleryFilm.length,
                itemBuilder: (context, index) {
                  final data = galleryFilm[index];
                  return Container(
                    width: double.infinity,
                    height: 200,
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(data['cover']),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 20,
                          left: 8,
                          child: Container(
                            child: Text(
                              data['title'],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          right: 8,
                          child: Container(
                            color: Colors.black54,
                            padding: EdgeInsets.all(8),
                            child: Text(
                              data['description'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            color: Colors.black54,
                            padding: EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                            child: Text(
                              "${data['duration']} min",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(10),
              width: double.infinity,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: galleryFilm.length,
                itemBuilder: (context, index) {
                  final data = galleryFilm[index];
                  return Container(
                    width: 100,
                    margin: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(data['cover']),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        color: Colors.black54,
                        padding: EdgeInsets.all(4),
                        child: Text(
                          data['title'].toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
