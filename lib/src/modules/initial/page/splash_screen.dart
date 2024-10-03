import 'package:fast_location_app/src/modules/home/page/home_page.dart';
import 'package:fast_location_app/src/shared/colors/app_colors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()), 
        (Route<dynamic> route) => false, 
      );
    });

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.secondaryColor),
            ),
            SizedBox(height: 20),
            Text(
              'Carregando...',
              style: TextStyle(color: AppColors.primaryColor, fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
