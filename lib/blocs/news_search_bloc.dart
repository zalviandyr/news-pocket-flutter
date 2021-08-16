import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_pocket/blocs/event_states/event_states.dart';
import 'package:news_pocket/models/models.dart';
import 'package:news_pocket/service/service.dart';

class NewsSearchBloc extends Bloc<NewsEvent, NewsState> {
  NewsSearchBloc() : super(NewsUninitialized());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    try {
      if (event is NewsSearchFetch) {
        yield NewsLoading();

        List<News> searchNews = await Service.searchNews(event.keyword);

        yield NewsSearchFetchSuccess(news: searchNews);
      }
    } catch (err) {
      print(err);
      yield NewsError();
    }
  }
}
