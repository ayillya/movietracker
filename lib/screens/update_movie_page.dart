import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_card.dart';
import '../widgets/gradient_scaffold.dart';
import '../widgets/retry_button.dart';
import '../apistate_enums.dart';

class UpdateMoviePage extends StatelessWidget {
  const UpdateMoviePage({super.key});
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      title: "Update Ratings",
      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.state == ApiState.loading) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.lightBlueAccent,
                strokeWidth: 5,
              ),
            );
          }

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
                          builder: (context) {
                            final controller = TextEditingController(text: movie.rating.toString());
                            return AlertDialog(
                              title: Text("Update Rating",style: TextStyle(fontWeight: FontWeight.bold),),
                              content: TextField(
                                controller: controller,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: "Enter new rating",
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    final newRating = double.tryParse(controller.text);
                                    if (newRating != null) {
                                      provider.updateRating(movie.id, newRating);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text("Update"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                      child: Text(
                        "Update",
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

