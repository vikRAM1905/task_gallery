import 'package:gallary_task/controller/gallery_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class GetBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GalleryController>(() => GalleryController());
  }
}
