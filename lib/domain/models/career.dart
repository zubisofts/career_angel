import 'package:career_path/domain/models/career_path.dart';

class Career {
  Career({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.careerPaths,
    this.introVideo, 
  });

  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String? introVideo;
  final List<CareerPath> careerPaths;

  Career copyWith({
    int? id,
    String? title,
    String? description,
    String? imageUrl,
    List<CareerPath>? careerPaths,
    String? introVideo,
  }) =>
      Career(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        imageUrl: imageUrl ?? this.imageUrl,
        careerPaths: careerPaths ?? this.careerPaths,
        introVideo: introVideo ?? this.introVideo
      );

  factory Career.fromMap(Map<String, dynamic> json) => Career(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        imageUrl: json["imageUrl"],
        careerPaths: List<CareerPath>.from(
            json["careerPaths"].map((x) => CareerPath.fromMap(x))),
            introVideo: json["introVideo"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "description": description,
        "imageUrl": imageUrl,
        "careerPaths": List<dynamic>.from(careerPaths.map((x) => x.toMap())),
        "introVideo": introVideo,
      };
}
