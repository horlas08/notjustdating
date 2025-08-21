// ignore_for_file: library_private_types_in_public_api

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// class AppAudioPlayer extends StatefulWidget {
//   final String audioPath;
//   final Function(bool)? onChanged;

//   const AppAudioPlayer({Key? key, required this.audioPath, this.onChanged})
//       : super(key: key);

//   @override
//   _AppAudioPlayerState createState() => _AppAudioPlayerState();
// }

// class _AppAudioPlayerState extends State<AppAudioPlayer> {
//   final AudioPlayer _audioPlayer = AudioPlayer();
//   bool _isPlaying = false;
//   Duration _duration = Duration.zero;
//   Duration _position = Duration.zero;

//   @override
//   void initState() {
//     super.initState();

//     _audioPlayer.onDurationChanged.listen((duration) {
//       setState(() {
//         _duration = duration;
//       });
//     });

//     _audioPlayer.onPositionChanged.listen((position) {
//       setState(() {
//         _position = position;
//       });
//     });

//     _audioPlayer.onPlayerComplete.listen((event) {
//       setState(() {
//         _isPlaying = false;
//         _position = Duration.zero;
//       });
//     });
//   }

//   Future<void> _playPauseAudio() async {
//     if (_isPlaying) {
//       await _audioPlayer.pause();
//     } else {
//       await _audioPlayer
//           .play(DeviceFileSource(widget.audioPath)); // Updated line
//     }
//     setState(() {
//       _isPlaying = !_isPlaying;
//     });
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   String _formatDuration(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, "0");
//     final minutes = twoDigits(duration.inMinutes);
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return "$minutes:$seconds";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(20.0.w),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: EdgeInsets.all(10.w),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade200,
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     _isPlaying ? Icons.pause : Icons.play_arrow,
//                     color: Theme.of(context).primaryColor.withOpacity(0.8),
//                     size: 30,
//                   ),
//                   onPressed: _playPauseAudio,
//                 ),
//                 Expanded(
//                   child: Slider(
//                     value: _position.inSeconds.toDouble(),
//                     max: _duration.inSeconds.toDouble(),
//                     onChanged: (value) async {
//                       final position = Duration(seconds: value.toInt());
//                       await _audioPlayer.seek(position);
//                       await _audioPlayer.resume();
//                       widget.onChanged?.call(_isPlaying);
//                     },
//                   ),
//                 ),
//                 Text(
//                   _formatDuration(_position),
//                   style: TextStyle(fontSize: 14.h),
//                 ),

//                 // Total Duration (e.g., 3:45)
//                 Text(
//                   "/ " + _formatDuration(_duration),
//                   style: TextStyle(fontSize: 14.h, color: Colors.grey),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:audiowaveforms/audiowaveforms.dart';

class AppAudioPlayer extends StatefulWidget {
  final String audioPath;
  final Function(bool)? onChanged;

  const AppAudioPlayer({Key? key, required this.audioPath, this.onChanged})
      : super(key: key);

  @override
  _AppAudioPlayerState createState() => _AppAudioPlayerState();
}

class _AppAudioPlayerState extends State<AppAudioPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  final PlayerController _playerController =
      PlayerController(); // Controller for waveform

  @override
  void initState() {
    super.initState();

    _audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });

    _audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      setState(() {
        _isPlaying = false;
        _position = Duration.zero;
      });
    });

    // Initialize the waveform controller for audio visualization
    _initializeWaveform();
  }

  Future<void> _initializeWaveform() async {
    // Load the audio file into the waveform package
    if (widget.audioPath.startsWith('http')) {
      await _playerController.preparePlayer(path: widget.audioPath);
    } else {
      await _playerController.preparePlayer(path: widget.audioPath);
    }
  }

  Future<void> _playPauseAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      await _playerController.pausePlayer();
    } else {
      if (widget.audioPath.startsWith('http')) {
        await _audioPlayer.play(UrlSource(widget.audioPath));
      } else {
        await _audioPlayer.play(DeviceFileSource(widget.audioPath));
      }
      await _playerController.startPlayer();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _playerController.dispose();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final minutes = twoDigits(duration.inMinutes);
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Theme.of(context).primaryColor.withOpacity(0.8),
                        size: 30,
                      ),
                      onPressed: _playPauseAudio,
                    ),
                    SizedBox(
                      height: 70.h,
                      width: MediaQuery.of(context).size.width * 0.23,
                      child: AudioFileWaveforms(
                        playerController: _playerController,
                        size: Size(MediaQuery.of(context).size.width, 70),
                        enableSeekGesture: true,
                        waveformType: WaveformType.fitWidth,
                        playerWaveStyle: const PlayerWaveStyle(
                          waveCap: StrokeCap.square,

                            backgroundColor: Colors.black),
                      ),
                    ),
                    // Display current position and duration
                    Text(
                      _formatDuration(_position),
                      style: TextStyle(fontSize: 14.h),
                    ),
                    Text(
                      "/ ${_formatDuration(_duration)}",
                      style: TextStyle(fontSize: 14.h, color: Colors.grey),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                // Waveform visualization (Replaces Slider)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
