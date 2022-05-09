import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:hallo_doctor_client/app/models/time_slot_model.dart';

typedef RoomAvailableCallBack = void Function(dynamic data);
typedef RemoteCandidateCallBack = void Function(
    dynamic candidate, dynamic sdpMid, dynamic sdpMLineIndex);

class VideoCallService {
  RoomAvailableCallBack? onRoomAvailable;
  RemoteCandidateCallBack? onGetRemoteCandidate;

  Future removeRoom(String roomId) async {
    try {
      await FirebaseFirestore.instance
          .collection('RoomVideoCall')
          .doc(roomId)
          .delete();
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
