import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  NewsEvent();
}

class NewsFetch extends NewsEvent {
  final String categorySlug;

  NewsFetch({required this.categorySlug});

  @override
  List<Object?> get props => [categorySlug];
}

class NewsSearchFetch extends NewsEvent {
  final String keyword;

  NewsSearchFetch({required this.keyword});

  @override
  List<Object?> get props => [keyword];
}
