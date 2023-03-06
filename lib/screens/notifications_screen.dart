import 'package:firebase_push_notification/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({
    Key? key,
    required this.notificationTitle,
    required this.notificationBody,
  }) : super(key: key);
  final String? notificationTitle, notificationBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 30, top: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: notificationTitle ?? 'Notification Title'),
                CustomText(
                  text: notificationBody ??
                      'A text is a passage of words that conveys a set of meanings to the person who is'
                      ' reading it. It\'s a body of written work, in various forms and structures, '
                      'that can be words, phrases and sentences that piece together a passage of written work.',
                  fontWeight: FontWeight.normal,
                  size: 15,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
