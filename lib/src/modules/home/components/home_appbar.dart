import 'package:flutter/material.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;

  HomeAppBar({Key? key})
      : preferredSize = Size.fromHeight(56.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 220, 220, 220),
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_back, color: Colors.green),
          SizedBox(width: 8.0),
          Text(
            'Fast Location App',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.green,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 8.0),
          Icon(Icons.arrow_forward, color: Colors.green),
        ],
      ),
    );
  }
}
