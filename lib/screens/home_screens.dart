

import 'package:flutter/material.dart';
import 'package:peliculas/provider/movi_provider.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    final moviesProvider  = Provider.of<MoviesProvider>(context);
  
    print(moviesProvider.onDisplayMovie);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Pelicualas en cines'),
          elevation: 0,
          actions: [
        IconButton(
          onPressed: () =>showSearch(context: context, delegate: MovieSearchDelagate()), 
          icon: Icon(Icons.search)
           )
         ],
        ),
        body:  SingleChildScrollView(
          child: Column(
            children: [
              // tarjetas principales
              CardSwiper( movies:moviesProvider.onDisplayMovie ),

              // Slider de peliculas
              MovieSlider( 
                popularMovies: moviesProvider.popularMovies,
                title: ' Populares',
                onNextPage: ()=> moviesProvider.getPopularmovies(),),
            ],
          ),
        ));
  }
}
