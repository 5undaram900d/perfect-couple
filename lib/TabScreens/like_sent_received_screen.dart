
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perfect_couple/global.dart';

class LikeSentReceivedScreen extends StatefulWidget {
  const LikeSentReceivedScreen({super.key});

  @override
  State<LikeSentReceivedScreen> createState() => _LikeSentReceivedScreenState();
}

class _LikeSentReceivedScreenState extends State<LikeSentReceivedScreen> {

  bool isLikeSentClicked = true;
  List<String> likeSentList = [];
  List<String> likeReceivedList = [];
  List likesList = [];

  getLikeListKeys() async{
    if(isLikeSentClicked){
      var likeSentDocument = await FirebaseFirestore.instance.collection("users").doc(currentUserID.toString()).collection("likeSent").get();
      for(int i=0; i<likeSentDocument.docs.length; i++){
        likeSentList.add(likeSentDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(likeSentList);
    }
    else{
      var likeReceivedDocument = await FirebaseFirestore.instance.collection("users").doc(currentUserID.toString()).collection("likeReceived").get();
      for(int i=0; i<likeReceivedDocument.docs.length; i++){
        likeReceivedList.add(likeReceivedDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(likeReceivedList);
    }

  }

  getKeysDataFromUsersCollection(List<String> keysList)async{
    var allUsersDocument = await FirebaseFirestore.instance.collection("users").get();
    for(int i=0; i<allUsersDocument.docs.length; i++){
      for(int k=0; k<keysList.length; k++){
        if((allUsersDocument.docs[i].data() as dynamic)["uid"] == keysList[k]){
          likesList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      likesList;
    });
  }

  @override
  void initState() {
    super.initState();
    getLikeListKeys();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                likeSentList.clear();
                likeSentList = [];
                likeReceivedList.clear();
                likeReceivedList = [];
                likesList = [];
                setState(() {
                  isLikeSentClicked = true;
                });
                getLikeListKeys();
              },
              child: Text(
                'My Likes',
                style: TextStyle(
                  color: isLikeSentClicked ? Colors.grey : Colors.black,
                  fontWeight: isLikeSentClicked ? FontWeight.bold : FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ),
            const Text("   |   ",),
            TextButton(
              onPressed: () {
                likeSentList.clear();
                likeSentList = [];
                likeReceivedList.clear();
                likeReceivedList = [];
                likesList = [];
                setState(() {
                  isLikeSentClicked = false;
                });
                getLikeListKeys();
              },
              child: Text(
                "I'm their Like",
                style: TextStyle(
                  color: isLikeSentClicked ? Colors.grey : Colors.black,
                  fontWeight: isLikeSentClicked ? FontWeight.bold : FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: likesList.isEmpty
          ? const Center(
        child: Icon(Icons.person_off_sharp, color: Colors.grey, size: 60,),
      )
          : GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        children: List.generate(likesList.length, (index){
          return GridTile(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: Card(
                color: Colors.purpleAccent.shade200,
                child: GestureDetector(
                  onTap: (){},
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(likesList[index]['imageProfile'],), fit: BoxFit.cover,),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Spacer(),
                            /* name, age */
                            Text("${likesList[index]["name"].toString()} ⭐ ${likesList[index]["age"].toString()}", maxLines: 2, style: const TextStyle(overflow: TextOverflow.ellipsis, color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold,),),
                            const SizedBox(height: 4,),
                            /* icon - city, country */
                            Row(
                              children: [
                                const Icon(Icons.location_on_outlined, color: Colors.grey, size: 15,),
                                Expanded(
                                  child: Text("${likesList[index]["city"].toString()} , ${likesList[index]["country"].toString()}", maxLines: 2, style: const TextStyle(overflow: TextOverflow.ellipsis, color: Colors.grey, fontSize: 13,),),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
