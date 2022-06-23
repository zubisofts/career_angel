import 'package:cached_network_image/cached_network_image.dart';
import 'package:career_path/domain/models/career.dart';
import 'package:career_path/presentation/views/screens/career/career_path_detail_screen.dart';
import 'package:flutter/material.dart';

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
                const Text(
                  "Career Paths",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
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
                            builder: (_) => CareerPathDetailScreen(
                                careerPath: career.careerPaths[index]),
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
