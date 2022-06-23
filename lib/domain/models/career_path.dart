class CareerPath {
    CareerPath({
        required this.name,
        this.channelId,
        required this.description,
        required this.thumbnailUrl,
        required this.subCareerPaths,
        this.introVideo,
    });

    final String name;
    final String? channelId;
    final String description;
    final String thumbnailUrl;
    final List<CareerPath> subCareerPaths;
    final String? introVideo;

    CareerPath copyWith({
        String? name,
        String? channelId,
        String? description,
        String? thumbnailUrl,
        List<CareerPath>? subCareerPaths,
        String? introVideo,
    }) => 
        CareerPath(
            name: name ?? this.name,
            channelId: channelId ?? this.channelId,
            description: description ?? this.description,
            thumbnailUrl: thumbnailUrl ?? this.thumbnailUrl,
            subCareerPaths: subCareerPaths ?? this.subCareerPaths,
            introVideo: introVideo ?? this.introVideo,
        );

    factory CareerPath.fromMap(Map<String, dynamic> json) => CareerPath(
        name: json["name"],
        channelId: json["channelId"],
        description: json["description"],
        thumbnailUrl: json["thumbnailUrl"],
        subCareerPaths: List<CareerPath>.from(json["subCareerPaths"].map((x) => CareerPath.fromMap(x))),
        introVideo: json["introVideo"],
    );

    Map<String, dynamic> toMap() => {
        "name": name,
        "channelId": channelId,
        "description": description,
        "thumbnailUrl": thumbnailUrl,
        "subCareerPaths": List<dynamic>.from(subCareerPaths.map((x) => x.toMap())),
        "introVideo": introVideo,
    };
}