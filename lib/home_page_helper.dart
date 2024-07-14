import 'package:flutter/material.dart';

class HomePageHelper {
  static Widget buildScoreBoardItem({
    required String teamName,
    required int teamScore,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          teamName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          teamScore.toString(),
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  static Widget buildClearScoreBoardButton({
    required BuildContext context,
    required VoidCallback clearScoreBoard,
  }) {
    return ElevatedButton(
      onPressed: clearScoreBoard,
      child: Text(
        "Clear Score Board",
        style: TextStyle(
          color: Colors.white,
          fontSize: 0.05 * MediaQuery.sizeOf(context).width,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.lightBlue),
        minimumSize: WidgetStateProperty.all<Size>(Size.infinite),
      ),
    );
  }
}
