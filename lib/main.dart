import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_client/app/service/notification_service.dart';
import 'package:hallo_doctor_client/app/utils/environment.dart';
import 'package:hallo_doctor_client/app/utils/localization.dart';
import 'app/routes/app_pages.dart';
import 'app/service/firebase_service.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await Firebase.initializeApp();
  NotificationService();
  bool isUserLogin = await FirebaseService().checkUserAlreadyLogin();
  Stripe.publishableKey = Environment.stripePublishableKey;
  initializeDateFormatting('en', null);
  FirebaseChatCore.instance
      .setConfig(FirebaseChatCoreConfig(null, 'Rooms', 'Users'));
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: isUserLogin ? AppPages.DASHBOARD : AppPages.LOGIN,
      getPages: AppPages.routes,
      builder: EasyLoading.init(),
      localizationsDelegates: [
        FormBuilderLocalizations.delegate,
      ],
      locale: LocalizationService.locale,
      translations: LocalizationService(),
    ),
  );
}
