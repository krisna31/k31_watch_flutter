import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k31_watch_flutter/common/route_observer.dart';
import 'package:k31_watch_flutter/presentation/bloc/watch_list_tv_series_bloc.dart';
import 'package:k31_watch_flutter/presentation/widgets/tv_series_list_widget.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  // ignore: constant_identifier_names
  static const ROUTE_NAME = '/watchlist-tv-series';

  const WatchlistTvSeriesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WatchlistTvSeriesPageState createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context
        .read<WatchListTvSeriesBloc>()
        .add(FetchWatchListTvSeriesEvent()));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchListTvSeriesBloc>().add(FetchWatchListTvSeriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchListTvSeriesBloc, WatchListTvSeriesState>(
          builder: (context, data) {
            switch (data) {
              case WatchListTvSeriesLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case WatchListTvSeriesHasData():
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return TvSeriesListWidget(
                      tvData: data.tvSeries[index],
                    );
                  },
                  itemCount: data.tvSeries.length,
                );
              case WatchListTvSeriesError():
                return const Center(
                  child: Text('Error'),
                );
              default:
                return const Center(
                  child: Text('Error'),
                );
            }
          },
        ),
      ),
    );
  }
}
