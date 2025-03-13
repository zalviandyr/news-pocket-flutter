import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_pocket/blocs/event_states/event_states.dart';
import 'package:news_pocket/service/service.dart';

class NewsSearchBloc extends Bloc<NewsSearchFetch, NewsState> {
  NewsSearchBloc() : super(NewsUninitialized()) {
    on<NewsSearchFetch>(_onSearchNews);
  }

  Future<void> _onSearchNews(
      NewsSearchFetch event, Emitter<NewsState> emit) async {
    try {
      emit(NewsLoading());
      final searchNews = await Service.searchNews(event.keyword);
      emit(NewsSearchFetchSuccess(news: searchNews));
    } catch (err) {
      print(err);
      emit(NewsError());
    }
  }
}
