import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nurmukhammed_s_application4/core/app_export.dart';
import 'drawPage.dart';
import 'winnerPage.dart';

class TogyzQumalaqOnlineGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Properly initializing the board with necessary parameters
    return Scaffold(
      body: TogyzQumalaqBoard(), // Ensure this widget is set up correctly
    );
  }
}

class TogyzKumalakAI {
  int playerNumber;
  int maxDepth;

  TogyzKumalakAI(this.playerNumber, [this.maxDepth = 3]);

  int findBestMove(_TogyzQumalaqBoardState currentGame) {
    int bestMove = 0;
    int bestValue = -999999999;

    for (var move in currentGame.getLegalMoves()) {
      currentGame.makeMove(move);
      var moveValue = minimax(currentGame, 0, false);
      currentGame.undoMove();

      if (moveValue > bestValue) {
        bestValue = moveValue;
        bestMove = move;
      }
    }

    return bestMove;
  }

  int minimax(
      _TogyzQumalaqBoardState currentGame, int depth, bool isMaximizingPlayer) {
    currentGame.checkMoves();
    if (depth == maxDepth) {
      return evaluateGameState(currentGame);
    }

    if (isMaximizingPlayer) {
      int maxEval = -999999999;
      for (var move in currentGame.getLegalMoves()) {
        currentGame.makeMove(move);
        var eval = minimax(currentGame, depth + 1, false);
        currentGame.undoMove();
        maxEval = max(maxEval, eval);
      }
      return maxEval;
    } else {
      int minEval = 999999999;
      for (var move in currentGame.getLegalMoves()) {
        currentGame.makeMove(move);
        var eval = minimax(currentGame, depth + 1, true);
        currentGame.undoMove();
        minEval = min(minEval, eval);
      }
      return minEval;
    }
  }

  int evaluateGameState(_TogyzQumalaqBoardState currentGame) {
    int score;

    // Basic evaluation based on Kazan
    if (currentGame.currentPlayer == 0) {
      score = -(currentGame.kazanPlayer[1] - currentGame.kazanPlayer[0]);
    } else {
      score = currentGame.kazanPlayer[1] - currentGame.kazanPlayer[0];
    }

    // Additional scoring for Tuzdyq control
    int tuzdyqValue =
        10; // Adjust this value based on the strategic value of Tuzdyq
    for (int player in [0, 1]) {
      if (currentGame.tuzdyq[player] != -1) {
        if (currentGame.currentPlayer == player) {
          score += tuzdyqValue;
        } else {
          score -= tuzdyqValue;
        }
      }
    }
    return score;
  }
}

class ScoreContainer extends StatelessWidget {
  final String title;
  const ScoreContainer({
    Key? key,
    required this.title,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      padding: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border(
            left: BorderSide(color: Colors.black, width: 1),
            right: BorderSide(color: Colors.black, width: 1),
            top: BorderSide(color: Colors.black, width: 1),
            bottom: BorderSide(color: Colors.black, width: 1)),
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.normal,
          decoration: TextDecoration.none,
          fontFamily: 'Poppins',
        ),
      ),
    );
  }
}

class ScoreRow extends StatelessWidget {
  final int score1;
  final int score2;
  const ScoreRow({
    Key? key,
    required this.score1,
    required this.score2,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ScoreContainer(title: score1.toString()),
        SizedBox(
            width: 20,
            child: Text(':',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  decoration: TextDecoration.none,
                  fontFamily: 'Poppins',
                ))),
        ScoreContainer(title: score2.toString()),
      ],
    );
  }
}

class MenuButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(255, 247, 202, 111).withOpacity(0.7),
        side: BorderSide(
            color: Color(0xFFC57941), width: 2), // Border color and width
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(25), // Adjust the corner radius if needed
        ),
        //maximumSize: Size(40, 30),
      ),
      onPressed: () {
        // Your logic here
      },
      child: FittedBox(
        child: Text(
          'Main Menu',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.none,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}

class TogyzQumalaqBoard extends StatefulWidget {
  @override
  _TogyzQumalaqBoardState createState() => _TogyzQumalaqBoardState();
}

class _TogyzQumalaqBoardState extends State<TogyzQumalaqBoard> {
  void showCustomDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.grey.withOpacity(0.40),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Wrap(
            children: [
              Container(
                width: MediaQuery.of(buildContext).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border(
                        left: BorderSide(color: Color(0xFFC57941), width: 2),
                        right: BorderSide(color: Color(0xFFC57941), width: 2),
                        top: BorderSide(color: Color(0xFFC57941), width: 2),
                        bottom:
                            BorderSide(color: Color(0xFFC57941), width: 2))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'You Won!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.fill
                          ..color = Colors.green,
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ScoreRow(score1: kazanPlayer[0], score2: kazanPlayer[1]),
                    SizedBox(height: 28),
                    //MenuButton(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.landingScreenContainerScreen,
                            (route) => false);
                      },
                      child: SizedBox(
                        height: 50.v,
                        width: 200.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 50.v,
                                width: 190.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.h),
                                  gradient: LinearGradient(
                                    begin: Alignment(-0.5, 0.5),
                                    end: Alignment(0.5, 1.5),
                                    colors: [
                                      appTheme.orange200,
                                      appTheme.red300,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Main Menu",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showCustomLoseDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.grey.withOpacity(0.40),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Wrap(
            children: [
              Container(
                width: MediaQuery.of(buildContext).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border(
                        left: BorderSide(color: Color(0xFFC57941), width: 2),
                        right: BorderSide(color: Color(0xFFC57941), width: 2),
                        top: BorderSide(color: Color(0xFFC57941), width: 2),
                        bottom:
                            BorderSide(color: Color(0xFFC57941), width: 2))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'You Lost',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.fill
                          ..color = Colors.red,
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ScoreRow(score1: kazanPlayer[0], score2: kazanPlayer[1]),
                    SizedBox(height: 28),
                    //MenuButton(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.landingScreenContainerScreen,
                            (route) => false);
                      },
                      child: SizedBox(
                        height: 50.v,
                        width: 200.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 50.v,
                                width: 190.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.h),
                                  gradient: LinearGradient(
                                    begin: Alignment(-0.5, 0.5),
                                    end: Alignment(0.5, 1.5),
                                    colors: [
                                      appTheme.orange200,
                                      appTheme.red300,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Main Menu",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void showCustomDrawDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.grey.withOpacity(0.40),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return Center(
          child: Wrap(
            children: [
              Container(
                width: MediaQuery.of(buildContext).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border(
                        left: BorderSide(color: Color(0xFFC57941), width: 2),
                        right: BorderSide(color: Color(0xFFC57941), width: 2),
                        top: BorderSide(color: Color(0xFFC57941), width: 2),
                        bottom:
                            BorderSide(color: Color(0xFFC57941), width: 2))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      'Draw',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..style = PaintingStyle.fill
                          ..color = Colors.grey,
                        decoration: TextDecoration.none,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    ScoreRow(score1: kazanPlayer[0], score2: kazanPlayer[1]),
                    SizedBox(height: 28),
                    //MenuButton(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            AppRoutes.landingScreenContainerScreen,
                            (route) => false);
                      },
                      child: SizedBox(
                        height: 50.v,
                        width: 200.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                height: 50.v,
                                width: 190.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.h),
                                  gradient: LinearGradient(
                                    begin: Alignment(-0.5, 0.5),
                                    end: Alignment(0.5, 1.5),
                                    colors: [
                                      appTheme.orange200,
                                      appTheme.red300,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Main Menu",
                                textAlign: TextAlign.center,
                                style: theme.textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      // Reset all game-related variables to their initial state
      pitsPlayer = List.generate(2, (index) => List.generate(9, (index) => 9));
      kazanPlayer = List.generate(2, (index) => 0);
      currentPlayer = 0;
      tuzdyq = List.generate(2, (index) => -1);
    });
  }

  void gameEnd() {
    String winnerName;
    if (kazanPlayer[0] > kazanPlayer[1]) {
      showCustomDialog(context);
    } else if (kazanPlayer[0] < kazanPlayer[1]) {
      showCustomLoseDialog(context);
    } else {
      showCustomDrawDialog(context);
    }
  }

  void checkMoves() {
    bool end = true;
    for (int i = 0; i < 9; i++) {
      if (pitsPlayer[currentPlayer][i] > 0) end = false;
    }
    if (end == true) {
      kazanPlayer[(currentPlayer + 1) % 2] += (162 -
          kazanPlayer[currentPlayer] -
          kazanPlayer[(currentPlayer + 1) % 2]);
      gameEnd();
    }
  }

  List<int> getLegalMoves() {
    List<int> legalMoves = [];
    for (int i = 0; i < 9; i++) {
      if (pitsPlayer[1][i] != 0) {
        legalMoves.add(i);
      }
    }
    return legalMoves;
  }

  Map<String, dynamic> saveState() {
    return {
      'pits': List<List<int>>.from(
          pitsPlayer.map((playerPits) => List<int>.from(playerPits))),
      'kazan': List<int>.from(kazanPlayer),
      'tuzdyq': List<int>.from(tuzdyq),
      'currentPlayer': currentPlayer,
    };
  }

  void undoMove() {
    if (history == List.empty()) {
      return;
    }
    Map<String, dynamic> last_state = history.removeLast();

    setState(() {
      pitsPlayer = last_state['pits'];
      kazanPlayer = last_state['kazan'];
      tuzdyq = last_state['tuzdyq'];
      currentPlayer = last_state['currentPlayer'];
    });
  }

  Map<String, dynamic> makeMove(int pitIndex) {
    // Implement game logic here
    // Update pits, kazans, and currentPlayer accordingly
    checkMoves();

    Map<String, dynamic> state_before_move = saveState();

    history.add(state_before_move);

    int temp = pitsPlayer[currentPlayer][pitIndex];
    int tempPlayer = currentPlayer;
    pitsPlayer[tempPlayer][pitIndex] = 0;
    if (temp == 1) {
      if (pitIndex == 8) {
        if (tuzdyq[(currentPlayer + 1) % 2] == 0) {
          kazanPlayer[currentPlayer]++;
        } else {
          pitsPlayer[(currentPlayer + 1) % 2][0]++;
          tempPlayer = (currentPlayer + 1) % 2;
          pitIndex = 0;
        }
      } else {
        if (tuzdyq[currentPlayer] == pitIndex + 1)
          kazanPlayer[(currentPlayer + 1) % 2]++;
        else {
          pitsPlayer[currentPlayer][pitIndex + 1]++;
          pitIndex++;
        }
      }
      temp = 0;
    }
    while (temp > 0) {
      if (pitIndex == 9) {
        tempPlayer = (tempPlayer + 1) % 2;
        pitIndex %= 9;
      }
      if (pitIndex == tuzdyq[tempPlayer]) {
        kazanPlayer[(tempPlayer + 1) % 2]++;
        temp--;
        if (temp > 0) pitIndex++;
        continue;
      }
      pitsPlayer[tempPlayer][pitIndex]++;
      temp--;
      if (temp == 0) continue;
      pitIndex++;
    }
    if (tempPlayer != currentPlayer) {
      if (pitsPlayer[tempPlayer][pitIndex] == 3 &&
          pitIndex != 8 &&
          tuzdyq[(tempPlayer + 1) % 2] != pitIndex &&
          tuzdyq[tempPlayer] == -1) {
        tuzdyq[tempPlayer] = pitIndex;
        kazanPlayer[currentPlayer] += pitsPlayer[tempPlayer][pitIndex];
        pitsPlayer[tempPlayer][pitIndex] = 0;
      } else if (pitsPlayer[tempPlayer][pitIndex] % 2 == 0) {
        kazanPlayer[currentPlayer] += pitsPlayer[tempPlayer][pitIndex];
        pitsPlayer[tempPlayer][pitIndex] = 0;
      }
    }
    return state_before_move;
  }

// Define a new widget list
  List<Widget> ballColumns = [];

  List<List<int>> pitsPlayer =
      List.generate(2, (index) => List.generate(9, (index) => 9));
  List<int> kazanPlayer = List.generate(2, (index) => 0);
  int currentPlayer = 0;
  List<int> tuzdyq = List.generate(2, (index) => -1);

  List<Map<String, dynamic>> history = [];

  TogyzKumalakAI gameAI = TogyzKumalakAI(1, 0);

// Now, 'ballColumns' contains 9 elements, the last one being a single ball

  List<Widget> generateLeftContainers(int index) {
    return [
      Container(
        height: 50.v,
        width: 115.h,
        margin: EdgeInsets.only(left: 5.h, top: 11.v),
        decoration: BoxDecoration(
          color: appTheme.black901.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2.h),
            topRight: Radius.circular(15.h),
            bottomLeft: Radius.circular(15.h),
            bottomRight: Radius.circular(15.h),
          ),
          image: DecorationImage(
            image: tuzdyq[0] != index
                ? AssetImage(ImageConstant.imgEmpty)
                : AssetImage(ImageConstant.imgOyu),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: List.generate(
                      min(pitsPlayer[0][index] ~/ 2 + pitsPlayer[0][index] % 2,
                          5), // Use pitsPlayer data here based on 'i'
                      (index) => CustomImageView(
                            imagePath: ImageConstant.imgBall,
                            height: 16.v,
                            width: 16.h,
                            margin: EdgeInsets.only(top: 7.v, left: 2.h),
                          )),
                ),
                // Assuming the second row also depends on 'i' or another condition
                Row(
                  children: List.generate(
                      min(
                          5,
                          pitsPlayer[0][index] ~/
                              2), // Adjust based on your requirement
                      (index) => CustomImageView(
                            imagePath: ImageConstant.imgBall,
                            height: 16.v,
                            width: 16.h,
                            margin: EdgeInsets.only(top: 5.v, left: 2.h),
                          )),
                ),
              ],
            ),
            Positioned(
              // Use Positioned to place the text inside the Stack
              top: 25.v, // Adjust these values based on where you want the text
              right: 5.h,
              child: Text(
                '${pitsPlayer[0][index]}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.v, // Adjust font size as needed
                ),
              ),
            ),
          ],
        ),
      ),
      // Add more containers if needed
    ];
  }

  List<Widget> generateRightContainers(int index) {
    return [
      Container(
        height: 50.v,
        width: 115.h,
        margin: EdgeInsets.only(left: 5.h, top: 11.v),
        decoration: BoxDecoration(
          color: appTheme.black901.withOpacity(0.1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(2.h),
            topRight: Radius.circular(15.h),
            bottomLeft: Radius.circular(15.h),
            bottomRight: Radius.circular(15.h),
          ),
          image: DecorationImage(
            image: tuzdyq[1] != index
                ? AssetImage(ImageConstant.imgEmpty)
                : AssetImage(ImageConstant.imgOyu),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: List.generate(
                      min(pitsPlayer[1][index] ~/ 2 + pitsPlayer[1][index] % 2,
                          5), // Use pitsPlayer data here based on 'i'
                      (index) => CustomImageView(
                            imagePath: ImageConstant.imgBall,
                            height: 16.v,
                            width: 16.h,
                            margin: EdgeInsets.only(top: 7.v, left: 2.h),
                          )),
                ),
                // Assuming the second row also depends on 'i' or another condition
                Row(
                  children: List.generate(
                      min(
                          5,
                          pitsPlayer[1][index] ~/
                              2), // Adjust based on your requirement
                      (index) => CustomImageView(
                            imagePath: ImageConstant.imgBall,
                            height: 16.v,
                            width: 16.h,
                            margin: EdgeInsets.only(top: 5.v, left: 2.h),
                          )),
                ),
              ],
            ),
            Positioned(
              // Use Positioned to place the text inside the Stack
              top: 25.v, // Adjust these values based on where you want the text
              right: 5.h,
              child: Text(
                '${pitsPlayer[1][index]}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.v, // Adjust font size as needed
                ),
              ),
            ),
          ],
        ),
      ),
      // Add more containers if needed
    ];
  }

  Future<bool> _showExitConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Confirm Exit'),
            content: Text('Are you sure you want to surrender?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.landingScreenContainerScreen, (route) => false);
                },
                child: Text('Confirm'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text('Cancel'),
              ),
            ],
          ),
        ) ??
        false;
  }

  final storage = FlutterSecureStorage();
  // Define a function to retrieve the username asynchronously
  Future<Map<String, String?>> getUserData() async {
    // Retrieve user data from storage
    String? id = await storage.read(key: 'userId');
    String? username = await storage.read(key: 'username');
    String? firstName = await storage.read(key: 'firstName');
    String? lastName = await storage.read(key: 'lastName');
    String? userImg = await storage.read(key: 'image');

    // Return the user data as a map
    return {
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'image': userImg,
    };
  }

