import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_pocket/blocs/blocs.dart';
import 'package:news_pocket/blocs/event_states/event_states.dart';
import 'package:news_pocket/models/models.dart';
import 'package:news_pocket/ui/widgets/widgets.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late NewsSearchBloc _newsSearchBloc;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    _newsSearchBloc = BlocProvider.of<NewsSearchBloc>(context);

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();

    super.dispose();
  }

  void _searchAction(String keyword) {
    _newsSearchBloc.add(NewsSearchFetch(keyword: keyword));
  }

  void _newsCardAction(News news) {
    print(news.title);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) {
            return [
              _buildSearchBar(),
            ];
          },
          body: BlocBuilder<NewsSearchBloc, NewsState>(
            builder: (context, state) {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                itemBuilder: (context, index) {
                  if (state is NewsSearchFetchSuccess) {
                    News news = state.news[index];
                    return NewsCard(
                      news: news,
                      onTap: _newsCardAction,
                    );
                  }

                  return NewsCard.loading();
                },
                itemCount: state is NewsSearchFetchSuccess
                    ? state.news.length
                    : state is NewsUninitialized
                        ? 0
                        : 1,
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return SliverAppBar(
      floating: true,
      snap: true,
      elevation: 0.0,
      toolbarHeight: 80.0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: TextFormField(
          maxLines: 1,
          controller: _searchController,
          onFieldSubmitted: _searchAction,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  style: BorderStyle.none,
                  width: 0.0,
                ),
              ),
              prefixIcon: Icon(Icons.search),
              fillColor: Colors.grey.shade300,
              filled: true,
              hintText: 'Search'),
        ),
      ),
    );
  }
}
