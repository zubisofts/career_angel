import 'dart:ui';

import 'package:flutter/material.dart';

import '../presentation/views/screens/career/widgets/intro_clip.dart';

class VideoUtils {
  VideoUtils._();

  static void playVideo(BuildContext context, String videoId) {
    final ValueNotifier<bool> isFullScreen = ValueNotifier(false);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Dialog(
                backgroundColor: Colors.transparent,
                insetPadding: const EdgeInsets.all(16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: SizedBox(
                        // width: MediaQuery.of(context).size.width,
                        child: IntroClip(
                          clipId: videoId,
                          onEnterFullScreen: () {
                            isFullScreen.value = true;
                          },
                          onExitFullScreen: () {
                            isFullScreen.value = false;
                          },
                        ),
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                        valueListenable: isFullScreen,
                        builder: (context, value, child) {
                          return Visibility(
                            visible: !value,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 32),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                )),
          );
        });
  }
}
