import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie_nest_app/theme/app_text_style.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@RoutePage(name: 'YouTubePlayerRoute')
class YouTubePlayerWidget extends StatefulWidget {
  final String youtubeKey;
  const YouTubePlayerWidget({
    super.key,
    required this.youtubeKey,
  });

  @override
  State<YouTubePlayerWidget> createState() => _YouTubePlayerWidgetState();
}

class _YouTubePlayerWidgetState extends State<YouTubePlayerWidget> {
  late final YoutubePlayerController _controller;
  Timer? _hideTimer;
  late YoutubeMetaData _videoMetaData;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        enableCaption: false,
        disableDragSeek: true,
        loop: false,
        forceHD: true,
      ),
    )..addListener(listener);
  }

  void listener() {
    if (_isPlayerReady && mounted) {
      setState(() {
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _hideTimer?.cancel();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        progressIndicatorColor: Colors.blue,
        bottomActions: [
          CurrentPosition(
            controller: _controller,
          ),
          ProgressBar(
            controller: _controller,
            isExpanded: true,
            colors: ProgressBarColors(
              playedColor: Colors.blue,
              backgroundColor: Colors.blue[300],
            ),
          ),
          RemainingDuration(
            controller: _controller,
          ),
          FullScreenButton(
            controller: _controller,
          ),
        ],
        onReady: () => _isPlayerReady = true,
        onEnded: (metaData) {
          setState(() {
            _controller.reload();
          });
        },
      ),
      builder: (context, player) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            _isPlayerReady ? _videoMetaData.title : 'Loading...',
            style: AppTextStyle.small18WhiteBoldTextStyle,
          ),
          leading: const BackButton(
            color: Colors.white,
          ),
        ),
        body: Container(
            decoration: const BoxDecoration(
              color: Colors.black,
            ),
            child: Center(
              child: player,
            )),
      ),
    );
  }
}
