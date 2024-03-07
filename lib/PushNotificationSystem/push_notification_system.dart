
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

//*** for push notification use of firebase_messaging helps, do it letter ***/

class PushNotificationSystem{
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  /* notification sent or receive */
  Future whenNotificationReceived(BuildContext context) async{
    /*** 1. Terminate ***/
    /* when the app is completely closed and opened directly from the push notification */
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? remoteMessage){
      if(remoteMessage!=null){
        /* open app and show notification data */
        openAppAndShowNotificationData(remoteMessage.data["userID"], remoteMessage.data["senderID"], context);
      }
    });

    /*** 2. Foreground ***/
    /* when the app is open and it receives a push notification */
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      if(remoteMessage!=null){
        /* open app and show notification data */
        openAppAndShowNotificationData(remoteMessage.data["userID"], remoteMessage.data["senderID"], context);
      }
    });

    /*** 3. Background ***/
    /* when the app is completely closed and opened directly from the push notification */
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      if(remoteMessage!=null){
        /* open app and show notification data */
        openAppAndShowNotificationData(remoteMessage.data["userID"], remoteMessage.data["senderID"], context);
      }
    });
  }

  openAppAndShowNotificationData(receiverID, senderID, context)async{

  }

}