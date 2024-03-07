
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:perfect_couple/global.dart';

class FavouriteSentReceivedScreen extends StatefulWidget {
  const FavouriteSentReceivedScreen({super.key});

  @override
  State<FavouriteSentReceivedScreen> createState() => _FavouriteSentReceivedScreenState();
}

class _FavouriteSentReceivedScreenState extends State<FavouriteSentReceivedScreen> {

  bool isFavouriteSentClicked = true;
  List<String> favouriteSentList = [];
  List<String> favouriteReceivedList = [];
  List favouritesList = [];

  getFavouriteListKeys() async{
    if(isFavouriteSentClicked){
      var favouriteSentDocument = await FirebaseFirestore.instance.collection("users").doc(currentUserID.toString()).collection("favouriteSent").get();
      for(int i=0; i<favouriteSentDocument.docs.length; i++){
        favouriteSentList.add(favouriteSentDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(favouriteSentList);
    }
    else{
      var favouriteReceivedDocument = await FirebaseFirestore.instance.collection("users").doc(currentUserID.toString()).collection("favouriteReceived").get();
      for(int i=0; i<favouriteReceivedDocument.docs.length; i++){
        favouriteReceivedList.add(favouriteReceivedDocument.docs[i].id);
      }
      getKeysDataFromUsersCollection(favouriteReceivedList);
    }

  }

  getKeysDataFromUsersCollection(List<String> keysList)async{
    var allUsersDocument = await FirebaseFirestore.instance.collection("users").get();
    for(int i=0; i<allUsersDocument.docs.length; i++){
      for(int k=0; k<keysList.length; k++){
        if((allUsersDocument.docs[i].data() as dynamic)["uid"] == keysList[k]){
          favouritesList.add(allUsersDocument.docs[i].data());
        }
      }
    }
    setState(() {
      favouritesList;
    });
  }

  @override
  void initState() {
    super.initState();
    getFavouriteListKeys();
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
                favouriteSentList.clear();
                favouriteSentList = [];
                favouriteReceivedList.clear();
                favouriteReceivedList = [];
                favouritesList = [];
                setState(() {
                  isFavouriteSentClicked = true;
                });
                getFavouriteListKeys();
              },
              child: Text(
                'My Favourites',
                style: TextStyle(
                  color: isFavouriteSentClicked ? Colors.grey : Colors.black,
                  fontWeight: isFavouriteSentClicked ? FontWeight.bold : FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ),
            const Text("   |   ",),
            TextButton(
              onPressed: () {
                favouriteSentList.clear();
                favouriteSentList = [];
                favouriteReceivedList.clear();
                favouriteReceivedList = [];
                favouritesList = [];
                setState(() {
                  isFavouriteSentClicked = false;
                });
                getFavouriteListKeys();
              },
              child: Text(
                "I'm their Favourite",
                style: TextStyle(
                  color: isFavouriteSentClicked ? Colors.grey : Colors.black,
                  fontWeight: isFavouriteSentClicked ? FontWeight.bold : FontWeight.normal,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: favouritesList.isEmpty
        ? const Center(
            child: Icon(Icons.person_off_sharp, color: Colors.grey, size: 60,),
          )
        : GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.all(8),
            children: List.generate(favouritesList.length, (index){
              return GridTile(
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Card(
                    color: Colors.purpleAccent.shade200,
                    child: GestureDetector(
                      onTap: (){},
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: NetworkImage(favouritesList[index]['imageProfile'],), fit: BoxFit.cover,),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Spacer(),
                                /* name, age */
                                Text("${favouritesList[index]["name"].toString()} ⭐ ${favouritesList[index]["age"].toString()}", maxLines: 2, style: const TextStyle(overflow: TextOverflow.ellipsis, color: Colors.grey, fontSize: 15, fontWeight: FontWeight.bold,),),
                                const SizedBox(height: 4,),
                                /* icon - city, country */
                                Row(
                                  children: [
                                    const Icon(Icons.location_on_outlined, color: Colors.grey, size: 15,),
                                    Expanded(
                                      child: Text("${favouritesList[index]["city"].toString()} , ${favouritesList[index]["country"].toString()}", maxLines: 2, style: const TextStyle(overflow: TextOverflow.ellipsis, color: Colors.grey, fontSize: 13,),),
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
