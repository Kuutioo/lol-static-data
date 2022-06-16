import 'package:flutter/material.dart';
import 'package:lol_static_data/widgets/hamburger_bar.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';

import '../widgets/Video_widgets/network_player_widget.dart';

class VideoPlayerPage extends StatefulWidget {
  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
  static const routeName = 'video-player-page';
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ability Preview'),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Container(
        child: NetworkPlayerWidget(arguments),
        color: Colors.black,
      ),
    );
  }
}
