import 'package:flutter/material.dart';

import '../presentation/views/screens/career/widgets/intro_clip.dart';

class VideoUtils {
  VideoUtils._();

  static void playVideo(BuildContext context, String videoId) {
    // Navigator.of(context).push(MaterialPageRoute<void>(
    //     builder: (BuildContext context) {
    //       return Center(child: IntroClip(clipId: videoId));
    //     },
    //     fullscreenDialog: true));
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return Dialog(
            insetPadding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: SizedBox(
                  // width: MediaQuery.of(context).size.width,
                  child: IntroClip(clipId: videoId),
                ),
              ));
        });
  }
}
