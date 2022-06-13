import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';

class NotificationsAwesome {
  final awesoneNotification = AwesomeNotifications();

  Future initConfg() async {
    await awesoneNotification.initialize(
      'resource://drawable/logo',
      [
        NotificationChannel(
          icon: 'resource://drawable/logo',
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
        )
      ],
      debug: true,
    );
  }

  Future permissionNotification() async {
    await awesoneNotification.isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  crearNotifications({String title = 'Titulo Notificacion', dynamic body}) {
    awesoneNotification.createNotification(
      content: NotificationContent(
        id: DateTime.now().millisecond,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
    );
  }
}
