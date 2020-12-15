import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/textStyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class SelectableTags extends StatelessWidget {
  final List tagTitles;
  final List<ItemTags> _items = List<ItemTags>();
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();

  SelectableTags(this.tagTitles) {
    for (var i = 0; i < tagTitles.length; i++)
      _items.add(new ItemTags(index: i, title: tagTitles[i]));
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
          textStyle: textStyleTags,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          textActiveColor: Colors.black,
          activeColor: mainColor,
          splashColor: mainColor,
          onPressed: (item) => print(item),
        );
      },
    );
  }

  _getSelectedTags() {
    final List<Item> list = _tagStateKey.currentState?.getAllItem;
    if (list != null)
      list.where((a) => a.active == true).forEach((a) => print(a.title));
  }
}
