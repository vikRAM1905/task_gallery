import 'package:gallary_task/model/gallery_model.dart';
import 'package:get/get.dart';

import '../services/api_services.dart';

class GalleryController extends GetxController {
  var count = 0.obs;
  increment() => count++;

  Future<dynamic> getImages() async {
    var response = await ApiService().get();
    // return GalleryModel.fromJson(response);
    return response;
  }
}
