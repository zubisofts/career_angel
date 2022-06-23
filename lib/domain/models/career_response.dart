// To parse this JSON data, do
//
//     final careersResponse = careersResponseFromMap(jsonString);

import 'dart:convert';

import 'package:career_path/domain/models/career.dart';

CareersResponse careersResponseFromMap(String str) => CareersResponse.fromMap(json.decode(str));

String careersResponseToMap(CareersResponse data) => json.encode(data.toMap());

class CareersResponse {
    CareersResponse({
        required this.careers,
    });

    final List<Career> careers;

    CareersResponse copyWith({
        List<Career>? careers,
    }) => 
        CareersResponse(
            careers: careers ?? this.careers,
        );

    factory CareersResponse.fromMap(Map<String, dynamic> json) => CareersResponse(
        careers: List<Career>.from(json["careers"].map((x) => Career.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "careers": careers == null ? null : List<dynamic>.from(careers.map((x) => x.toMap())),
    };
}



