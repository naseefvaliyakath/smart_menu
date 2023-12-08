import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../constants/app_constant_names.dart';

class StartupTutorialPage extends StatefulWidget {
  const StartupTutorialPage({super.key});

  @override
  StartupTutorialPageState createState() => StartupTutorialPageState();
}

class StartupTutorialPageState extends State<StartupTutorialPage> {
  late YoutubePlayerController _controller;
  final storage = const FlutterSecureStorage(aOptions: AndroidOptions(
    encryptedSharedPreferences: true,
  ));
  int _countdown = 20;
  bool _isButtonEnabled = false;
  late Timer _timer;


  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: 'WVfokYD2Tgc', // Your video ID here
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );

    _controller.addListener(_videoListener);

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
      } else {
        setState(() {
          _isButtonEnabled = true;
        });
        _timer.cancel();
      }
    });
  }

  void _videoListener() {
    if (_controller.value.playerState == PlayerState.ended) {
      storage.write(key: KEY_STARTUP_TUTORIAL, value: 'true');
      Navigator.pop(context); // Navigate to your home page here
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_videoListener);
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3, // Adjust the height as needed
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
          ),
          if (!_isButtonEnabled)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text('Wait for $_countdown seconds'),
            ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _isButtonEnabled
                  ? () {
                      storage.write(key: KEY_STARTUP_TUTORIAL, value: 'true');
                      Navigator.pop(context);
                    }
                  : null,
              child: const Text('Skip Tutorial'),
            ),
          ),
        ],
      ),
    );
  }
}
