import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_push_notification/screens/home_screen.dart';
import 'package:flutter/material.dart';

Future<void> main()async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await AwesomeNotifications().initialize(
  //   // Set the 'scheduleTimeZone' parameter to your local timezone
  //   'resource://drawable/notification_icon',
  //   [
  //     NotificationChannel(
  //       channelKey: 'basic_channel',
  //       playSound: true,
  //       channelName: 'Basic notifications',
  //       channelDescription: 'Notification channel for basic notifications',
  //       defaultColor: Colors.teal,
  //       ledColor: Colors.tealAccent,
  //     ),
  //   ],
  // );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase notification',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const HomeScreen(),
    );
  }
}
