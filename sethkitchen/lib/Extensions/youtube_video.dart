import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubeAppDemo extends StatefulWidget {
  final String youtubeId;

  const YoutubeAppDemo({Key? key, required this.youtubeId}) : super(key: key);

  @override
  _YoutubeAppDemoState createState() => _YoutubeAppDemoState();
}

class _YoutubeAppDemoState extends State<YoutubeAppDemo> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      params: const YoutubePlayerParams(
        mute: false,
        autoPlay: true,
        loop: false,
        enableCaption: true,
      ),
    );
    _controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    };
    _controller.onExitFullscreen = () {
    };
  }

  @override
  Widget build(BuildContext context) {
    const player = YoutubePlayerIFrame();
    return YoutubePlayerControllerProvider(
      // Passing controller to widgets below.
      controller: _controller,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            children: const [
              player
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}

class Controls extends StatelessWidget {
  const Controls(key):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _space,
          PlayPauseButtonBar(),
          _space,
          VolumeSlider(),
        ],
      ),
    );
  }

  Widget get _space => const SizedBox(height: 10);
}

class MetaDataSection extends StatelessWidget {

  const MetaDataSection(key):super(key:key);

  @override
  Widget build(BuildContext context) {
    return YoutubeValueBuilder(builder: (context, value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Text('Title', value.metaData.title),
          const SizedBox(height: 10),
          _Text('Channel', value.metaData.author),
          const SizedBox(height: 10),
          _Text(
            'Playback Quality',
            value.playbackQuality ?? '',
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _Text('Video Id', value.metaData.videoId),
              const Spacer(),
              const _Text(
                'Speed',
                '',
              ),
              YoutubeValueBuilder(
                builder: (context, value) {
                  return DropdownButton(
                    value: value.playbackRate,
                    isDense: true,
                    underline: const SizedBox(),
                    items: PlaybackRate.all
                        .map(
                          (rate) => DropdownMenuItem(
                        child: Text(
                          '${rate}x',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        value: rate,
                      ),
                    )
                        .toList(),
                    onChanged: (double? newValue) {
                      if (newValue != null) {
                        context.ytController.setPlaybackRate(newValue);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}

class _Text extends StatelessWidget {
  final String title;
  final String value;

  const _Text(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: value,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}

class PlayPauseButtonBar extends StatelessWidget {
  final ValueNotifier<bool> _isMuted = ValueNotifier(false);

  PlayPauseButtonBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        /*IconButton(
          icon: const Icon(Icons.skip_previous),
          onPressed: context.ytController.previousVideo,
        ),*/
        YoutubeValueBuilder(
          builder: (context, value) {
            return IconButton(
              icon: Icon(
                value.playerState == PlayerState.playing
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
              onPressed: value.isReady
                  ? () {
                value.playerState == PlayerState.playing
                    ? context.ytController.pause()
                    : context.ytController.play();
              }
                  : null,
            );
          },
        ),
        ValueListenableBuilder<bool>(
          valueListenable: _isMuted,
          builder: (context, isMuted, _) {
            return IconButton(
              icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
              onPressed: () {
                _isMuted.value = !isMuted;
                isMuted
                    ? context.ytController.unMute()
                    : context.ytController.mute();
              },
            );
          },
        ),
        /*IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: context.ytController.nextVideo,
        ),*/
      ],
    );
  }
}

class PlayerStateSection extends StatelessWidget {
  const PlayerStateSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return YoutubeValueBuilder(
      builder: (context, value) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: _getStateColor(value.playerState),
          ),
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            value.playerState.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  Color _getStateColor(PlayerState state) {
    switch (state) {
      case PlayerState.unknown:
        return Colors.grey[700]!;
      case PlayerState.unStarted:
        return Colors.pink;
      case PlayerState.ended:
        return Colors.red;
      case PlayerState.playing:
        return Colors.blueAccent;
      case PlayerState.paused:
        return Colors.orange;
      case PlayerState.buffering:
        return Colors.yellow;
      case PlayerState.cued:
        return Colors.blue[900]!;
      default:
        return Colors.blue;
    }
  }
}

///
class SourceInputSection extends StatefulWidget {
  const SourceInputSection({Key? key}) : super(key: key);

  @override
  _SourceInputSectionState createState() => _SourceInputSectionState();
}

class _SourceInputSectionState extends State<SourceInputSection> {
  late TextEditingController _textController;
  String? _playlistType;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubeValueBuilder(
      builder: (context, value) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              isExpanded: true,
              hint: Text(
                ' -- Choose playlist type',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              value: _playlistType,
              items: PlaylistType.all
                  .map(
                    (type) => DropdownMenuItem(
                  child: Text(
                    type,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  value: type,
                ),
              )
                  .toList(),
              onChanged: (value) {
                _playlistType = value;
                setState(() {});
              },
            ),
            const SizedBox(height: 10),
            TextField(
              enabled: value.isReady,
              controller: _textController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: _hint,
                helperText: _helperText,
                fillColor: Theme.of(context).primaryColor.withAlpha(20),
                filled: true,
                hintStyle: TextStyle(
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).primaryColor,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => _textController.clear(),
                ),
              ),
            ),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              childAspectRatio: 20 / 6,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: [
                _Button(
                  action: 'LOAD',
                  onTap: () {
                    context.ytController
                        .load(_cleanId(_textController.text) ?? '');
                  },
                ),
                _Button(
                  action: 'CUE',
                  onTap: () {
                    context.ytController
                        .cue(_cleanId(_textController.text) ?? '');
                  },
                ),
                _Button(
                  action: 'LOAD PLAYLIST',
                  onTap: _playlistType == null
                      ? null
                      : () {
                    context.ytController.loadPlaylist(
                      _textController.text,
                      listType: _playlistType!,
                    );
                  },
                ),
                _Button(
                  action: 'CUE PLAYLIST',
                  onTap: _playlistType == null
                      ? null
                      : () {
                    context.ytController.cuePlaylist(
                      _textController.text,
                      listType: _playlistType!,
                    );
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String? get _helperText {
    switch (_playlistType) {
      case PlaylistType.search:
        return '"avengers trailer", "nepali songs"';
      case PlaylistType.playlist:
        return '"PLj0L3ZL0ijTdhFSueRKK-mLFAtDuvzdje", ...';
      case PlaylistType.channel:
        return '"pewdiepie", "tseries"';
    }
    return null;
  }

  String get _hint {
    switch (_playlistType) {
      case PlaylistType.search:
        return 'Enter keywords to search';
      case PlaylistType.playlist:
        return 'Enter playlist id';
      case PlaylistType.channel:
        return 'Enter channel name';
    }
    return 'Enter youtube <video id> or <link>';
  }

  String? _cleanId(String source) {
    if (source.startsWith('http://') || source.startsWith('https://')) {
      return YoutubePlayerController.convertUrlToId(source);
    } else if (source.length != 11) {
      _showSnackBar('Invalid Source');
    }
    return source;
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}

class _Button extends StatelessWidget {
  final VoidCallback? onTap;
  final String action;

  const _Button({
    Key? key,
    required this.onTap,
    required this.action,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Theme.of(context).primaryColor,
      onPressed: onTap == null
          ? null
          : () {
        onTap?.call();
        FocusScope.of(context).unfocus();
      },
      disabledColor: Colors.grey,
      disabledTextColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Text(
          action,
          style: const TextStyle(
            fontSize: 18.0,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class VolumeSlider extends StatelessWidget {
  final _volume = ValueNotifier<int>(100);

  VolumeSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const Text(
          "Volume",
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        Expanded(
          child: ValueListenableBuilder<int>(
            valueListenable: _volume,
            builder: (context, volume, _) {
              return Slider(
                inactiveColor: Colors.transparent,
                value: volume.toDouble(),
                min: 0.0,
                max: 100.0,
                divisions: 10,
                label: '$volume',
                onChanged: (value) {
                  _volume.value = value.round();
                  context.ytController.setVolume(volume);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}