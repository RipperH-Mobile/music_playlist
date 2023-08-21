import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../icon/asset_audio_player_icons.dart';


class PlayingControls extends StatelessWidget {
  final bool isPlaying;
  final LoopMode? loopMode;
  final bool isPlaylist;
  final Function()? onPrevious;
  final Function() onPlay;
  final Function()? onNext;
  final Function()? toggleLoop;
  final Function()? onStop;

  PlayingControls({
    required this.isPlaying,
    this.isPlaylist = false,
    this.loopMode,
    this.toggleLoop,
    this.onPrevious,
    required this.onPlay,
    this.onNext,
    this.onStop,
  });

  Widget _loopIcon(BuildContext context) {
    final iconSize = 17.0;
    if (loopMode == LoopMode.none) {
      return Icon(
        Icons.loop,
        size: iconSize,
        color: Colors.grey,
      );
    } else if (loopMode == LoopMode.playlist) {
      return Icon(
        Icons.loop,
        size: iconSize,
        color: Colors.black,
      );
    } else {
      //single
      return Stack(
        alignment: Alignment.center,
        children: [
          Icon(
            Icons.loop,
            size: iconSize,
            color: Colors.black,
          ),
          const Center(
            child: Text(
              '1',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        // GestureDetector(
        //   onTap: () {
        //     if (toggleLoop != null) toggleLoop!();
        //   },
        //   child: _loopIcon(context),
        // ),
        // const SizedBox(
        //   width: 6,
        // ),
        // NeumorphicButton(
        //   style: const NeumorphicStyle(
        //     boxShape: NeumorphicBoxShape.circle(),
        //   ),
        //   padding: const EdgeInsets.all(9),
        //   onPressed: isPlaylist ? onPrevious : null,
        //   child: const Icon(Icons.arrow_back_ios_new),
        // ),
        // const SizedBox(
        //   width: 6,
        // ),
        NeumorphicButton(
          style: const NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(12),
          onPressed: onPlay,
          child: Icon(
            isPlaying
                ? Icons.pause
                : Icons.play_arrow_outlined,
            size: 30,
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        // NeumorphicButton(
        //   style: const NeumorphicStyle(
        //     boxShape: NeumorphicBoxShape.circle(),
        //   ),
        //   padding: const EdgeInsets.all(9),
        //   onPressed: isPlaylist ? onNext : null,
        //   child: const Icon(Icons.arrow_forward_ios),
        // ),
        // const SizedBox(
        //   width: 24,
        // ),
        // if (onStop != null)
        //   NeumorphicButton(
        //     style: const NeumorphicStyle(
        //       boxShape: NeumorphicBoxShape.circle(),
        //     ),
        //     padding: const EdgeInsets.all(16),
        //     onPressed: onStop,
        //     child: const Icon(
        //       Icons.stop,
        //       size: 16,
        //     ),
        //   ),
      ],
    );
  }
}
