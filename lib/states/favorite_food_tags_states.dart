import 'package:EasyGroceries/services/database/config.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account_tag_model.dart';
import 'package:EasyGroceries/widgets/selectable_tags.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FavoriteFoodTagsStates extends GetxController {
  static FavoriteFoodTagsStates get to => Get.find();

  Future<bool> getTags() async {
    if (tags.isEmpty) {
      final List cuisineTags = await API.tag.getTags(endpointTagCuisine);
      final accountTags = await API.accountTag.getFromUid(
          FirebaseAuth.instance.currentUser.uid, endpointAccountTagCuisine);
      tags.clear();
      cuisineTags.forEach((tag) {
        tags.add(TagModel(uid: "", title: tag, active: false));
      });
      accountTags.forEach((key, value) {
        tags[value["tagId"]].uid = key;
        tags[value["tagId"]].active = true;
      });
    }
    return true;
  }

  setTag(int index, bool active) {
    tags[index].active = active;
  }

  Future<void> updateTags() async {
    for (int i = 0; i < tags.length; i++) {
      if (tags[i].active && tags[i].uid == "") {
        AccountTagModel accountTag = new AccountTagModel();
        accountTag.tagId = i;
        accountTag.createdAt = DateTime.now().toUtc().toString();
        accountTag.updatedAt = DateTime.now().toUtc().toString();
        await API.accountTag.create(accountTag, endpointAccountTagCuisine);
      } else if (!tags[i].active && tags[i].uid != "")
        await API.accountTag.delete(endpointAccountTagCuisine, tags[i].uid);
    }
  }

  RxList<TagModel> tags = List<TagModel>().obs;
}
