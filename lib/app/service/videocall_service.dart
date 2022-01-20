import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';

typedef RoomAvailableCallBack = void Function(dynamic data);
typedef RemoteCandidateCallBack = void Function(
    dynamic candidate, dynamic sdpMid, dynamic sdpMLineIndex);

class VideoCallService {
  RoomAvailableCallBack? onRoomAvailable;
  RemoteCandidateCallBack? onGetRemoteCandidate;
  StreamSubscription? _roomStream;

  final database = FirebaseDatabase.instance.ref();

  Future<bool> getRoom(TimeSlot timeSlot) async {
    // QueryBuilder<ParseObject> query =
    //     QueryBuilder<ParseObject>(ParseObject('LiveRoom'))
    //       // ..whereEqualTo('timeSlot', timeSlot.toPointer())
    //       ..orderByDescending('createdAt');
    // ParseResponse apiResponse = await query.query();
    // if (apiResponse.success && apiResponse.results != null) {
    //   //room = apiResponse.results!.elementAt(0);
    //   return true;
    // } else {
    //   return false;
    // }
    return false;
  }

  startListeningRoom(TimeSlot timeSlot) {
    // _roomStream = database.child('/room/').onValue.listen((event) {
    //   final
    // });
  }
  stopListeningRoom() {
    _roomStream!.cancel();
  }
}
