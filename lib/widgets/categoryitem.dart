import 'package:flutter/material.dart';
import 'package:flutter_word_guesser/data/gamecategory.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CategoryItem extends StatefulWidget {
  final GameCategory category;
  final Function() onTap;

  // You can also pass the translation in here if you want to
  CategoryItem({Key key, this.category, this.onTap}) : super(key: key);

  @override
  _CategoryItemState createState() => _CategoryItemState();
}

class _CategoryItemState extends State<CategoryItem> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (e) => _mouseEnter(true),
      onExit: (e) => _mouseEnter(false),
      child: AnimatedContainer(
        height: 70,
        child: ListTile(
          leading: Icon(MdiIcons.dog),
          title: Text(widget.category.name),
          subtitle: Text("Category"),
          onTap: widget.onTap,
        ),
        duration: Duration(seconds: 1),
        color: _hovering ? Colors.black12 : Colors.white,
        curve: Curves.fastOutSlowIn,
      ),
    );
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _hovering = hover;
    });
  }
}
