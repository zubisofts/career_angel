import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_path/core/video_utils.dart';
import 'package:career_path/domain/models/career.dart';
import 'package:career_path/presentation/views/screens/career/career_path_detail_screen.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CareerDetailScreen extends StatelessWidget {
  final Career career;
  const CareerDetailScreen({Key? key, required this.career}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var thumbnail = YoutubePlayer.getThumbnail(videoId: career.introVideo!);
    return   Hero(
      tag: career.id,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(career.title),
              expandedHeight: 200,
              actions: [
               if(career.careerPaths.isEmpty)
                 IconButton(
                     onPressed: () {
                      Share.share('Hi there!, I would like you to follow me watch and take a bold step on choosing ${career.title} as a career here https://www.youtube.com/watch?v=${career.introVideo} \n${career.description}');
                     },
                     icon: const Icon(Icons.share, color: Colors.white,))
              ],
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: career.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.black.withOpacity(0.1),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Overview",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      ExpandableText(
                        career.description,
                        textAlign: TextAlign.justify,
                        expandText: 'show more',
                        collapseText: "show less",
                        maxLines: 10,
                        linkColor: Colors.blue,
                        animation: true,
                        collapseOnTextTap: true,
                        // prefixText: 'username',
                        onPrefixTap: () {
                          // showProfile(username);
                        },
                        prefixStyle: const TextStyle(fontWeight: FontWeight.bold),
                        onHashtagTap: (name) {
                          // showHashtag(name);
                        },
                        expandOnTextTap: true,
                        hashtagStyle: const TextStyle(
                          color: Color(0xFF30B6F9),
                        ),
                        onMentionTap: (username) {
                          // showProfile(username);
                        },
                        mentionStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                        onUrlTap: (url) async{
                          if (!await launchUrl(Uri.parse(url)));
                        },
                        urlStyle: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.lightBlue),
                        style: TextStyle(
                            height: 1.5,
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 16),
                      ),
                      const SizedBox(
                        height: 16.0,
                      ),
                      if (career.introVideo != null)
                        SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 200,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CachedNetworkImage(
                                    imageUrl: thumbnail, fit: BoxFit.cover),
                                Container(color: Colors.black.withOpacity(0.3)),
                                IconButton(
                                    onPressed: () {
                                      VideoUtils.playVideo(
                                          context, career.introVideo!);
                                    },
                                    iconSize: 45,
                                    icon: const Icon(
                                      Icons.play_circle_fill_outlined,
                                      color: Colors.white,
                                    ))
                              ],
                            )),
                      // if (career.introVideo != null) IntroClip(career: career),
                      CareerPathsWidget(career: career),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IntroClip extends StatefulWidget {
  final Career career;

  const IntroClip({Key? key, required this.career}) : super(key: key);

  @override
  State<IntroClip> createState() => _IntroClipState();
}

class _IntroClipState extends State<IntroClip> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
        initialVideoId: widget.career.introVideo!,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 16,
        ),
        Text("Intro",
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
                fontSize: 22)),
        const SizedBox(
          height: 8.0,
        ),
        YoutubePlayerBuilder(
            player: YoutubePlayer(
              controller: _controller,
            ),
            builder: (context, player) {
              return player;
            }),
      ],
    );
  }
}

class CareerPathsWidget extends StatelessWidget {
  final Career career;
  const CareerPathsWidget({Key? key, required this.career}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: career.careerPaths.isNotEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Paths",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                const SizedBox(
                  height: 8.0,
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: career.careerPaths.length,
                    itemBuilder: (_, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => career
                                        .careerPaths[index].channelId !=
                                    null
                                ? CareerPathDetailScreen(
                                    careerPath: career.careerPaths[index])
                                : CareerDetailScreen(
                                    career: Career(
                                        id: career.careerPaths[index].hashCode,
                                        description: career
                                            .careerPaths[index].description,
                                        imageUrl: career
                                            .careerPaths[index].thumbnailUrl,
                                        title: career.careerPaths[index].name,
                                        introVideo: career
                                            .careerPaths[index].introVideo,
                                        careerPaths: career
                                            .careerPaths[index].subCareerPaths),
                                  ),
                          ));
                        },
                        child: Card(
                            elevation: 0,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: Column(
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                            top: Radius.circular(8.0),
                                            bottom: Radius.circular(0.0),
                                          ),
                                          child: CachedNetworkImage(
                                            imageUrl: career.careerPaths[index]
                                                .thumbnailUrl,
                                            fit: BoxFit.cover,
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8.0),
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.arrow_circle_right_outlined,
                                            color: Colors.white,
                                            size: 45,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(0.0),
                                          bottom: Radius.circular(8.0),
                                        ),
                                      ),
                                      child: Text(
                                        career.careerPaths[index].name,
                                        maxLines: 2,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSurface,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      );
                    },
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
