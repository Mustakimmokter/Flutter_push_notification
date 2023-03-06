import 'package:firebase_push_notification/screens/notifications_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);



  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _notificationQty = 0;

  int selectedIndex = 0;

  void getSelectedTab(int index){

      selectedIndex = index;


  }
  final List<String> labels = ['TabOne', 'TabTwo', 'TabThree'];
  final List<Color> labelColors = [Colors.blue,Colors.red,Colors.green];
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Stack(
            children: [
              IconButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>const NotificationsScreen(
                  notificationBody: 'Empty',
                  notificationTitle: 'Empty Body',
                )));
              }, icon: const Icon(Icons.notifications)),
              _notificationQty > 0? Positioned(
                right: 21,
                bottom: 25,
                child: Text(_notificationQty.toString(),style: const TextStyle(color: Colors.red,fontSize: 10),),
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
            //const SizedBox(height: 10),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                //contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                // border: OutlineInputBorder(
                //   borderSide: BorderSide.none
                // ),
                hintText: 'Enter Title',
              ),
              onChanged: (message){
                message = _titleController.text;
              },
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _bodyController,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 6),
                border: OutlineInputBorder(),
                hintText: 'Enter your message',
              ),
              onChanged: (message){
                message = _bodyController.text;
              },
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationsScreen(
                  notificationTitle: _titleController.text,
                  notificationBody: _bodyController.text,
                )));
                // _titleController.clear();
                //  _bodyController.clear();
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
