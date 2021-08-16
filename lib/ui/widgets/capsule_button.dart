import 'package:flutter/material.dart';
import 'package:news_pocket/models/models.dart';

class CapsuleButton extends StatelessWidget {
  final Category category;
  final Function(Category) onTap;
  final bool isSelected;

  const CapsuleButton({
    required this.category,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(50.0),
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7.0),
        child: InkWell(
          borderRadius: BorderRadius.circular(50.0),
          onTap: () => onTap(category),
          child: Container(
            width: 135.0,
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              border: Border.all(
                  color: isSelected ? Colors.transparent : Colors.grey),
              color: isSelected ? Colors.grey.shade500 : Colors.transparent,
            ),
            child: Text(
              category.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: isSelected ? Colors.white : Colors.black,
                    letterSpacing: 1.0,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
