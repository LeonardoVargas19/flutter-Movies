import 'dart:convert';

import 'package:peliculas/models/models.dart';

class PupularResponse {
    int page;
    List<Movies> results;
    int totalPages;
    int totalResults;

    PupularResponse({
       required this.page,
       required this.results,
       required this.totalPages,
       required this.totalResults,
    });

    factory PupularResponse.fromJson(String str) => PupularResponse.fromMap(json.decode(str));


    factory PupularResponse.fromMap(Map<String, dynamic> json) => PupularResponse(
        page: json["page"],
        results: List<Movies>.from(json["results"].map((x) => Movies.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );


}