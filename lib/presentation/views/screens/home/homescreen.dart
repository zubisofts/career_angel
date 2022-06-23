import 'dart:developer';

import 'package:career_path/domain/cubits/app_cubit/app_cubit.dart';
import 'package:career_path/domain/cubits/career_cubit/careers_cubit.dart';
import 'package:career_path/domain/models/career.dart';
import 'package:career_path/domain/repository/youtube_repo_impl.dart';
import 'package:career_path/presentation/views/screens/home/widgets/career_item.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          actions: [
            BlocBuilder<AppCubit, AppState>(
              bloc: context.read<AppCubit>()..getAppTheme,
              builder: (context, state) {
                bool isDark = false;
                if (state is ThemeState) {
                  isDark = state.isDark;
                }
                return IconButton(
                    onPressed: () {
                      context.read<AppCubit>().setAppTheme(!isDark);
                    },
                    icon: Icon(
                      Icons.brightness_4,
                      color: Theme.of(context).colorScheme.onBackground,
                    ));
              },
            )
          ],
          title: Text("Career Angel ✨",
              style: GoogleFonts.tinos().copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary)),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              _selectedIndex =index;
              _pageController.animateToPage(_selectedIndex,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInCubic);
            });

          },

          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: "About",
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).colorScheme.primary,
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          controller: _pageController,
          onPageChanged: (index){

          },
          children: const [
            CareersTab(),
            AboutTab(),
          ],
        ));
  }
}

class CareersTab extends StatefulWidget {
  const CareersTab({Key? key}) : super(key: key);

  @override
  State<CareersTab> createState() => _CareersTabState();
}

class _CareersTabState extends State<CareersTab> {
  final CareersCubit _careersCubit = CareersCubit();

  final TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _careersCubit.getCareerList;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CareersCubit, CareersState>(
      bloc: _careersCubit,
      builder: (context, state) {
        if (state is CareersFetched) {
          List<Career> careers = state.careers;
          return Column(
            children: [
              Card(
                  margin: const EdgeInsets.all(16),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextFormField(
                      controller: _searchTextController,
                      textInputAction: TextInputAction.go,
                      onFieldSubmitted: (val) {
                        _careersCubit.searchCareer(val);
                      },
                      decoration: const InputDecoration(
                          hintText: "Search Career",
                          prefixIcon: Icon(Icons.search_outlined),
                          border: InputBorder.none),
                    ),
                  )),
              if (careers.isEmpty)
                if (careers.isEmpty)
                  const Center(
                    child: Text("Oops! Nothing was found here..."),
                  ),
              if (careers.isNotEmpty)
                Expanded(
                    child: Stack(
                  children: [
                    ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 24),
                      itemCount: careers.length,
                      itemBuilder: (ctx, index) {
                        return CareerItem(career: careers[index]);
                      },
                    ),
                    GestureDetector(
                      child: IgnorePointer(
                        child: Container(
                            height: 80,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(01),
                                  Theme.of(context)
                                      .scaffoldBackgroundColor
                                      .withOpacity(0.05),
                                  Colors.transparent
                                ],
                              ),
                            )),
                      ),
                    ),
                  ],
                )),
            ],
          );
        }
        if (state is Loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is LoadError) {
          return const Center(child: Text("An error occurred"));
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class AboutTab extends StatelessWidget {
  const AboutTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Image.asset('assets/images/gdg_logo.png'),
              const SizedBox(
                height: 16,
              ),
              const Divider(),
              const SizedBox(height: 16,),
              const Text(
                "Google I/O Extended Aba 2022\n Hackathon",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 32,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "About Event",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              const Text(
                "I/O Extended bring together local developers to talk about their favorite announcements from I/O "
                "and all the new technologies. Google I/O connects developers from around the world for thoughtful discussions,"
                "hands-on learning with Google experts, and the first look at Google’s latest developer products.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1)
                ),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "About GDG Aba",
                        textAlign: TextAlign.left,
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ExpandableText(
                      "Google Developers Group (GDG) Aba is a non-profit group in Abia State,"
                          "Nigeria. We tend to use Google Technologies to touch and change lives "
                          "in Africa by organizing conferences, schools challenge, meetups and other"
                          "events that will inspire young developers.Disclaimer: GDG Aba is an independent "
                          "group; our activities and the opinions expressed here should in no way be linked"
                          "to Google, the corporation. To learn more about the GDG program, "
                          "visit https://developers.google.com/community/gdg/",
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
                      onUrlTap: (url)async{
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
                  ],
                ),
              )
            ],
          )),
    );
  }
}
