import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../controllers/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: timer(),
          ),
          SizedBox(height: 40),
          RxBuilder(
            builder: (_) => Center(
              child: (!controller.isRunning && !controller.isStarted)
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: controller.start,
                          child: Icon(
                            Icons.play_arrow,
                            color: Theme.of(context).primaryColor,
                            size: 30,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RxBuilder(
                          builder: (_) => GestureDetector(
                            onTap: controller.pause,
                            child: Icon(
                              (controller.isRunning)
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Theme.of(context).primaryColor,
                              size: 30,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        GestureDetector(
                          onTap: controller.stop,
                          child: Icon(
                            Icons.stop,
                            color: Theme.of(context).primaryColor,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }

  Widget timer() => RxBuilder(
        builder: (_) {
          final hours = controller.hours.toString().padLeft(2, '0');
          final minutes = controller.minutes.toString().padLeft(2, '0');
          final seconds = controller.seconds.toString().padLeft(2, '0');
          return Text(
            "$hours:$minutes:$seconds",
            style: TextStyle(
              fontSize: 50,
              color: Colors.white,
            ),
          );
        },
      );
}
