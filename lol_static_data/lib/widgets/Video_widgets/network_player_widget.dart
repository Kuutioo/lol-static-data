import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(true)
      ..initialize().then((_) => controller.play());
    controller.addListener(() {
      if (controller.value.hasError) {
        print(controller.value.errorDescription);
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(AppLocalizations.of(context).error),
            content: Text(controller.value.errorDescription),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(AppLocalizations.of(context).okay),
              ),
            ],
            elevation: 24,
          ),
        );
      }
    });
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
