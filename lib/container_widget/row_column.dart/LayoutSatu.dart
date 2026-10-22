import 'package:flutter/material.dart';

class Layout1 extends StatelessWidget {
  const Layout1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 72,
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black, blurRadius: 6)],
        ),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                  "https://tse4.mm.bing.net/th/id/OIP.OZlDoofTLAYSWgjXr7oa5wHaHa?r=0&w=980&h=980&rs=1&pid=ImgDetMain&o=7&rm=3",
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Iqbaal"),
                  SizedBox(height: 4),
                  Text("kelas 12"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
