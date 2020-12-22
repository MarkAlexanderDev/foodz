import 'package:EasyGroceries/screens/home/contextual_area/ca_card.dart';
import 'package:EasyGroceries/screens/home/contextual_area/contextual_area_states.dart';
import 'package:EasyGroceries/style/swiper_pagination_style.dart';
import 'package:EasyGroceries/widgets/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class ContextualArea extends StatefulWidget {
  @override
  _ContextualArea createState() => _ContextualArea();
}

class _ContextualArea extends State<ContextualArea> {
  final ContextualAreaStates contextualAreaStates =
      Get.put(ContextualAreaStates());
  Future _future;

  @override
  void initState() {
    _future = contextualAreaStates.getSlideData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            final List slides = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Swiper(
                autoplay: true,
                autoplayDelay: 10000,
                duration: 500,
                itemCount: slides.length,
                outer: true,
                loop: true,
                pagination: getCustomSwiperPagination(),
                itemBuilder: (BuildContext context, int index) {
                  return CAcard(
                    slide: slides[index],
                  );
                },
              ),
            );
          } else
            return Loading();
        });
  }
}
