import 'package:EasyGroceries/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class SelectableTags extends StatefulWidget {
  final List tagTitles;
  SelectableTags(this.tagTitles);

  @override
  _SelectableTagsState createState() => _SelectableTagsState();
}

class _SelectableTagsState extends State<SelectableTags> {
  List<ItemTags> _items = List<ItemTags>();

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < widget.tagTitles.length; i++)
      _items.add(new ItemTags(index: i, title: widget.tagTitles[i]));
  }

  @override
  Widget build(BuildContext context) {
    return Tags(
      key: _tagStateKey,
      itemCount: _items.length,
      spacing: 12.0,
      runSpacing: 16.0,
      itemBuilder: (int index) {
        final item = _items[index];

        return ItemTags(
          key: Key(index.toString()),
          index: index,
          title: item.title,
          active: false,
          textStyle: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          textActiveColor: Colors.black,
          activeColor: mainColor,
          splashColor: mainColor,
          onPressed: (item) => print(item),
        );
      },
    );
  }

  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  // Allows to get all the active ItemTags
  _getAllItem() {
    List<Item> list = _tagStateKey.currentState?.getAllItem;
    if (list != null)
      list.where((a) => a.active == true).forEach((a) => print(a.title));
  }
}
