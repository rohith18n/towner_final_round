import 'package:get/get.dart';
import 'package:towner_final_round/controllers/id_card_controller.dart';
import 'package:towner_final_round/controllers/student_controller.dart';

class Init extends Bindings {
  @override
  void dependencies() {
    Get.put(StudentController());
    Get.put(IdCardController());
    // Get.put(ListController());
  }
}
