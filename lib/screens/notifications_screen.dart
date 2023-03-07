import 'package:firebase_push_notification/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({
    Key? key,
    this.notificationTitle,
    this.notificationBody,
  }) : super(key: key);
  final String? notificationTitle, notificationBody;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: notificationBody != null && notificationTitle != null? ListView.builder(
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
            padding:
            const EdgeInsets.only(left: 20, right: 30, top: 15, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: notificationTitle!),
                CustomText(
                  text: notificationBody!,
                  fontWeight: FontWeight.normal,
                  size: 15,
                ),
              ],
            ),
          );
        },
      ):
      const Center(child: CustomText(text: 'No notification',),),
    );
  }
}
