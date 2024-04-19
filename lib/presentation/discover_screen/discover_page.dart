import 'package:flutter/material.dart'; // Ensure this contains all needed paths

class DiscoverPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(50),
          ),
        ),
        title: Center(
          child: Text(
            "TogyzQumalaq Rules",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              color: Colors.white,
              decoration: TextDecoration.none,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        backgroundColor: Color(0xFFC57941),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: "Board"),
            SizedBox(height: 5),
            Text(
              "In the game Togyz Kumalak, a special board is used with two rows of small pits (nine in each row) and two larger pits called 'kazans'.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black,
                decoration: TextDecoration.none,
                fontFamily: 'Poppins',
              ),
            ),
            //SizedBox(height: 10),
            //Image.asset('assets/images/board_image.jpg'), // Replace with actual image path
            SizedBox(height: 20),

            SectionHeader(title: "Objective of the Game"),
            SizedBox(height: 5),
            Text(
              "A player wins the game if they collect more than 81 stones in their kazan than the opponent does in theirs.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black,
                decoration: TextDecoration.none,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 20),

            SectionHeader(title: "Gameplay"),
            SizedBox(height: 5),
            GameplayBullet(
                point:
                    "Players take turns removing stones from one of the pits."),
            GameplayBullet(
                point:
                    "If a pit contains more than one stone, the first removed stone is placed back into the same pit."),
            GameplayBullet(
                point:
                    "Stones are distributed counter-clockwise, with specific rules for capturing stones."),
            //SizedBox(height: 10),
            //Image.asset('assets/images/gameplay_image.jpg'), // Replace with actual image path
            SizedBox(height: 20),

            Text(
              "Note: The last pit on the opponent's side (the far right) cannot be turned into a 'tuzdiq'.",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black,
                decoration: TextDecoration.none,
                fontFamily: 'Poppins',
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;

  SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        color: Color(0xFFC57941),
        fontSize: 25,
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none,
        fontFamily: 'Poppins',
      ),
    );
  }
}

class GameplayBullet extends StatelessWidget {
  final String point;

  GameplayBullet({required this.point});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("• ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Expanded(
          child: Text(
            point,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.black,
              decoration: TextDecoration.none,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }
}
