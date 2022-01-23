import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hallo_doctor_client/app/models/order_model.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';
import 'package:hallo_doctor_client/app/service/user_service.dart';

class OrderService {
  Future<Order> getOrder(TimeSlot timeSlot) async {
    try {
      var orderSnapshot = await FirebaseFirestore.instance
          .collection('Order')
          .where('timeSlotId', isEqualTo: timeSlot.timeSlotId)
          .where('status', isEqualTo: 'payment_success')
          .limit(1)
          .get();
      var data = orderSnapshot.docs.elementAt(0).data();
      data['orderId'] = orderSnapshot.docs.elementAt(0).reference.id;
      Order order = Order.fromMap(data);
      return order;
    } on FirebaseException catch (e) {
      return Future.error(e.message!);
    }
  }

  confirmOrder(TimeSlot timeSlot) async {
    try {
      print('timeslot id : ' + timeSlot.timeSlotId!);
      var orderRef = await FirebaseFirestore.instance
          .collection('Order')
          .where('userId', isEqualTo: UserService().getUserId())
          .where('timeSlotId', isEqualTo: timeSlot.timeSlotId)
          .get();
      var order = orderRef.docs.single;
      await order.reference.update({'status': 'success'});
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
