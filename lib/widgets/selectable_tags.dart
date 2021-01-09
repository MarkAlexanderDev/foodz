import 'package:EasyGroceries/style/colors.dart';
import 'package:EasyGroceries/style/text_style.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';

class SelectableTags extends StatelessWidget {
  final List<ItemTags> _items = List<ItemTags>();
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  final onClickTag;
  final tagStates;
  final player = AudioCache(prefix: 'sounds/');

  SelectableTags({@required this.onClickTag, this.tagStates}) {
    player.loadAll(['tag_select.mp3', 'tag_unselect.mp3']);
    for (var i = 0; i < tagStates.length; i++)
      _items.add(new ItemTags(
        index: i,
        title: tagStates[i]["title"],
        active: tagStates[i]["active"],
      ));
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
          active: _items[index].active,
          textStyle: textStyleTags,
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          textActiveColor: Colors.black,
          activeColor: mainColor,
          splashColor: mainColor,
          onPressed: (tag) {
            tag.active
                ? player.play('tag_select.mp3')
                : player.play('tag_unselect.mp3');
            onClickTag(tag);
          },
        );
      },
    );
  }
}
