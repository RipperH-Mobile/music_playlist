import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

class SongsSelector extends StatelessWidget {
  final Playing? playing;
  final List<Audio> audios;
  final Function(Audio) onSelected;
  final Function(List<Audio>) onPlaylistSelected;

  SongsSelector(
      {required this.playing,
      required this.audios,
      required this.onSelected,
      required this.onPlaylistSelected});

  Widget _image(Audio item) {
    if (item.metas.image == null) {
      return const SizedBox(height: 40, width: 40);
    }

    return item.metas.image?.type == ImageType.network
        ? Image.network(
            item.metas.image!.path,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          )
        : Image.asset(
            item.metas.image!.path,
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        FractionallySizedBox(
          widthFactor: 1,
          child: NeumorphicButton(
            onPressed: () {
              onPlaylistSelected(audios);
            },
            child: const Center(child: Text('เล่นทั้งหมด')),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, position) {
              final item = audios[position];
              final isPlaying = item.path == playing?.audio.assetAudioPath;
              return ListTile(
                  contentPadding : const EdgeInsets.symmetric(vertical: 6 , horizontal: 16),
                  leading: Material(
                    shape: const CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: _image(item),
                  ),
                  title: Text(item.metas.title.toString(),
                      style: TextStyle(
                        color: isPlaying ? Colors.blue : Colors.black,
                      )),
                  trailing: !isPlaying ? const Icon(Icons.play_arrow_outlined) :const Icon(Icons.pause),
                  onTap: () {
                    onSelected(item);
                  });
            },
            itemCount: audios.length,
          ),
        ),
      ],
    );
  }
}
