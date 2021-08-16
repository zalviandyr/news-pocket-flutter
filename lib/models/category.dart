import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String slug;

  Category({
    required this.name,
    required this.slug,
  });

  @override
  String toString() {
    return 'Category (name: $name, slug: $slug)';
  }

  @override
  List<Object?> get props => [name, slug];
}
