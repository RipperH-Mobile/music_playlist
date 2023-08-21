import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

import '../icon/asset_audio_player_icons.dart';

class PlayingControlsSmall extends StatelessWidget {
  final bool isPlaying;
  final LoopMode loopMode;
  final Function() onPlay;
  final Function()? onStop;
  final Function()? toggleLoop;

  PlayingControlsSmall({
    required this.isPlaying,
    required this.loopMode,
    this.toggleLoop,
    required this.onPlay,
    this.onStop,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        NeumorphicRadio(
          style: const NeumorphicRadioStyle(
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(12),
          value: LoopMode.playlist,
          groupValue: loopMode,
          onChanged: (newValue) {
            if (toggleLoop != null) toggleLoop!();
          },
          child: const Icon(
            Icons.loop,
            size: 18,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        NeumorphicButton(
          style: const NeumorphicStyle(
            boxShape: NeumorphicBoxShape.circle(),
          ),
          padding: const EdgeInsets.all(16),
          onPressed: onPlay,
          child: Icon(
            isPlaying
                ? Icons.pause
                : Icons.play_arrow_outlined,
            size: 32,
          ),
        ),
        if (onStop != null)
          NeumorphicButton(
            style: const NeumorphicStyle(
              boxShape: NeumorphicBoxShape.circle(),
            ),
            padding: const EdgeInsets.all(16),
            onPressed: onPlay,
            child: const Icon(
              Icons.stop,
              size: 32,
            ),
          ),
      ],
    );
  }
}
