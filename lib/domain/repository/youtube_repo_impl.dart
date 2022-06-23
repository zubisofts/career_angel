import 'dart:convert';
import 'dart:developer';

import 'package:career_path/domain/models/career.dart';
import 'package:career_path/domain/models/career_response.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/services.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeRepo {
  final String className = 'YoutubeRepoImpl';

  @override
  Future<Either<String, List<Video>>> getCareerPathVideos(String id) async {
    YoutubeExplode yt = YoutubeExplode();

    try {
      // Get playlist metadata.
      var playlist = await yt.playlists.get(id);

      List<Video> playlistVideos = await yt.playlists
          .getVideos(playlist.id)
          .map((video) => video)
          .toList();

      return Right(playlistVideos);
    } catch (e) {
      log("Fetch playlist error: $e", name: className);
      return const Left("Unable to fetch course videos at the moment");
    }
  }

  Future<List<Career>> get getCareerList async {
    final String response =
        await rootBundle.loadString('assets/files/data.json');
    CareersResponse data = CareersResponse.fromMap(jsonDecode(response));

    return data.careers;
  }

  Future<List<Career>> searchCareer(String query) async {
    final String response =
        await rootBundle.loadString('assets/files/data.json');
    CareersResponse data = CareersResponse.fromMap(jsonDecode(response));

    return data.careers
        .where((element) =>
            element.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }
}
