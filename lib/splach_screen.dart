import 'package:flutter/material.dart';
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:workshop/tasks.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.scale(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlue,
              Colors.blue,
            ],
          ),
          childWidget: SizedBox(
            height: 1000,
            child: Image.asset("assets/catty.png"),
          ),
          duration: const Duration(milliseconds: 3000),
          animationDuration: const Duration(milliseconds: 2000),
          onAnimationEnd: () => debugPrint("On Scale End"),
          nextScreen: const Tasks(),
        );
  }
}