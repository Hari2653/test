import 'package:flutter/material.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

class FullScreenView extends StatelessWidget {
  FullScreenView({Key? key, required this.url}) : super(key: key);
  String url;

  @override
  Widget build(BuildContext context) {
    return PinchZoom(
      resetDuration: const Duration(milliseconds: 100),
      maxScale: 2.5,
      onZoomStart: () {
        print('Start zooming');
      },
      onZoomEnd: () {
        print('Stop zooming');
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage('${url}'), fit: BoxFit.fitWidth),
        ),
      ),
    );
  }
}
