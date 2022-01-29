import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';

class NonYoutubeVideo extends StatefulWidget {
  final String link;

  const NonYoutubeVideo({Key? key, required this.link}) : super(key: key);

  @override
  _NonYoutubeVideoState createState() => _NonYoutubeVideoState();
}

class _NonYoutubeVideoState extends State<NonYoutubeVideo> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.link)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Center(
        child: _controller!.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              )
            : Container(),
      ),
      IconButton(
        onPressed: () {
          setState(() {
            _controller!.value.isPlaying
                ? _controller!.pause()
                : _controller!.play();
          });
        },
        icon: Icon(
          _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }
}
