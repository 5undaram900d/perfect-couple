
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect_couple/Controllers/profile_controller.dart';
import 'package:perfect_couple/TabScreens/user_detail_screen.dart';
import 'package:perfect_couple/global.dart';

class SwipingScreen extends StatefulWidget {
  const SwipingScreen({super.key});

  @override
  State<SwipingScreen> createState() => _SwipingScreenState();
}

class _SwipingScreenState extends State<SwipingScreen> {

  ProfileController profileController = Get.put(ProfileController());
  String senderName = "";

  readCurrentUserData()async{
    await FirebaseFirestore.instance.collection("users").doc(currentUserID).get().then((dataSnapshot){
      setState(() {
        senderName = dataSnapshot.data()!["name"].toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    readCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        ()=> PageView.builder(
          itemCount: profileController.allUsersProfileList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1,),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index){
            final eachProfileInfo = profileController.allUsersProfileList[index];
            return DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(eachProfileInfo.imageProfile.toString(),), fit: BoxFit.cover,),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    /* filter IconButton */
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0,),
                        child: IconButton(onPressed: (){}, icon: const Icon(Icons.filter_list, size: 30,),),
                      ),
                    ),
                    /*** for give space b/w filter button & detail ***/
                    const Spacer(),
                    /* user Data */
                    GestureDetector(
                      onTap: (){
                        profileController.viewSentReceived(eachProfileInfo.uid.toString(), senderName);
                        /* send user to profile person to userDetailScreen */
                        Get.to(()=> UserDetailScreen(userID: eachProfileInfo.uid.toString(),),);
                      },
                      child: Column(
                        children: [
                          /* name */
                          Text(eachProfileInfo.name.toString(), style: const TextStyle(color: Colors.purpleAccent, fontSize: 25, letterSpacing: 4, fontWeight: FontWeight.bold,),),
                          /* age & city */
                          Text("${eachProfileInfo.name} 🏠 ${eachProfileInfo.city}", style: const TextStyle(color: Colors.purpleAccent, fontSize: 15, letterSpacing: 4,),),
                          const SizedBox(height: 5,),
                          /* profession & religion */
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white30,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(eachProfileInfo.profession.toString(), style: const TextStyle(color: Colors.purpleAccent, fontSize: 15,),),
                              ),
                              const SizedBox(width: 6,),
                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white30,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(eachProfileInfo.religion.toString(), style: const TextStyle(color: Colors.purpleAccent, fontSize: 15,),),
                              ),
                            ],
                          ),
                          /* country & ethnicity */
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white30,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(eachProfileInfo.country.toString(), style: const TextStyle(color: Colors.purpleAccent, fontSize: 15,),),
                              ),
                              const SizedBox(width: 6,),
                              ElevatedButton(
                                onPressed: (){},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white30,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                child: Text(eachProfileInfo.ethnicity.toString(), style: const TextStyle(color: Colors.purpleAccent, fontSize: 15,),),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15,),
                    /* image button - favourite, chat, like */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        /* favourite button */
                        GestureDetector(
                          onTap: ()=> profileController.favoriteSentReceived(eachProfileInfo.uid.toString(), senderName),
                          child: Image.asset("images/star.png", width: 50,),
                        ),
                        /* chat button */
                        GestureDetector(
                          onTap: (){},
                          child: Image.asset("images/chat.png", width: 60,),
                        ),
                        /* like button */
                        GestureDetector(
                          onTap: (){},
                          child: Image.asset("images/like.png", width: 50,),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
