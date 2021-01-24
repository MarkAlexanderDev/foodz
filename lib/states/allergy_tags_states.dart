import 'package:EasyGroceries/services/database/config.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/account_tag_model.dart';
import 'package:EasyGroceries/widgets/selectable_tags.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AllergyTagsStates extends GetxController {
  static AllergyTagsStates get to => Get.find();

  Future<bool> getTags() async {
    if (tags.isEmpty) {
      final List tagsAvailable = await API.tag.getTags(endpointTagAllergy);
      final accountTags = await API.accountTag.getFromUid(
          FirebaseAuth.instance.currentUser.uid, endpointAccountTagAllergy);
      tags.clear();
      tagsAvailable.forEach((tag) {
        tags.add(TagModel(title: tag, active: false, uid: ""));
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
        AccountTagModel accountTag = AccountTagModel();
        accountTag.tagId = i;
        accountTag.createdAt = DateTime.now().toUtc().toString();
        accountTag.updatedAt = DateTime.now().toUtc().toString();
        await API.accountTag.create(accountTag, endpointAccountTagAllergy);
      } else if (!tags[i].active && tags[i].uid != "")
        await API.accountTag.delete(endpointAccountTagAllergy, tags[i].uid);
    }
  }

  RxList<TagModel> tags = List<TagModel>().obs;
}
