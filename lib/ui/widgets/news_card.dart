import 'package:cached_network_image/cached_network_image.dart';
import 'package:news_pocket/models/models.dart';
import 'package:shimmer/shimmer.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter/material.dart';

class NewsCard extends StatelessWidget {
  final News? news;
  final Function(News)? onTap;
  final bool isLoading;

  const NewsCard({required this.news, required this.onTap})
      : this.isLoading = false;
  const NewsCard.loading()
      : this.news = null,
        this.onTap = null,
        this.isLoading = true;

  @override
  Widget build(BuildContext context) {
    // add locale id
    timeago.setLocaleMessages('id', timeago.IdMessages());

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isLoading
              ? Shimmer.fromColors(
                  highlightColor: Colors.grey.shade300,
                  baseColor: Colors.grey,
                  child: Container(
                    width: double.infinity,
                    height: 180.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey,
                    ),
                  ),
                )
              : Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: CachedNetworkImage(
                        imageUrl: news!.urlToImage,
                        height: 180.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, imageUrl) {
                          return Shimmer.fromColors(
                            highlightColor: Colors.grey.shade300,
                            baseColor: Colors.grey,
                            child: Container(
                              width: double.infinity,
                              height: 180.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.grey,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      left: 15.0,
                      bottom: 15.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          news!.source,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 15.0,
                      top: 15.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 7.0),
                            Text(
                              timeago.format(
                                news!.publishedAt,
                                locale: 'id',
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15.0),
                        child: InkWell(
                          onTap: () => onTap!(news!),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 10.0),
          isLoading
              ? Shimmer.fromColors(
                  highlightColor: Colors.grey.shade300,
                  baseColor: Colors.grey,
                  child: Container(
                    height: 30.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.grey,
                    ),
                  ))
              : Text(
                  news!.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline6,
                ),
        ],
      ),
    );
  }
}
