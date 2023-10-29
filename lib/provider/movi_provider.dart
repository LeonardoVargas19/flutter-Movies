import 'dart:async';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _apiKey = '3f77731899e149caaca5c6ff85326817';
  final String _language = 'es-ES';

  List<Movies> onDisplayMovie = [];
  List<Movies> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};
  int _popularPage = 0;
  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Movies>> _suggestionStreamController =
      new StreamController.broadcast();
  Stream<List<Movies>> get suggestionSream =>
      this._suggestionStreamController.stream;

  MoviesProvider() {
    print('MovieProvider inicializado');
    this.getOndisplayMovie();
    this.getPopularmovies();
  }

  Future<String> _getJsonData(String endPoint, [int page = 1]) async {
    var url = Uri.https(this._baseUrl, endPoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});
    final response = await http.get(url);
    return response.body;
  }

  getOndisplayMovie() async {
    final jsonData = await this._getJsonData('3/movie/now_playing');
    // Await the http get response, then decode the json-formatted response.

    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovie = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularmovies() async {
    _popularPage++;
    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PupularResponse.fromJson(jsonData);

    popularMovies = [...popularMovies, ...popularResponse.results];
    // Toma las peliculas actuales y le concatenas los resultados de las popularmovies

    notifyListeners();
  }

  Future<List<Cast>> getMoviCast(int movieid) async {
    if (moviesCast.containsKey(movieid)) return moviesCast[movieid]!;

    final jsonData = await this._getJsonData('3/movie/$movieid/credits');
    final creditsResponese = CreditsResponese.fromJson(jsonData);
    moviesCast[movieid] = creditsResponese.cast;
    return creditsResponese.cast;
  }

  Future<List<Movies>> searchMovies(String query) async {
    final url = Uri.https(this._baseUrl, '3/search/movie',
        {'api_key': _apiKey, 'language': _language, 'query': query});
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);

    return searchResponse.results;
  }

  void getSuggestionByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final result = await this.searchMovies(value);
      this._suggestionStreamController.add(result);
    };
    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }
}
