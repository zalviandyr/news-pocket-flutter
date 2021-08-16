import 'package:equatable/equatable.dart';
import 'package:news_pocket/models/models.dart';

abstract class NewsState extends Equatable {
  NewsState();
}

class NewsUninitialized extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsLoading extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsError extends NewsState {
  @override
  List<Object?> get props => [];
}

class NewsFetchSuccess extends NewsState {
  final List<News> news;

  NewsFetchSuccess({required this.news});

  @override
  List<Object?> get props => [news];
}

class NewsSearchFetchSuccess extends NewsState {
  final List<News> news;

  NewsSearchFetchSuccess({required this.news});

  @override
  List<Object?> get props => [news];
}
