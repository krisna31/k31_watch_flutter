import 'package:flutter/material.dart';
import 'package:k31_watch_flutter/common/request_state.dart';
import 'package:k31_watch_flutter/common/route_observer.dart';
import 'package:k31_watch_flutter/presentation/providers/watch_list_tv_series_notifier.dart';
import 'package:k31_watch_flutter/presentation/widgets/tv_series_list_widget.dart';
import 'package:provider/provider.dart';

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
        Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
            .fetchWatchlistTvSeriess());
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
    Provider.of<WatchlistTvSeriesNotifier>(context, listen: false)
        .fetchWatchlistTvSeriess();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistTvSeriesNotifier>(
          builder: (context, data, child) {
            switch (data.watchlistState) {
              case RequestState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case RequestState.loaded:
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return TvSeriesListWidget(
                      tvData: data.watchlistTvSeriess[index],
                    );
                  },
                  itemCount: data.watchlistTvSeriess.length,
                );
              default:
                return Center(
                  key: const Key('error_message'),
                  child: Text(data.message),
                );
            }
          },
        ),
      ),
    );
  }
}
