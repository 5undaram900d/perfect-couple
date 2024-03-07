
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:perfect_couple/Models/person.dart';
import 'package:perfect_couple/global.dart';

class ProfileController extends GetxController{
  final Rx<List<Person>> usersProfileList = Rx<List<Person>>([]);
  List<Person> get allUsersProfileList => usersProfileList.value;

  @override
  void onInit() {
    super.onInit();
    usersProfileList.bindStream(
      FirebaseFirestore.instance.collection("users").where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots().map((QuerySnapshot queryDataSnapshot){
        List<Person> profilesList = [];
        for(var eachProfile in queryDataSnapshot.docs){
          profilesList.add(Person.fromDataSnapshot(eachProfile));
        }
        return profilesList;
      }),
    );
  }

  favoriteSentReceived(String toUserID, String senderName)async{
    var document = await FirebaseFirestore.instance.collection("users").doc(toUserID).collection("favouriteReceived").doc(currentUserID).get();

    /* remove favourite from database */
    if(document.exists){
      /* remove currentUserID from the favouriteReceived list of that profile person */
      await FirebaseFirestore.instance.collection("users").doc(toUserID).collection("favouriteReceived").doc(currentUserID).delete();
      /* remove profile person from the favouriteReceived list of that currentUserID */
      await FirebaseFirestore.instance.collection("users").doc(currentUserID).collection("favouriteSent").doc(toUserID).delete();
    }
    /* add as favorite */
    else{
      /* add currentUserID to the favouriteReceived list of that profile person */
      await FirebaseFirestore.instance.collection("users").doc(toUserID).collection("favouriteReceived").doc(currentUserID).set({});
      /* add profile person to the favouriteReceived list of that currentUserID */
      await FirebaseFirestore.instance.collection("users").doc(currentUserID).collection("favouriteSent").doc(toUserID).set({});

      /* send notification */
    }

    update();
  }

  likeSentReceived(String toUserID, String senderName)async{
    var document = await FirebaseFirestore.instance.collection("users").doc(toUserID).collection("likeReceived").doc(currentUserID).get();

    /* remove like from database */
    if(document.exists){
      /* remove currentUserID from the likeReceived list of that profile person */
      await FirebaseFirestore.instance.collection("users").doc(toUserID).collection("likeReceived").doc(currentUserID).delete();
      /* remove profile person from the likeReceived list of that currentUserID */
      await FirebaseFirestore.instance.collection("users").doc(currentUserID).collection("likeSent").doc(toUserID).delete();
    }
    /* add as like */
    else{
      /* add currentUserID to the likeReceived list of that profile person */
      await FirebaseFirestore.instance.collection("users").doc(toUserID).collection("likeReceived").doc(currentUserID).set({});
      /* add profile person to the likeReceived list of that currentUserID */
      await FirebaseFirestore.instance.collection("users").doc(currentUserID).collection("likeSent").doc(toUserID).set({});

      /* send notification */
    }

    update();
  }

  viewSentReceived(String toUserID, String senderName)async{
    var document = await FirebaseFirestore.instance.collection("users").doc(toUserID).collection("viewReceived").doc(currentUserID).get();

    /* nothing do, when already view */
    if(document.exists){
      print("already in view list");
    }
    /* add new view in database*/
    else{
      /* add currentUserID to the viewReceived list of that profile person */
      await FirebaseFirestore.instance.collection("users").doc(toUserID).collection("viewReceived").doc(currentUserID).set({});
      /* add profile person to the viewReceived list of that currentUserID */
      await FirebaseFirestore.instance.collection("users").doc(currentUserID).collection("viewSent").doc(toUserID).set({});

      /* send notification */
    }

    update();
  }

}