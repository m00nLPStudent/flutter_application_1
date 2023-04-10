import 'dart:async';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.asset('videos/splash.mp4');
    _initializeVideoPlayerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        //print("Connection state: ${snapshot.connectionState}");
        if (snapshot.connectionState == ConnectionState.done) {
          _controller.play();
          return Container(
            color: Colors.white,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: SizedBox(
                  width: _controller.value.size.width ?? 0,
                  height: _controller.value.size.height ?? 0,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
