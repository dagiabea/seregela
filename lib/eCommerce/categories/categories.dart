import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import '../utils/OnHover.dart';
import '../utils/k_padding.dart';
import '../utils/responsive.dart';

// We need satefull widget for our categories

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "All",
    "Beverage",
    "Personal Care",
    "Food",
    "Home Care",
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: kPadding,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            categories.length,
            (index) => Padding(
                padding: EdgeInsets.only(
                    bottom: kPadding / 4,
                    top: kPadding / 4,
                    right: kPadding,
                    left: index == 0 ? kPadding : 0),
                child: kIsWeb
                    ? OnHover(builder: (isHovered) {
                        final color = isHovered
                            ? Colors.white.withOpacity(0.8)
                            : Theme.of(context).secondaryHeaderColor;
                        return listCategories(index, color, context);
                      })
                    : listCategories(index,
                        Theme.of(context).secondaryHeaderColor, context)),
          ),
        ),
      ),
    );
  }

  ElevatedButton listCategories(int index, Color color, BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          padding: MaterialStateProperty.all(
            const EdgeInsets.all(
              kPadding,
            ),
          ),
          backgroundColor: MaterialStateProperty.all(
              selectedIndex == index ? Colors.white.withOpacity(0.8) : color)),
      child: Text(
        categories[index],
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: selectedIndex == index
              ? Theme.of(context).primaryColor
              : Colors.black.withOpacity(0.3),
        ),
      ),
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}
