import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_pocket/blocs/event_states/event_states.dart';
import 'package:news_pocket/models/news.dart';
import 'package:news_pocket/service/service.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final Map<String, List<News>> _newsCache = {};

  NewsBloc() : super(NewsUninitialized()) {
    on<NewsFetch>(_onFetchNews);
  }

  Future<void> _onFetchNews(NewsFetch event, Emitter<NewsState> emit) async {
    final slug = event.categorySlug;

    try {
      // Cek cache sebelum fetch
      if (!_newsCache.containsKey(slug)) {
        emit(NewsLoading());

        final newsFromApi = await Service.getNews(slug);
        _newsCache[slug] = newsFromApi;
      }

      emit(NewsFetchSuccess(news: _newsCache[slug]!));
    } catch (err, trace) {
      onError(err, trace);

      emit(NewsError());
    }
  }
}
