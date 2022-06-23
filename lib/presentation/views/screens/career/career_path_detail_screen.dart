import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_path/core/video_utils.dart';
import 'package:career_path/domain/cubits/career_cubit/careers_cubit.dart';
import 'package:career_path/domain/models/career_path.dart';
import 'package:either_dart/either.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CareerPathDetailScreen extends StatefulWidget {
  final CareerPath careerPath;

  const CareerPathDetailScreen({Key? key, required this.careerPath})
      : super(key: key);

  @override
  State<CareerPathDetailScreen> createState() => _CareerPathDetailScreenState();
}

class _CareerPathDetailScreenState extends State<CareerPathDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController = TabController(length: 2, vsync: this);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        body: TabBarView(controller: _tabController, children: [
          OverviewTab(careerPath: widget.careerPath),
          VideosTab(videoId: widget.careerPath.channelId!),
        ]),
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: Text(widget.careerPath.name),
              expandedHeight: 250,
              actions: [
                IconButton(
                    onPressed: () {
                      Share.share(
                          'Hi there!, I would like you to follow me watch and take a bold step on choosing ${widget.careerPath.name} as a career here https://www.youtube.com/watch?v=${widget.careerPath.introVideo} \n${widget.careerPath.description}');
                    },
                    icon: const Icon(Icons.share_outlined))
              ],
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.careerPath.thumbnailUrl,
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
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(kToolbarHeight),
                child: Theme(
                  data: Theme.of(context).copyWith(
                    tabBarTheme: TabBarTheme(
                      labelColor: Theme.of(context).colorScheme.primary,
                      unselectedLabelColor:
                          Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  child: Container(
                    color: Theme.of(context).canvasColor,
                    child: TabBar(
                        indicatorColor: Theme.of(context).colorScheme.primary,
                        controller: _tabController,
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        tabs: const [
                          Tab(
                            text: "Details",
                          ),
                          Tab(
                            text: "Videos",
                          )
                        ]),
                  ),
                ),
              ),
            ),
          ];
        },
      ),
    );
  }
}

class OverviewTab extends StatefulWidget {
  const OverviewTab({
    Key? key,
    required this.careerPath,
  }) : super(key: key);

  final CareerPath careerPath;

  @override
  State<OverviewTab> createState() => _OverviewTabState();
}

class _OverviewTabState extends State<OverviewTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    String? thumbnail = widget.careerPath.introVideo != null
        ? YoutubePlayer.getThumbnail(
            videoId: widget.careerPath.introVideo!,
          )
        : null;
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "Overview",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
          ),
          const SizedBox(
            height: 16.0,
          ),
          ExpandableText(
            widget.careerPath.description,
            textAlign: TextAlign.justify,
            expandText: 'show more',
            collapseText: "show less",
            maxLines: 16,
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
          if (thumbnail != null)
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: thumbnail,
                      fit: BoxFit.cover,
                    ),
                    Container(color: Colors.black.withOpacity(0.3)),
                    IconButton(
                        onPressed: () {
                          VideoUtils.playVideo(
                              context, widget.careerPath.introVideo!);
                        },
                        iconSize: 45,
                        icon: const Icon(
                          Icons.play_circle_fill_outlined,
                          color: Colors.white,
                        ))
                  ],
                )),
          // IntroClip(clipId: widget.careerPath.introVideo!),
        ]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class VideosTab extends StatefulWidget {
  final String videoId;

  const VideosTab({Key? key, required this.videoId}) : super(key: key);

  @override
  State<VideosTab> createState() => _VideosTabState();
}

class _VideosTabState extends State<VideosTab>
    with AutomaticKeepAliveClientMixin {
  final CareersCubit _careerCubit = CareersCubit();

  @override
  void initState() {
    super.initState();
    _careerCubit.fetchCareerVideos(widget.videoId);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CareersCubit, CareersState>(
      bloc: _careerCubit,
      builder: (context, state) {
        if (state is Loading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state is LoadError) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is VideosFetched) {
          List<Video> videos = state.videos;
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16),
            shrinkWrap: true,
            itemCount: videos.length,
            itemBuilder: (ctx, index) {
              return VideoItem(video: videos[index]);
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class VideoItem extends StatelessWidget {
  final Video video;

  const VideoItem({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        onTap: (() => VideoUtils.playVideo(context, video.id.value)),
        leading: SizedBox(
            width: 100,
            child: CachedNetworkImage(imageUrl: video.thumbnails.mediumResUrl)),
        title: Text(
          video.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(video.description,
            maxLines: 3, overflow: TextOverflow.ellipsis),
      ),
    );
  }
}
