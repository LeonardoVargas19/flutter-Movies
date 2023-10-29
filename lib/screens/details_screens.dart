import 'package:flutter/material.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/widgets/widgets.dart';

class DatailsScreen extends StatelessWidget {
  const DatailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final Movies movie = ModalRoute.of(context)!.settings.arguments as Movies;
  


    print(movie.title);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar( movies: movie,),
          SliverList(delegate: SliverChildListDelegate([
            _PosterAndTitle(movies: movie,),
            _Overview(movies: movie,),
            CastingCards(movieid: movie.id, ),
          ]))
        ],
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget {
  final Movies movies;
  const _CustomAppBar({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.purple,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.only(bottom: 15,left: 20,right: 20),
          color: Colors.black12,
          child: Text(movies.title,style: TextStyle(fontSize: 16),textAlign: TextAlign.center, ),
        ),
        background:  FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage(movies.fullBackdropPath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  final Movies movies;
  
  const _PosterAndTitle({super.key, required this.movies});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Hero(
            tag: movies.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child:  FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movies.fullPosterImg),
                height: 150,
              
              ),
            ),
          ),
           SizedBox( width: 20,),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width-190),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          
                Text(movies.title , style: textTheme.headline5,overflow: TextOverflow.ellipsis,maxLines: 2,),
          
                Text(movies.originalTitle,style: textTheme.subtitle1,overflow: TextOverflow.ellipsis,maxLines: 2,),
          
                Row(
                  children: [
                    Icon(Icons.star_outline, size: 15, color: Colors.purple),
                    SizedBox(width: 5,),
                    Text('Promedio de Votos',style: Theme.of(context).textTheme.caption,),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  final Movies movies;
  const _Overview({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      child: Text(
        movies.overview,
        textAlign: TextAlign.justify,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}
