import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class audioplay {
  AudioPlayer player = AudioPlayer();

  void byteplay(Uint8List byte) {
    player.setReleaseMode(ReleaseMode.stop);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(BytesSource(byte));
      await player.resume();
    });
  }

}


