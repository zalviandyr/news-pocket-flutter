import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_pocket/blocs/event_states/event_states.dart';
import 'package:news_pocket/models/news.dart';
import 'package:news_pocket/service/service.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final List<Map<String, List<News>>> _news = [];
  NewsBloc() : super(NewsUninitialized());

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    try {
      if (event is NewsFetch) {
        String slug = event.categorySlug;

        // check jika belum ada list
        var search = _news.where((element) => element.keys.first == slug);
        if (_news.isEmpty || search.isEmpty) {
          yield NewsLoading();

          // simpan hasil news sesuai category
          List<News> newsFromApi = await Service.getNews(slug);
          _news.add({slug: newsFromApi});
        }

        List<News> news = _news
            .where((element) => element.keys.first == slug)
            .first
            .values
            .first;
        yield NewsFetchSuccess(news: news);
      }
    } catch (err) {
      print(err);
      yield NewsError();
    }
  }
}
