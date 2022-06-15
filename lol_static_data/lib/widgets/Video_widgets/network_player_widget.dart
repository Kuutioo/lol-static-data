import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'video_player_widget.dart';

class NetworkPlayerWidget extends StatefulWidget {
  final String url;

  NetworkPlayerWidget(this.url);

  @override
  _NetworkPlayerWidgetState createState() => _NetworkPlayerWidgetState();
}

class _NetworkPlayerWidgetState extends State<NetworkPlayerWidget> {
  VideoPlayerController controller;

  @override
  void initState() {
    super.initState();

    controller = VideoPlayerController.network(widget.url)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        alignment: Alignment.center,
        child: VideoPlayerWidget(controller: controller),
      );
}
