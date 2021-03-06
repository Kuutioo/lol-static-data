import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
        title: Text(AppLocalizations.of(context).abilityPreview),
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
