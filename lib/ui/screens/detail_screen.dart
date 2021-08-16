import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_pocket/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatefulWidget {
  final News news;

  const DetailScreen({required this.news});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  String _formatDate(DateTime dateTime) =>
      DateFormat('MMMM dd, yyyy').format(dateTime);

  void _toBrowser() => launch(widget.news.url);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          children: [
            Text(
              widget.news.title,
              style: Theme.of(context).textTheme.headline4,
            ),
            const SizedBox(height: 15.0),
            Text(
              '${_formatDate(widget.news.publishedAt)} by ${widget.news.author}',
            ),
            const SizedBox(height: 15.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: CachedNetworkImage(
                imageUrl: widget.news.urlToImage,
                height: 300.0,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 7.0),
            Text(
              'Credit, ${widget.news.source}',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10.0),
            Text(widget.news.description),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: _toBrowser,
              child: Text(
                'Klik untuk melihat berita selengkapnya',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
