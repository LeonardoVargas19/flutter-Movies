import 'package:flutter/material.dart';
import 'package:peliculas/models/movie.dart';
import 'package:peliculas/provider/movi_provider.dart';

import 'package:provider/provider.dart';

class MovieSearchDelagate extends SearchDelegate {
  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () => query = '', icon: Icon(Icons.clear))];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('buildResults');
  }

  Widget _emtyContainer() {
    return Container(
      child: Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.purple[400],
          size: 130,
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      _emtyContainer();
    }
    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionByQuery(query);
    return StreamBuilder(
      stream: moviesProvider.suggestionSream,
      builder: (_, AsyncSnapshot<List<Movies>> snapshot) {
        if (!snapshot.hasData) return _emtyContainer();

        final movies = snapshot.data!;
        return ListView.builder(
          itemBuilder: (_, int index) => _MovieItem(movie: movies[index]),
          itemCount: movies.length,
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  final Movies movie;
  const _MovieItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    return ListTile(
        leading: Hero(
          tag: movie.heroId!,
          child: FadeInImage(
            image: NetworkImage(movie.fullPosterImg),
            placeholder: AssetImage('assets/no-image.jpg'),
            width: 80,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(movie.title),
        subtitle: Text(movie.originalTitle),
        onTap: () => Navigator.pushNamed(context, 'datails', arguments: movie));
  }
}
