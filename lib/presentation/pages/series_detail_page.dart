import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';

import 'package:ditonton/presentation/provider/series_detail_notifier.dart';
import 'package:ditonton/presentation/widgets/custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class SeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-series';

  final int id;
  SeriesDetailPage({required this.id});

  @override
  _SeriesDetailPageState createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SeriesDetailCubit>().fetchSeriesDetail(widget.id);
      context.read<SeriesDetailCubit>().loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SeriesDetailCubit, SeriesDetailState>(
        builder: (context, provider) {
          if (provider.dataState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.dataState == RequestState.Loaded) {
            return SafeArea(
              child: DetailContent(),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocConsumer<SeriesDetailCubit, SeriesDetailState>(
        listenWhen: (previously, current) =>
            previously.watchlistMessage != current.watchlistMessage,
        listener: (context, state) {
          final message = state.watchlistMessage;
          print(message);
          if (message.isNotEmpty) {
            if (message == SeriesDetailCubit.watchlistAddSuccessMessage ||
                message == SeriesDetailCubit.watchlistRemoveSuccessMessage) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            } else {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(message),
                    );
                  });
            }
          }
        },
        builder: (context, state) {
          final series = state.data!;
          return Stack(
            children: [
              CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/w500${series.posterPath}',
                width: screenWidth,
                placeholder: (context, url) => Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              Container(
                margin: const EdgeInsets.only(top: 48 + 8),
                child: DraggableScrollableSheet(
                  builder: (context, scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                        color: kRichBlack,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                        right: 16,
                      ),
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    series.name,
                                    style: kHeading5,
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (!state.isAddedToWatchlist) {
                                        await context
                                            .read<SeriesDetailCubit>()
                                            .addWatchlist(series);
                                      } else {
                                        await context
                                            .read<SeriesDetailCubit>()
                                            .removeFromWatchlist(series);
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        state.isAddedToWatchlist
                                            ? Icon(Icons.check)
                                            : Icon(Icons.add),
                                        Text('Watchlist'),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    _showGenres(series.genres),
                                  ),
                                  Text(
                                      "Total Episode : ${series.numberOfEpisode}"),
                                  Row(
                                    children: [
                                      RatingBarIndicator(
                                        rating: series.voteAverage / 2,
                                        itemCount: 5,
                                        itemBuilder: (context, index) => Icon(
                                          Icons.star,
                                          color: kMikadoYellow,
                                        ),
                                        itemSize: 24,
                                      ),
                                      Text('${series.voteAverage}')
                                    ],
                                  ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Overview',
                                    style: kHeading6,
                                  ),
                                  Text(
                                    series.overview,
                                  ),
                                  if (series.lastEpisodeToAir != null)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 16),
                                        Text(
                                          'Last Episode',
                                          style: kHeading6,
                                        ),
                                        ListTile(
                                          isThreeLine: true,
                                          leading: Text(
                                            series.lastEpisodeToAir!
                                                    .episodeNumber
                                                    ?.toString() ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 30,
                                            ),
                                          ),
                                          title: Text(
                                            series.lastEpisodeToAir!.name ?? "",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            series.lastEpisodeToAir!.overview ??
                                                "",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (series.nextEpisodeToAir != null)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 16),
                                        Text(
                                          'Next Episode',
                                          style: kHeading6,
                                        ),
                                        ListTile(
                                          isThreeLine: true,
                                          leading: Text(
                                            series.nextEpisodeToAir!
                                                    .episodeNumber
                                                    ?.toString() ??
                                                "-",
                                            style: TextStyle(
                                              fontSize: 30,
                                            ),
                                          ),
                                          title: Text(
                                            series.nextEpisodeToAir!.name ??
                                                "-",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          subtitle: Text(
                                            series.nextEpisodeToAir!.overview ??
                                                "-",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  if (series.seasons.isNotEmpty)
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 16),
                                        Text(
                                          'List Season',
                                          style: kHeading6,
                                        ),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: series.seasons.length,
                                          itemBuilder: (context, index) {
                                            return CustomListTile(
                                              // isThreeLine: true,
                                              thumbnail: series.seasons[index]
                                                          .posterPath !=
                                                      null
                                                  ? CachedNetworkImage(
                                                      imageUrl:
                                                          'https://image.tmdb.org/t/p/w500${series.seasons[index].posterPath}',
                                                      placeholder:
                                                          (context, url) =>
                                                              Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    )
                                                  : Container(),
                                              title:
                                                  series.seasons[index].name ??
                                                      "-",
                                              description: series.seasons[index]
                                                      .overview ??
                                                  "-",
                                            );
                                          },
                                          separatorBuilder: (_, __) =>
                                              SizedBox(height: 5),
                                        )
                                      ],
                                    ),
                                  SizedBox(height: 16),
                                  Text(
                                    'Recommendations',
                                    style: kHeading6,
                                  ),
                                  BlocBuilder<SeriesDetailCubit,
                                      SeriesDetailState>(
                                    builder: (context, data) {
                                      if (data.recommendationState ==
                                          RequestState.Loading) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else if (data.recommendationState ==
                                          RequestState.Error) {
                                        return Text(data.message);
                                      } else if (data.recommendationState ==
                                          RequestState.Loaded) {
                                        return Container(
                                          height: 150,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final movie = state
                                                  .seriesRecommendations[index];
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: InkWell(
                                                  onTap: () {
                                                    Navigator
                                                        .pushReplacementNamed(
                                                      context,
                                                      SeriesDetailPage
                                                          .ROUTE_NAME,
                                                      arguments: movie.id,
                                                    );
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(8),
                                                    ),
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                      placeholder:
                                                          (context, url) =>
                                                              Center(
                                                        child:
                                                            CircularProgressIndicator(),
                                                      ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Icon(Icons.error),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            itemCount: state
                                                .seriesRecommendations.length,
                                          ),
                                        );
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              color: Colors.white,
                              height: 4,
                              width: 48,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  // initialChildSize: 0.5,
                  minChildSize: 0.25,
                  // maxChildSize: 1.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundColor: kRichBlack,
                  foregroundColor: Colors.white,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              )
            ],
          );
        });
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
