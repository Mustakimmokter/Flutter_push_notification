import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_push_notification/screens/notifications_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   int _notificationId = 0;

  int selectedIndex = 0;

  // final TextEditingController _bodyController = TextEditingController();
  // final TextEditingController _titleController = TextEditingController();
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin? notificationsPlugin;

  // Device Permission
  // Future<void> _notificationPermission()async{
  //
  //   NotificationSettings settings = await _messaging.requestPermission(
  //     alert: true,
  //     announcement: false,
  //     badge: true,
  //     carPlay: false,
  //     criticalAlert: false,
  //     provisional: false,
  //     sound: true,
  //   );
  //
  //   print('User granted permission: ${settings.authorizationStatus}');
  // }

  Future<String> getToken()async{
// use the returned token to send messages to users from your custom server
    String? token = await _messaging.getToken(
      vapidKey: "BGpdLRs......",
    );

    print("--------------${token}___________");
    return token ?? '';
  }

  Future<void> initialNotificationMessage()async{

    // Foreground Notification
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if(message.notification != null){
        _showNotification(message);
        print(message.notification!.body);
      }
    });

    // Background Notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      if(message.notification != null){
        print(message.data);
        print(message.notification!.body);
        Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationsScreen(
          notificationTitle: message.notification!.title,
          notificationBody: message.notification!.body,
        )));
      }
    });

    //Terminated  Notification
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message){
      if(message != null){
        print(message.data);
      }

    });
  }

  Future<void> initNotification()async{
    const initAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initIOS = DarwinInitializationSettings();

    const initSetting = InitializationSettings(android: initAndroid,iOS: initIOS);
    notificationsPlugin = FlutterLocalNotificationsPlugin();
    notificationsPlugin!.initialize(initSetting,onDidReceiveNotificationResponse: (message){
      onSelectedNotification(message);
    });
  }

  Future<void> _showNotification(RemoteMessage payload)async{
    const AndroidNotificationDetails androidNotification = AndroidNotificationDetails(
    'Your chanel id',
    'Your chanel name',
      channelDescription: 'Chanel Description',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      autoCancel: true,
    );
    const DarwinNotificationDetails iosNotification = DarwinNotificationDetails(presentSound: false);


    const notificationPlatformDetails = NotificationDetails(android: androidNotification,iOS: iosNotification);

    notificationsPlugin!.show(
        _notificationId,
      payload.notification!.title,
      payload.notification!.body,
      notificationPlatformDetails,
      payload: jsonEncode(payload.data),
    );
    _notificationId++;

  }

   //When app running onscreen notification click call here
  Future<void> onSelectedNotification(NotificationResponse payload)async{
    Map<String,dynamic> data = jsonDecode(payload.payload!);
    print("____________${data['title']}______________");
    print(payload.payload);
    Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationsScreen(notificationTitle: data['title'], notificationBody: data['body'])));
  }


  @override
  void initState() {
    super.initState();
    getToken();
    initialNotificationMessage();
    initNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Stack(
            children: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const NotificationsScreen()));
              }, icon: const Icon(Icons.notifications)),
              _notificationId > 0? Positioned(
                right: 21,
                bottom: 25,
                child: Text(_notificationId.toString(),style: const TextStyle(color: Colors.red,fontSize: 10),),
              ) : const SizedBox(),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //const CustomText(text: 'Notification',),
            // //const SizedBox(height: 10),
            // TextField(
            //   controller: _titleController,
            //   decoration: const InputDecoration(
            //     //contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
            //     // border: OutlineInputBorder(
            //     //   borderSide: BorderSide.none
            //     // ),
            //     hintText: 'Enter Title',
            //   ),
            //   onChanged: (message){
            //     message = _titleController.text;
            //   },
            // ),
            // const SizedBox(height: 20),
            // TextField(
            //   controller: _bodyController,
            //   keyboardType: TextInputType.multiline,
            //   maxLines: 5,
            //   decoration: const InputDecoration(
            //     contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
            //     border: OutlineInputBorder(),
            //     hintText: 'Enter your message',
            //   ),
            //   onChanged: (message){
            //     message = _bodyController.text;
            //   },
            // ),
            // const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                _messaging.subscribeToTopic('120');
              },
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('Push Local Notification'),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (){
               _messaging.unsubscribeFromTopic('120');
              },
              child: const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text('Push Local Notification'),
              ),
            ),
          ],
        ),
      ),
    );
  }


}
