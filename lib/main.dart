import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pusher_beams/pusher_beams.dart';
import 'package:app/congif_notifications_awasome.dart';

const intanceId = 'b83993d3-705b-49ff-b46d-3599b69a5097';
Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final noti = NotificationsAwesome();
  await noti.initConfg();
  await noti.permissionNotification();
  await PusherBeams.instance.start(intanceId);
  await PusherBeams.instance.addDeviceInterest('debug-hellow');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    noti.crearNotifications(
        title: message.notification!.title.toString(), body: message.notification!.body);
  });
  FirebaseMessaging.onBackgroundMessage(_messageHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
          children: const [],
        ),
      ),
    );
  }
}
