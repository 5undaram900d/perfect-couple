
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';
import 'package:get/get.dart';
import 'package:perfect_couple/AccountSettingScreen/account_setting_screen.dart';
import 'package:perfect_couple/global.dart';

class UserDetailScreen extends StatefulWidget {

  String? userID;

  UserDetailScreen({super.key, this.userID});

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {

  /* personal Info */
  String name = "";
  String age = "";
  String phoneNo = "";
  String city = "";
  String country = "";
  String profileHeading = "";
  String lookingForInPartner = "";

  /* appearance */
  String height = "";
  String weight = "";
  String bodyType = "";

  /* life style */
  String drink = "";
  String smoke = "";
  String martialStatus = "";
  String haveChildren = "";
  String noOfChildren = "";
  String profession = "";
  String employmentStatus = "";
  String income = "";
  String livingSituation = "";
  String willingToRelocate = "";
  String relationshipYouAreLookingFor = "";

  /* background - cultural value */
  String nationality = "";
  String education = "";
  String languageSpoken = "";
  String religion = "";
  String ethnicity = "";

  /* slider image */
  String urlImage1 = 'https://firebasestorage.googleapis.com/v0/b/perfect-couple-app.appspot.com/o/Place%20Holder%2Flogo2.png?alt=media&token=f4df4d24-176e-4bb8-9b52-dba92d8d6850';
  String urlImage2 = 'https://firebasestorage.googleapis.com/v0/b/perfect-couple-app.appspot.com/o/Place%20Holder%2Flogo2.png?alt=media&token=f4df4d24-176e-4bb8-9b52-dba92d8d6850';
  String urlImage3 = 'https://firebasestorage.googleapis.com/v0/b/perfect-couple-app.appspot.com/o/Place%20Holder%2Flogo2.png?alt=media&token=f4df4d24-176e-4bb8-9b52-dba92d8d6850';
  String urlImage4 = 'https://firebasestorage.googleapis.com/v0/b/perfect-couple-app.appspot.com/o/Place%20Holder%2Flogo2.png?alt=media&token=f4df4d24-176e-4bb8-9b52-dba92d8d6850';
  String urlImage5 = 'https://firebasestorage.googleapis.com/v0/b/perfect-couple-app.appspot.com/o/Place%20Holder%2Flogo2.png?alt=media&token=f4df4d24-176e-4bb8-9b52-dba92d8d6850';

  retrieveUserInfo()async{
    FirebaseFirestore.instance.collection("users").doc(widget.userID).get().then((snapshot){
      if(snapshot.exists){
        if(snapshot.data()!["urlImage1"] != null){
          setState(() {
            urlImage1 = snapshot.data()!["urlImage1"];
            urlImage2 = snapshot.data()!["urlImage2"];
            urlImage3 = snapshot.data()!["urlImage3"];
            urlImage4 = snapshot.data()!["urlImage4"];
            urlImage5 = snapshot.data()!["urlImage5"];
          });
          setState(() {
            /* personal info */
            name = snapshot.data()!["name"];
            age = snapshot.data()!["age"].toString();
            phoneNo = snapshot.data()!["phoneNo"];
            city = snapshot.data()!["city"];
            country = snapshot.data()!["country"];
            profileHeading = snapshot.data()!["profileHeading"];
            lookingForInPartner = snapshot.data()!["lookingForInPartner"];

            /* appearance */
            height = snapshot.data()!["height"];
            weight = snapshot.data()!["weight"];
            bodyType = snapshot.data()!["bodyType"];

            /* life style */
            drink = snapshot.data()!["drink"];
            smoke = snapshot.data()!["smoke"];
            martialStatus = snapshot.data()!["martialStatus"];
            haveChildren = snapshot.data()!["haveChildren"];
            noOfChildren = snapshot.data()!["noOfChildren"];
            profession = snapshot.data()!["profession"];
            employmentStatus = snapshot.data()!["employmentStatus"];
            income = snapshot.data()!["income"];
            livingSituation = snapshot.data()!["livingSituation"];
            willingToRelocate = snapshot.data()!["willingToRelocate"];
            relationshipYouAreLookingFor = snapshot.data()!["relationshipYouAreLookingFor"];

            /* Background - Cultural value */
            nationality = snapshot.data()!["nationality"];
            education = snapshot.data()!["education"];
            languageSpoken = snapshot.data()!["languageSpoken"];
            religion = snapshot.data()!["religion"];
            ethnicity = snapshot.data()!["ethnicity"];
          });
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    retrieveUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile",),
        // automaticallyImplyLeading: widget.userID == currentUserID ? false : true,
        leading: widget.userID != currentUserID ? IconButton(
          onPressed: (){
            Get.back();
          }, 
          icon: const Icon(Icons.arrow_back_outlined, size: 30,),
        ) : Container(),
        centerTitle: true,
        actions: [
          widget.userID == currentUserID
          ? Row(
            children: [
              IconButton(onPressed: ()=> Get.to(()=> const AccountSettingScreen(),), icon: const Icon(Icons.settings, size: 30,),),
              IconButton(onPressed: ()=> FirebaseAuth.instance.signOut(), icon: const Icon(Icons.logout, size: 30,),),
            ],
          )
          : Container(),    
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30,),
          child: Column(
            children: [
              /* image slider */
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Carousel(
                    indicatorBarColor: Colors.pink.withOpacity(0.3),
                    autoScrollDuration: const Duration(seconds: 2,),
                    animationPageDuration: const Duration(milliseconds: 500,),
                    activateIndicatorColor: Colors.black,
                    animationPageCurve: Curves.easeIn,
                    indicatorBarHeight: 30,
                    indicatorHeight: 10,
                    indicatorWidth: 10,
                    unActivatedIndicatorColor: Colors.grey,
                    stopAtEnd: false,
                    autoScroll: true,
                    items: [
                      Image.asset(urlImage1, fit: BoxFit.cover,),
                      Image.asset(urlImage2, fit: BoxFit.cover,),
                      Image.asset(urlImage3, fit: BoxFit.cover,),
                      Image.asset(urlImage4, fit: BoxFit.cover,),
                      Image.asset(urlImage5, fit: BoxFit.cover,),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
