import 'dart:convert';

import 'package:peliculas/models/models.dart';





class NowPlayingResponse {
    Dates dates;
    int page;
    List<Movies> results;
    int totalPages;
    int totalResults;

    NowPlayingResponse({
        required this.dates,
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory NowPlayingResponse.fromJson(String str) => NowPlayingResponse.fromMap(json.decode(str));



    factory NowPlayingResponse.fromMap(Map<String, dynamic> json) => NowPlayingResponse(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<Movies>.from(json["results"].map((x) => Movies.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

}

class Dates {
    DateTime maximum;
    DateTime minimum;

    Dates({
       required this.maximum,
       required this.minimum,
    });

    factory Dates.fromJson(String str) => Dates.fromJson(json.decode(str));

    

    factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    );

   
}
