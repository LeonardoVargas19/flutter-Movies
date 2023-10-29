
import 'dart:convert';

class CreditsResponese {
    int id;
    List<Cast> cast;
    List<Cast> crew;

    CreditsResponese({
        required this.id,
        required this.cast,
        required this.crew,
    });

    factory CreditsResponese.fromJson(String str) => CreditsResponese.fromMap(json.decode(str));



    factory CreditsResponese.fromMap(Map<String, dynamic> json) => CreditsResponese(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromMap(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromMap(x))),
    );

   
}

class Cast {
    bool adult;
    int gender;
    int id;
    String knownForDepartment;
    String name;
    String originalName;
    double popularity;
    String? profilePath;
    int? castId;
    String? character;
    String creditId;
    int? order;
    String? department;
    String? job;

    Cast({
        required this.adult,
        required this.gender,
        required this.id,
        required this.knownForDepartment,
        required this.name,
        required this.originalName,
        required this.popularity,
                 this.profilePath,
                 this.castId,
                 this.character,
        required this.creditId,
                 this.order,
                this.department,
                 this.job,
    });

get fullprofilePath{ 

    if (profilePath != null)
      return 'https://image.tmdb.org/t/p/w500${ this.profilePath }';

      return 'https://cdn.pixabay.com/photo/2017/01/25/17/35/picture-2008484_1280.png';

   
  }

    factory Cast.fromJson(String str) => Cast.fromMap(json.decode(str));



    factory Cast.fromMap(Map<String, dynamic> json) => Cast(
        adult: json["adult"],
        gender: json["gender"],
        id: json["id"],
        knownForDepartment: json["known_for_department"],
        name: json["name"],
        originalName: json["original_name"],
        popularity: json["popularity"].toDouble(),
        profilePath: json["profile_path"],
        castId: json["cast_id"],
        character: json["character"],
        creditId: json["credit_id"],
        order: json["order"],
        department: json["department"],
        job: json["job"],
    );

 
}
