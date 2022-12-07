import 'package:flutter/material.dart';
import 'package:movie_app_flutter/app/movie/model/movie.dart';
import 'package:movie_app_flutter/app/movie/view/widgets/vote_circle.dart';
import 'package:movie_app_flutter/app/utils/constants.dart';

class MovieListItem extends StatelessWidget {
  const MovieListItem({Key? key, required this.movie, required this.onTap})
      : super(key: key);

  final Movie movie;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            FittedBox(
              fit: BoxFit.fill,
              child: Hero(
                tag: movie.id.toString(),
                child: Image.network(
                  '$imageUrl${movie.posterPath.toString()}',
                ),
              ),
            ),
            Positioned(
              bottom: 4,
              left: 4,
              child: VoteCircle(
                voteAvarage: movie.voteAverage.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
