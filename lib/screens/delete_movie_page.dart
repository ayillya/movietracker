import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import 'package:moviewishlist/widgets/gradient_scaffold.dart';
import '../widgets/movie_card.dart';
import '../widgets/retry_button.dart';
import '../apistate_enums.dart';

class DeleteMoviePage extends StatelessWidget {
  const DeleteMoviePage({super.key});
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      title: "Delete Movie",
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.state == ApiState.loading){
            return Center(
                child: CircularProgressIndicator(
              color: Colors.lightBlueAccent,
              strokeWidth: 5,
            ));}
          if (provider.state == ApiState.error) {
            return RetryButton(
              error : provider.errorMessage ?? 'Something went wrong',
              onRetry : () => provider.fetchMovies(),
            );
          }

          return ListView.builder(
            itemCount: provider.movies.length,
            itemBuilder: (context, index) {
              final movie = provider.movies[index];

              return Stack(
                children: [
                  MovieCard(movie: movie),
                  Positioned(
                    right: 20,
                    bottom: 12,
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Delete Movie",style: TextStyle(fontWeight: FontWeight.bold)),
                            content: Text("Are you sure you want to delete '${movie.title}'?"),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Cancel"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  provider.deleteMovie(movie.id);
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
                                child: Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}






