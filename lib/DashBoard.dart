import 'package:flutter/material.dart';
import 'package:whatsapp_stataus_saver/video_screen.dart';

import 'image_screen.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return  TabBarView(
      children: [
        ImageScreen(),
        VideoScreen(),
      ],
    );
  }
}