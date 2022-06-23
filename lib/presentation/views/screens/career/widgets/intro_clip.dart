import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class IntroClip extends StatefulWidget {
  final String clipId;

  const IntroClip({Key? key, required this.clipId}) : super(key: key);

  @override
  State<IntroClip> createState() => _IntroClipState();
}

class _IntroClipState extends State<IntroClip> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: widget.clipId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ));
  }

  @override
  void dispose() {
    _controller.reset();
    _controller.dispose();
    log("DISPOSE");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onEnterFullScreen: (){

      },
        onExitFullScreen: (){

        },
        player: YoutubePlayer(
          controller: _controller,

        ),
        builder: (context, player) {
          return player;
        });
  }
}
