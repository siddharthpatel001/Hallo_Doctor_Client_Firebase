import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/models/doctor_model.dart';
import 'package:hallo_doctor_client/app/models/order_detail_model.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/doctor_service.dart';
import 'package:hallo_doctor_client/app/service/payment_service.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';
import 'package:hallo_doctor_client/app/utils/constants/constants.dart';
import 'package:intl/intl.dart';

class DetailOrderController extends GetxController {
  //TODO: Implement DetailOrderController

  final count = 0.obs;
  final username = ''.obs;
  final UserService userService = Get.find();
  List<OrderDetailModel> orderDetail = List.empty();
  TimeSlot selectedTimeSlot = Get.arguments[0];
  Doctor doctor = Get.arguments[1];
  PaymentService paymentService = Get.find();
  late String clientSecret;
  @override
  void onInit() {
    super.onInit();
    userService.getUsername().then((value) {
      username.value = value;
    });
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  OrderDetailModel buildOrderDetail() {
    var formatter = DateFormat('yyyy-MM-dd hh:mm');
    var time = formatter.format(selectedTimeSlot.timeSlot!);

    var orderDetail = OrderDetailModel(
        itemId: selectedTimeSlot.timeSlotId!,
        itemName: 'Consultation with ' + doctor.doctorName!,
        time: time,
        duration: selectedTimeSlot.duration.toString() + ' minute',
        price: currencySign + selectedTimeSlot.price.toString());
    return orderDetail;
  }

  void makePayment() async {
    EasyLoading.show();
    try {
      var clientSecret = await paymentService.getClientSecret(
          selectedTimeSlot.timeSlotId!, userService.getUserId());
      if (clientSecret.isEmpty) return;

      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        applePay: true,
        googlePay: true,
        testEnv: true,
        merchantCountryCode: 'US',
        merchantDisplayName: 'Helo Doctor',
        paymentIntentClientSecret: clientSecret,
      ));
      EasyLoading.dismiss();
      await Stripe.instance.presentPaymentSheet();
      Get.offNamed('/payment-success', arguments: selectedTimeSlot);
    } catch (err) {
      Fluttertoast.showToast(msg: err.toString());
      return null;
    } finally {}
  }
}
