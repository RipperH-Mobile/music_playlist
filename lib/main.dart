import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:music_playlist/player/PlayingControls.dart';
import 'package:music_playlist/player/PositionSeekWidget.dart';
import 'package:music_playlist/player/SongsSelector.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Demo Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AssetsAudioPlayer _assetsAudioPlayer;
  final List<StreamSubscription> _subscriptions = [];
  final audios = <Audio>[
    //Audio.network(
    //  'https://d14nt81hc5bide.cloudfront.net/U7ZRzzHfk8pvmW28sziKKPzK',
    //  metas: Metas(
    //    id: 'Invalid',
    //    title: 'Invalid',
    //    artist: 'Florent Champigny',
    //    album: 'OnlineAlbum',
    //    image: MetasImage.network(
    //        'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
    //  ),
    //),
    Audio(
      'assets/audios/nanhathong.mp3',
      metas: Metas(
        id: 'NanhaThong',
        title: 'นะหน้าทอง',
        artist: 'โจอี้ ภูวศิษฐ์',
        album: '-',
        image: MetasImage.network(
            'https://i.ytimg.com/vi/-Dt2WaYs9nE/maxresdefault.jpg'),
      ),
    ),
    Audio.network(
      'https://files.freemusicarchive.org/storage-freemusicarchive-org/music/Music_for_Video/springtide/Sounds_strange_weird_but_unmistakably_romantic_Vol1/springtide_-_03_-_We_Are_Heading_to_the_East.mp3',
      metas: Metas(
        id: 'Online',
        title: 'Online',
        artist: 'Florent Champigny',
        album: 'OnlineAlbum',
        // image: MetasImage.network('https://www.google.com')
        image: const MetasImage.network(
            'https://image.shutterstock.com/image-vector/pop-music-text-art-colorful-600w-515538502.jpg'),
      ),
    ),
    Audio(
      'assets/audios/ROCKETFESTIVAL.mp3',
      metas: Metas(
        id: 'ROCKETFESTIVAL',
        title: 'ROCKETFESTIVAL',
        artist: 'โจอี้ ภูวศิษฐ์',
        album: '-',
        image: MetasImage.network(
            'https://is1-ssl.mzstatic.com/image/thumb/Music122/v4/ed/89/c6/ed89c6a4-3643-eaa4-b6e9-eac2f1129875/2213214501.jpg/1200x1200bb.jpg'),
      ),
    ),
    Audio(
      'assets/audios/Sunflower.mp3',
      metas: Metas(
        id: 'Sunflower',
        title: 'Sunflower',
        artist: 'post malone',
        album: '-',
        image: MetasImage.network(
            'https://pics.filmaffinity.com/Post_Malone_Swae_Lee_Sunflower_Music_Video-836039064-large.jpg'),
      ),
    ),
    Audio(
      'assets/audios/StayWithMe.mp3',
      metas: Metas(
        id: 'StayWithMe',
        title: 'StayWithMe',
        artist: 'Miki Matsubara',
        album: '-',
        image: MetasImage.network(
            'https://becommon.co/wp-content/uploads/2021/10/body-Miki-Matsubara-3.jpg'),
      ),
    ),
  ];

  Audio find(List<Audio> source, String fromPath) {
    return source.firstWhere((element) => element.path == fromPath);
  }

  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();

    _subscriptions.add(_assetsAudioPlayer.playlistAudioFinished.listen((data) {
      print('playlistAudioFinished : $data');
    }));
    _subscriptions.add(_assetsAudioPlayer.audioSessionId.listen((sessionId) {
      print('audioSessionId : $sessionId');
    }));
    openPlayer();
  }

  void openPlayer() async {
    await _assetsAudioPlayer.open(
      Playlist(audios: audios, startIndex: 0),
      showNotification: true,
      autoStart: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My PlayList')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 48.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _assetsAudioPlayer.builderCurrent(builder: (BuildContext context, Playing? playing) {
                  return SongsSelector(
                    audios: audios,
                    onPlaylistSelected: (myAudios) {
                      _assetsAudioPlayer.open(
                        Playlist(audios: myAudios),
                        showNotification: true,
                        headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplugPlayOnPlug,
                        audioFocusStrategy: const AudioFocusStrategy.request(resumeAfterInterruption: true),
                      );
                    },
                    onSelected: (myAudio) async {
                      try {
                        await _assetsAudioPlayer.open(
                          myAudio,
                          autoStart: true,
                          showNotification: true,
                          playInBackground: PlayInBackground.enabled,
                          audioFocusStrategy: const AudioFocusStrategy.request(
                              resumeAfterInterruption: true, resumeOthersPlayersAfterDone: true),
                          headPhoneStrategy: HeadPhoneStrategy.pauseOnUnplug,
                          notificationSettings: const NotificationSettings(
                              //seekBarEnabled: false,
                              //stopEnabled: true,
                              //customStopAction: (player){
                              //  player.stop();
                              //}
                              //prevEnabled: false,
                              //customNextAction: (player) {
                              //  print('next');
                              //}
                              //customStopIcon: AndroidResDrawable(name: 'ic_stop_custom'),
                              //customPauseIcon: AndroidResDrawable(name:'ic_pause_custom'),
                              //customPlayIcon: AndroidResDrawable(name:'ic_play_custom'),
                              ),
                        );
                      } catch (e) {
                        print(e);
                      }
                    },
                    playing: playing,
                  );
                }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 120,
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _assetsAudioPlayer.builderRealtimePlayingInfos(builder: (context, RealtimePlayingInfos? infos) {
              if (infos == null) {
                return const SizedBox();
              }
              //print('infos: $infos');
              return PositionSeekWidget(
                currentPosition: infos.currentPosition,
                duration: infos.duration,
                seekTo: (to) {
                  _assetsAudioPlayer.seek(to);
                },
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StreamBuilder<Playing?>(
                    stream: _assetsAudioPlayer.current,
                    builder: (context, playing) {
                      if (playing.data != null) {
                        final myAudio = find(audios, playing.data!.audio.assetAudioPath);
                        print(playing.data!.audio.assetAudioPath);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Neumorphic(
                                style: const NeumorphicStyle(
                                  depth: 8,
                                  surfaceIntensity: 1,
                                  shape: NeumorphicShape.concave,
                                  boxShape: NeumorphicBoxShape.circle(),
                                ),
                                child: myAudio.metas.image?.path == null
                                    ? const SizedBox()
                                    : myAudio.metas.image?.type == ImageType.network
                                        ? Image.network(
                                            myAudio.metas.image!.path,
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.contain,
                                          )
                                        : Image.asset(
                                            myAudio.metas.image!.path,
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.contain,
                                          ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(myAudio.metas.title.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16
                                        )),
                                    Text(myAudio.metas.artist.toString(),
                                        style: const TextStyle(
                                          color: Colors.black,
                                        )),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    }),
                _assetsAudioPlayer.builderCurrent(builder: (context, Playing? playing) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _assetsAudioPlayer.builderLoopMode(
                        builder: (context, loopMode) {
                          return PlayerBuilder.isPlaying(
                              player: _assetsAudioPlayer,
                              builder: (context, isPlaying) {
                                return PlayingControls(
                                  loopMode: loopMode,
                                  isPlaying: isPlaying,
                                  isPlaylist: true,
                                  onStop: () {
                                    _assetsAudioPlayer.stop();
                                  },
                                  toggleLoop: () {
                                    _assetsAudioPlayer.toggleLoop();
                                  },
                                  onPlay: () {
                                    _assetsAudioPlayer.playOrPause();
                                  },
                                );
                              });
                        },
                      ),
                    ],
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _assetsAudioPlayer.dispose();
    print('dispose');
    super.dispose();
  }
}
