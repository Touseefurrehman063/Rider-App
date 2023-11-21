import 'package:get/get.dart';

class MyController extends GetxController {
  var myValue = "Yes".obs; // Initialize the value as an observable

  void updateValue(val) {
    myValue.value=val; 
    update();// Modify the value
  }
}