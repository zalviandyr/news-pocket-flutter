import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_pocket/blocs/blocs.dart';
import 'package:news_pocket/blocs/event_states/event_states.dart';
import 'package:news_pocket/models/models.dart';
import 'package:news_pocket/ui/screens/screens.dart';
import 'package:news_pocket/ui/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NewsBloc _newsBloc;
  late Category _curCategory;
  final List<Category> _categories = [
    Category(name: 'General', slug: 'general'),
    Category(name: 'Business', slug: 'business'),
    Category(name: 'Entertainment', slug: 'entertainment'),
    Category(name: 'Health', slug: 'health'),
    Category(name: 'Science', slug: 'science'),
    Category(name: 'Sports', slug: 'sports'),
    Category(name: 'Technology', slug: 'technology'),
  ];

  @override
  void initState() {
    _newsBloc = BlocProvider.of<NewsBloc>(context);

    // get news
    _curCategory = _categories.first;
    _newsBloc.add(NewsFetch(categorySlug: _curCategory.slug));

    super.initState();
  }

  void _capsuleAction(Category category) {
    setState(() => _curCategory = category);

    _newsBloc.add(NewsFetch(categorySlug: category.slug));
  }

  void _searchAction() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => SearchScreen()));
  }

  void _newsCardAction(News news) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => DetailScreen(news: news)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) {
            return [
              _buildHeader(),
              _buildSearchBar(),
              _buildCategories(),
            ];
          },
          body: Stack(
            children: _categories
                .map(
                  (e) => Offstage(
                    offstage: e != _curCategory,
                    child: BlocBuilder<NewsBloc, NewsState>(
                        builder: (context, state) {
                      return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          if (state is NewsFetchSuccess) {
                            News news = state.news[index];
                            return NewsCard(
                              news: news,
                              onTap: _newsCardAction,
                            );
                          }

                          return NewsCard.loading();
                        },
                        itemCount:
                            state is NewsFetchSuccess ? state.news.length : 1,
                      );
                    }),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'News Pocket',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 5.0),
            Text(
              'Berita dari negara indonesia',
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ],
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
      flexibleSpace: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: MaterialButton(
          onPressed: _searchAction,
          height: 70.0,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          color: Colors.grey.shade300,
          child: Row(
            children: [
              Icon(Icons.search),
              const SizedBox(width: 7.0),
              Text('Cari berita'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategories() {
    return SliverAppBar(
      pinned: true,
      elevation: 0.0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      flexibleSpace: Center(
        child: ListView(
          padding: const EdgeInsets.only(top: 10.0),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          children: _categories
              .map(
                (e) => Wrap(
                  children: [
                    CapsuleButton(
                      category: e,
                      onTap: _capsuleAction,
                      isSelected: e == _curCategory,
                    ),
                  ],
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
