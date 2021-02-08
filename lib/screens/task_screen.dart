import './job-AC.dart';
import './job-mechanical.dart';
import './job-Gardener.dart';
import './job-electrician.dart';
import './job-Mason.dart';
import './job-painting.dart';
import './job-plumber.dart';
import './job-welder.dart';
import 'package:final_year_project/utility/push_notification.dart';

import '../providers/user.dart';
import '../providers/users.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import '../providers/auth.dart';
import 'package:provider/provider.dart';
import '../screens/profile.dart';
import './app_drawer.dart';
import 'package:flutter/material.dart';

 
class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  var fcm;
  //PushNotificationsManager pushNotify = new PushNotificationsManager();
 
  @override
  void initState() {
    
    //getfcmToken();
//     Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
//   if (message.containsKey('data')) {
//     // Handle data message
//     final dynamic data = message['data'];
//   }

//   if (message.containsKey('notification')) {
//     // Handle notification message
//     final dynamic notification = message['notification'];
//   }

//   // Or do other work.
// }
  //  print("FUNCTION SE PEHLE");
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Users>(context).fetchAndSetUsers();
    });
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Users>(context).fetchAndSetTechs();
    });
    Future.delayed(Duration.zero).then((_)  {
      Provider.of<Users>(context).fetchAndSetJobs();
    });

  //   Future<void> _handleNotification(
  //   Map<dynamic, dynamic> message, bool dialog) async {
  //   var data = message['data'] ?? message;
  //   print(data);
  //   // String notificationTitle = data['YOUR_KEY']; // here you need to replace YOUR_KEY with the actual key that you are sending in notification  **`"data"`** -field of the message. 
  //   // String notificationMessage = data['YOUR_KEY'];// here you need to replace YOUR_KEY with the actual key that you are sending in notification  **`"data"`** -field of the message. 

  //   // now show the Dialog
  // }
  
  // This widget is the root of your application.
   super.initState();
  
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  // _firebaseMessaging.configure(
  //     onMessage: (Map<String, dynamic> message) async {
  //       print("onMessage: $message");
  //     //  _showItemDialog(message);
  //     },
  //    // onBackgroundMessage: myBackgroundMessageHandler,
  //     onLaunch: (Map<String, dynamic> message) async {
  //       print("onLaunch: $message");
  //      // _navigateToItemDetail(message);
  //     },
  //     onResume: (Map<String, dynamic> message) async {
  //       print("onResume: $message");
  //      // _navigateToItemDetail(message);
  //     },
  //   );
   // print("FUNCTION KE BAAD");
   
  }
  //  getfcmToken()async
  // {
  //    fcm = await pushNotify.init();
  //    print(fcm);
  // }

  @override
  Widget build(BuildContext context) {
    var appBar2 = AppBar(
      title: Text('HomeTech Services'),
      //    backgroundColor: Colors.white,
      //  actions: <Widget>[
      //   IconButton(
      //     icon: Icon(Icons.offline_bolt),
      //     onPressed: null //() => null //Navigator.push(context,
      //MaterialPageRoute(builder: (context) => Login()))
      //               ),
      //               IconButton(icon: Icon(Icons.offline_pin), onPressed: null)
      //  ],
    );
    return Scaffold(
      appBar: appBar2,
      body: Container(
        color: Colors.blue[900],
        child: Column(
          children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height -
                      appBar2.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.2,
              decoration: BoxDecoration(
                  image: new DecorationImage(
                      image: new AssetImage('images/splash1.png'),
                      fit: BoxFit.contain)),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height -
                      appBar2.preferredSize.height -
                      MediaQuery.of(context).padding.top) *
                  0.05,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                          image: new AssetImage('images/mechanic.jpg'),
                          fit: BoxFit.contain),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Mechanical(fcm),
                          ),
                        );
                      },
                      child: null),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                          image: new AssetImage('images/AC.jpg'),
                          fit: BoxFit.contain),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: FlatButton(onPressed: () {
                    Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>AC(fcm),
                          ),
                        );
                  }, child: null),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                          image: new AssetImage('images/electrician.jpg'),
                          fit: BoxFit.contain),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: FlatButton(onPressed: () {
                    Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Electrical(fcm),
                          ),
                        );
                  }, child: null),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                          image: new AssetImage('images/Gardener.jpg'),
                          fit: BoxFit.contain),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: FlatButton(onPressed: () {
                    Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Gardener(fcm),
                          ),
                        );
                  }, child: null),
                )
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                          image: new AssetImage('images/Mason.jpg'),
                          fit: BoxFit.contain),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: FlatButton(onPressed: () {
                    Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Mason(fcm),
                          ),
                        );
                  }, child: null),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                          image: new AssetImage('images/Painting.jpg'),
                          fit: BoxFit.contain),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: FlatButton(onPressed: () {
                    Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Painting(fcm),
                          ),
                        );
                  }, child: null),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                          image: new AssetImage('images/Plumber.jpg'),
                          fit: BoxFit.contain),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: FlatButton(onPressed: () {
                    Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Plumber(fcm),
                          ),
                        );
                  }, child: null),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.15,
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.25,
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                      image: new DecorationImage(
                          image: new AssetImage('images/welder.jpg'),
                          fit: BoxFit.contain),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: FlatButton(onPressed: () {
                    Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Welder(fcm),
                          ),
                        );
                  }, child: null),
                )
              ],
            ),
          ],
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