// Somewhere in your widget's build method or before building the widget
  String? userId;
  String? username;
  String? firstName;
  String? lastName;
  String? userImg;
  String defaultImg = 'http://192.168.0.117/media/users/no-user.png';
  String fakeImg = 'http://192.168.0.117/media/users/3.jpg';

  @override
  Widget build(BuildContext context) {
    getUserData().then((value) {
      setState(() {
        userId = value['id'];
        username = value['username'];
        firstName = value['firstName'];
        lastName = value['lastName'];
        userImg = value['image'];
      });
    });
    return WillPopScope(
      onWillPop: () async {
        return await _showExitConfirmationDialog(context);
      },
      child: Scaffold(
        backgroundColor: Color(0XFFC57941),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            child: SizedBox(
              height: 872.v,
              width: double.maxFinite,
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgRectangle556,
                    height: 545.v,
                    width: SizeUtils.width,
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 0.v),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: CustomImageView(
                      imagePath: ImageConstant.imgEllipse1,
                      height: 380.v,
                      width: SizeUtils.width,
                      alignment: Alignment.bottomRight,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      height: 735.v,
                      width: double.maxFinite,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Opacity(
                            opacity: 0.5,
                            child: CustomImageView(
                              imagePath: ImageConstant.imgEllipse2,
                              height: 380.v,
                              width: 270.h,
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.only(top: 5.v),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 0,
                              margin: EdgeInsets.all(0),
                              color: appTheme.whiteA700.withOpacity(0.16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusStyle.roundedBorder16,
                              ),
                              child: Container(
                                height: 584.v,
                                width: double.maxFinite,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 1.h,
                                  vertical: 10.v,
                                ),
                                decoration: AppDecoration.fillWhiteA1.copyWith(
                                  borderRadius:
                                      BorderRadiusStyle.roundedBorder16,
                                ),
                                child: Stack(
                                  alignment: Alignment.centerLeft,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Container(
                                        height: 525.v,
                                        width: 52.h,
                                        margin: EdgeInsets.only(right: 145.h),
                                        decoration: BoxDecoration(
                                          color: appTheme.black901
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            15.h,
                                          ),
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 7.h, top: 7.v),
                                        child: Wrap(
                                          spacing: 4
                                              .h, // Horizontal space between children
                                          runSpacing: 4
                                              .v, // Vertical space between lines
                                          children: List.generate(
                                            kazanPlayer[
                                                1], // Assuming kazanPlayer is the total number of balls
                                            (index) => Container(
                                              height: 10
                                                  .v, // Specify the height of the ball
                                              width: 10
                                                  .h, // Specify the width of the ball
                                              child: CustomImageView(
                                                imagePath:
                                                    ImageConstant.imgBall,
                                                // If CustomImageView has its own padding or margin, adjust them as needed
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        height: 525.v,
                                        width: 52.h,
                                        margin: EdgeInsets.only(left: 150.h),
                                        decoration: BoxDecoration(
                                          color: appTheme.black901
                                              .withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            15.h,
                                          ),
                                        ),
                                        padding: EdgeInsets.only(
                                            left: 7.h, top: 7.v),
                                        child: Wrap(
                                          spacing: 4
                                              .h, // Horizontal space between children
                                          runSpacing: 4
                                              .v, // Vertical space between lines
                                          children: List.generate(
                                            kazanPlayer[
                                                0], // Assuming kazanPlayer is the total number of balls
                                            (index) => Container(
                                              height: 10
                                                  .v, // Specify the height of the ball
                                              width: 10
                                                  .h, // Specify the width of the ball
                                              child: CustomImageView(
                                                imagePath:
                                                    ImageConstant.imgBall,
                                                // If CustomImageView has its own padding or margin, adjust them as needed
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        for (int i = 0; i < 9; i++)
                                          GestureDetector(
                                            onTap: () {
                                              //showCustomDialog(
                                              //  context); //HERERERERW
                                              if (currentPlayer == 0 &&
                                                  pitsPlayer[currentPlayer][i] >
                                                      0) {
                                                // makeMove(i);
                                                Map<String, dynamic>
                                                    state_before_move =
                                                    makeMove(i);
                                                List<int> kazan =
                                                    state_before_move['kazan'];
                                                List<int> tuzdyq =
                                                    state_before_move['tuzdyq'];
                                                List<List<int>> pits =
                                                    state_before_move['pits'];
                                                // Call your game logic function
                                                // After the move, toggle the currentPlayer
                                                //showCustomDialog(
                                                //  context); //HERERERERW
                                                if (kazanPlayer[0] > 81 ||
                                                    kazanPlayer[1] > 81)
                                                  gameEnd();
                                                setState(() {
                                                  currentPlayer =
                                                      (currentPlayer + 1) % 2;
                                                  Future.delayed(
                                                      Duration(
                                                          milliseconds: 6000),
                                                      () {
                                                    Map<String, dynamic>
                                                        state_before_move =
                                                        makeMove(
                                                            gameAI.findBestMove(
                                                                this));
                                                    List<int> kazan =
                                                        state_before_move[
                                                            'kazan'];
                                                    List<int> tuzdyq =
                                                        state_before_move[
                                                            'tuzdyq'];
                                                    List<List<int>> pits =
                                                        state_before_move[
                                                            'pits'];
                                                    currentPlayer =
                                                        (currentPlayer + 1) % 2;
                                                  });
                                                });
                                              } else
                                                checkMoves();
                                            },
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children:
                                                    generateLeftContainers(i),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        for (int i = 8; i >= 0; i--)
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children:
                                                  generateRightContainers(i),
                                            ),
                                          ),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 120.h,
                                        top: 16.v,
                                        right: 260.h,
                                      ),
                                      child: _buildNumbersTwo(
                                        context,
                                        nine: "1",
                                        eight: "2",
                                        seven: "3",
                                        six: "4",
                                        five: "5",
                                        four: "6",
                                        three: "7",
                                        two: "8",
                                        one: "9",
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 300.h,
                                        bottom: 17.v,
                                      ),
                                      child: _buildNumbersTwo(
                                        context,
                                        nine: "9",
                                        eight: "8",
                                        seven: "7",
                                        six: "6",
                                        five: "5",
                                        four: "4",
                                        three: "3",
                                        two: "2",
                                        one: "1",
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topCenter,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 173.h),
                                                child: Text(
                                                  kazanPlayer[0].toString(),
                                                  style: theme
                                                      .textTheme.labelLarge,
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 75.h),
                                                child: Text(
                                                  kazanPlayer[1].toString(),
                                                  style: theme
                                                      .textTheme.labelLarge,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: 41.h,
                                right: 41.h,
                                bottom: 592.v,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildFrameThirteen(
                                    context,
                                    player: username ??
                                        "Player", // Use retrieved username
                                    levelCounter: "Level 1",
                                  ),
                                  _buildFrameThirteen(
                                    context,
                                    player: "Kenzhebek",
                                    levelCounter: "Level 1",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildNumbersTwo(
    BuildContext context, {
    required String nine,
    required String eight,
    required String seven,
    required String six,
    required String five,
    required String four,
    required String three,
    required String two,
    required String one,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          nine,
          style: theme.textTheme.bodySmall!.copyWith(
            color: appTheme.gray300,
          ),
        ),
        SizedBox(height: 50.v),
        Text(
          eight,
          style: theme.textTheme.bodySmall!.copyWith(
            color: appTheme.gray300,
          ),
        ),
        SizedBox(height: 46.v),
        Text(
          seven,
          style: theme.textTheme.bodySmall!.copyWith(
            color: appTheme.gray300,
          ),
        ),
        SizedBox(height: 46.v),
        Text(
          six,
          style: theme.textTheme.bodySmall!.copyWith(
            color: appTheme.gray300,
          ),
        ),
        SizedBox(height: 47.v),
        Text(
          five,
          style: theme.textTheme.bodySmall!.copyWith(
            color: appTheme.gray300,
          ),
        ),
        SizedBox(height: 46.v),
        Text(
          four,
          style: theme.textTheme.bodySmall!.copyWith(
            color: appTheme.gray300,
          ),
        ),
        SizedBox(height: 45.v),
        Text(
          three,
          style: theme.textTheme.bodySmall!.copyWith(
            color: appTheme.gray300,
          ),
        ),
        SizedBox(height: 46.v),
        Text(
          two,
          style: theme.textTheme.bodySmall!.copyWith(
            color: appTheme.gray300,
          ),
        ),
        SizedBox(height: 46.v),
        Text(
          one,
          style: theme.textTheme.bodySmall!.copyWith(
            color: appTheme.gray300,
          ),
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildBallCount2(
    BuildContext context, {
    required String nine,
    required String nine1,
    required String nine2,
    required String nine3,
    required String nine4,
    required String nine5,
    required String nine6,
    required String nine7,
    required String nine8,
  }) {
    return Column(
      children: [
        Text(
          nine,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelLarge!.copyWith(
            color: appTheme.black901.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 41.v),
        Text(
          nine1,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelLarge!.copyWith(
            color: appTheme.black901.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 41.v),
        Text(
          nine2,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelLarge!.copyWith(
            color: appTheme.black901.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 41.v),
        Text(
          nine3,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelLarge!.copyWith(
            color: appTheme.black901.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 42.v),
        Text(
          nine4,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelLarge!.copyWith(
            color: appTheme.black901.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 41.v),
        Text(
          nine5,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelLarge!.copyWith(
            color: appTheme.black901.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 40.v),
        Text(
          nine6,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelLarge!.copyWith(
            color: appTheme.black901.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 41.v),
        Text(
          nine7,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelLarge!.copyWith(
            color: appTheme.black901.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 41.v),
        Text(
          nine8,
          textAlign: TextAlign.center,
          style: theme.textTheme.labelLarge!.copyWith(
            color: appTheme.black901.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  /// Common widget
  Widget _buildFrameThirteen(
    BuildContext context, {
    required String player,
    required String levelCounter,
  }) {
    return Column(
      children: [
        CustomImageView(
          imagePath: player == 'Kenzhebek'
              ? fakeImg
              : userImg != null
                  ? userImg
                  : defaultImg,
          height: 66.adaptSize,
          width: 66.adaptSize,
          radius: BorderRadius.circular(
            33.h,
          ),
        ),
        SizedBox(height: 4.v),
        Text(
          player,
          style: theme.textTheme.titleMedium!.copyWith(
            color: appTheme.whiteA700,
          ),
        ),
        SizedBox(height: 2.v),
        Text(
          levelCounter,
          style: CustomTextStyles.bodySmall12.copyWith(
            color: appTheme.gray300,
          ),
        ),
      ],
    );
  }
}
