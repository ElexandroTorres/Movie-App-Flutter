import 'package:flutter/material.dart';
import 'package:movie_app_flutter/app/login/view/pages/login_page.dart';
import 'package:movie_app_flutter/app/movie/view/widgets/movie_list_item.dart';
import 'package:movie_app_flutter/app/movie/viewmodel/movie_viewmodel.dart';
import 'package:movie_app_flutter/app/utils/theme/app_theme.dart';
import 'package:provider/provider.dart';

class TopRatedPage extends StatefulWidget {
  const TopRatedPage({Key? key}) : super(key: key);

  @override
  State<TopRatedPage> createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  final topRatedGridController = ScrollController();
  @override
  void initState() {
    Provider.of<MovieViewModel>(context, listen: false).getTopRated();
    topRatedGridController.addListener(() {
      if (topRatedGridController.position.maxScrollExtent ==
          topRatedGridController.offset) {
        Provider.of<MovieViewModel>(context, listen: false).getTopRated();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    topRatedGridController.dispose();
    super.dispose();
  }

  _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
    Provider.of<MovieViewModel>(context, listen: false).resetConfigs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Melhores avaliados'),
        backgroundColor: const Color(0xFF032541),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _logout();
              },
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: Center(
        child: Consumer<MovieViewModel>(
          builder: (context, movieViewModel, _) {
            if (movieViewModel.loadingStatus == LoadingStatus.loading) {
              return const CircularProgressIndicator();
            } else if (movieViewModel.loadingStatus == LoadingStatus.error) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Erro ao tentar obter os dados',
                    style: AppTheme.textStyles.listMovieError,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        movieViewModel.getTopRated();
                      },
                      child: const Text('Tentar Novamente')),
                ],
              );
            } else {
              var topRated = movieViewModel.topRatedList;
              return GridView.builder(
                controller: topRatedGridController,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: topRated.length,
                itemBuilder: ((context, index) {
                  return MovieListItem(
                    movie: topRated[index],
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsPage(
                            movie: topRated[index],
                          ),
                        ),
                      );
                    },
                  );
                }),
              );
            }
          },
        ),
      ),
    );
  }
}
