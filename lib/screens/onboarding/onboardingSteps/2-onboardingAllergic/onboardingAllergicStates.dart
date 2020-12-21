import 'package:EasyGroceries/services/database/config.dart';
import 'package:EasyGroceries/services/database/database.dart';
import 'package:EasyGroceries/services/database/models/accountTag.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class OnboardingAllergicStates extends GetxController {
  static OnboardingAllergicStates get to => Get.find();

  initTags() async {
    final List tags = await API.tag.getTags(tagAllergyEndpoint);
    final accountTags = await API.accountTag.getFromUid(
        FirebaseAuth.instance.currentUser.uid, endpointAccountTagAllergy);
    tagsStates.clear();
    tags.forEach((element) {
      tagsStates.add({"title": element, "active": false, "uid": ""});
    });
    accountTags.forEach((key, value) {
      tagsStates[value["tagId"]]["uid"] = key;
      tagsStates[value["tagId"]]["active"] = true;
    });
    return true;
  }

  setTag(int index, bool active) {
    tagsStates[index]["active"] = active;
  }

  pushTags() async {
    for (int i = 0; i < tagsStates.length; i++) {
      if (tagsStates[i]["active"] && tagsStates[i]["uid"] == "") {
        AccountTag accountTag = new AccountTag();
        accountTag.tagId = i;
        accountTag.createdAt = DateTime.now().toUtc().toString();
        accountTag.updatedAt = DateTime.now().toUtc().toString();
        await API.accountTag.create(accountTag, endpointAccountTagAllergy);
      } else if (!tagsStates[i]["active"] && tagsStates[i]["uid"] != "")
        await API.accountTag
            .delete(endpointAccountTagAllergy, tagsStates[i]["uid"]);
    }
  }

  RxList<dynamic> tagsStates = List<dynamic>().obs;
}
