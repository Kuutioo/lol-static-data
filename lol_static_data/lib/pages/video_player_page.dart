import 'package:flutter/material.dart';

import '../widgets/Video_widgets/network_player_widget.dart';

class VideoPlayerPage extends StatefulWidget {
  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
  static const routeName = 'video-player-page';
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  @override
  Widget build(BuildContext context) {
    return NetworkPlayerWidget();
  }
}
