import 'package:flutter/material.dart';

class BelajarContainer extends StatelessWidget {
  const BelajarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: 460,
        constraints: const BoxConstraints(maxWidth: 360),
        margin: const EdgeInsets.all(20),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: const Color(0xFF15252B),
          borderRadius: BorderRadius.circular(22),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 245,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    "https://cdn.shopify.com/s/files/1/0602/9272/6979/files/neww_2_of_2.jpg?v=1671535858&width=2000",
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const ColoredBox(
                        color: Color(0xFF233940),
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFE2B879),
                          ),
                        ),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return const ColoredBox(
                        color: Color(0xFF233940),
                        child: Center(
                          child: Icon(
                            Icons.checkroom_outlined,
                            color: Color(0xFFE2B879),
                            size: 64,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xCC15252B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "BRAND STORY",
                        style: TextStyle(
                          color: Color(0xFFF1D7A7),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 17, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "JAMES BOOGIE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          color: Color(0xFFE2B879),
                          size: 16,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "FASHION PRIA  •  BANDUNG  •  2017",
                          style: TextStyle(
                            color: Color(0xFFE2B879),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.7,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Berawal dari Bandung, James Boogie menggabungkan "
                      "gaya pop military dengan inspirasi subkultur Inggris "
                      "dalam koleksi fashion pria.",
                      style: TextStyle(
                        color: Color(0xFFD3DADD),
                        fontSize: 13,
                        height: 1.45,
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
  }
}
