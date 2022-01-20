import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hallo_doctor_client/app/models/order_model.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';

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

  confirmOrder(TimeSlot timeSlot, User user) async {
    // QueryBuilder<ParseObject> query = QueryBuilder(ParseObject('Order'));
    // //  ..whereEqualTo('doctorSchedule', timeSlot.toPointer());
    // //..whereEqualTo('user', user.toPointer());

    // ParseResponse apiResponse = await query.query();
    // if (apiResponse.success && apiResponse.results != null) {
    //   print('success get order data');
    //   await _setOrderComplete(apiResponse.results!.elementAt(0) as ParseObject);
    //   var list = apiResponse.results!;
    //   return list;
    // } else {
    //   return Future.error(apiResponse.error!.message);
    // }
  }

  _setOrderComplete(Object order) async {
    // order.set('status', 'complete');
    // final ParseResponse apiResponse = await order.update();
    // if (apiResponse.success) {
    //   print('success complete order');
    // } else {
    //   return Future.error(apiResponse.error!.message);
    // }
    // order.update();
  }
}
