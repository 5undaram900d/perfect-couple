
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfect_couple/HomeScreen/home_screen.dart';
import 'package:perfect_couple/Widgets/custom_text_field.dart';
import 'package:perfect_couple/global.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {

  bool uploading = false;
  bool next = false;
  final List<File> _image = [];
  List<String> urlsList = [];
  double val = 0.0;

  //personal info
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController phoneNoTextEditingController = TextEditingController();
  TextEditingController cityTextEditingController = TextEditingController();
  TextEditingController countryTextEditingController = TextEditingController();
  TextEditingController profileHeadingTextEditingController = TextEditingController();
  TextEditingController lookingForInPartnerTextEditingController = TextEditingController();

  //appearance
  TextEditingController heightTextEditingController = TextEditingController();
  TextEditingController weightTextEditingController = TextEditingController();
  TextEditingController bodyTypeTextEditingController = TextEditingController();

  //life style
  TextEditingController drinkTextEditingController = TextEditingController();
  TextEditingController smokeTextEditingController = TextEditingController();
  TextEditingController martialStatusTextEditingController = TextEditingController();
  TextEditingController haveChildrenTextEditingController = TextEditingController();
  TextEditingController noOfChildrenTextEditingController = TextEditingController();
  TextEditingController professionTextEditingController = TextEditingController();
  TextEditingController employmentStatusTextEditingController = TextEditingController();
  TextEditingController incomeTextEditingController = TextEditingController();
  TextEditingController livingSituationTextEditingController = TextEditingController();
  TextEditingController willingToRelocateTextEditingController = TextEditingController();
  TextEditingController relationYouAreLookingForTextEditingController = TextEditingController();

  //background - cultural value
  TextEditingController nationalityTextEditingController = TextEditingController();
  TextEditingController educationTextEditingController = TextEditingController();
  TextEditingController languagesSpokenTextEditingController = TextEditingController();
  TextEditingController religionTextEditingController = TextEditingController();
  TextEditingController ethnicityTextEditingController = TextEditingController();

  /* personal info */
  String name = '';
  String age = '';
  String phoneNo = '';
  String city = '';
  String country = '';
  String profileHeading = '';
  String lookingForInPartner = '';

  /* Appearance */
  String height = '';
  String weight = '';
  String bodyType = '';

  /* Life style */
  String drink = '';
  String smoke = '';
  String martialStatus = '';
  String haveChildren = '';
  String noOfChildren = '';
  String profession = '';
  String employmentStatus = '';
  String income = '';
  String livingSituation = '';
  String willingToRelocate = '';
  String relationshipYouAreLookingFor = '';

  /* Life style */
  String nationality = '';
  String education = '';
  String languageSpoken = '';
  String religion = '';
  String ethnicity = '';

  chooseImage() async{
    XFile? pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery,);
    setState(() {
      _image.add(File(pickedFile!.path),);
    });
  }

  uploadedImages()async{
    int i = 1;
    for(var img in _image){
      setState(() {
        val = i / _image.length;
      });
      var refImage = FirebaseStorage.instance.ref().child("images/${DateTime.now().millisecondsSinceEpoch}.jpg");
      await refImage.putFile(img).whenComplete(()async{
        await refImage.getDownloadURL().then((urlImage){
          urlsList.add(urlImage);
          i++;
        });
      });
    }
  }

  retrieveUserData()async{
    await FirebaseFirestore.instance.collection("users").doc(currentUserID).get().then((snapshot){
      if(snapshot.exists){
        setState(() {
          /* personal info */
          name = snapshot.data()!["name"];
          nameTextEditingController.text = name;
          age = snapshot.data()!["age"].toString();
          ageTextEditingController.text = age;
          phoneNo = snapshot.data()!["phoneNo"];
          phoneNoTextEditingController.text = phoneNo;
          city = snapshot.data()!["city"];
          cityTextEditingController.text = city;
          country = snapshot.data()!["country"];
          countryTextEditingController.text = country;
          profileHeading = snapshot.data()!["profileHeading"];
          profileHeadingTextEditingController.text = profileHeading;
          lookingForInPartner = snapshot.data()!["lookingForInPartner"];
          lookingForInPartnerTextEditingController.text = lookingForInPartner;

          /* Appearance */
          height = snapshot.data()!["height"];
          heightTextEditingController.text = height;
          weight = snapshot.data()!["weight"];
          weightTextEditingController.text = weight;
          bodyType = snapshot.data()!["bodyType"];
          bodyTypeTextEditingController.text = bodyType;

          /* Life style */
          drink = snapshot.data()!["drink"];
          drinkTextEditingController.text = drink;
          smoke = snapshot.data()!["smoke"];
          smokeTextEditingController.text = smoke;
          martialStatus = snapshot.data()!["martialStatus"];
          martialStatusTextEditingController.text = martialStatus;
          haveChildren = snapshot.data()!["haveChildren"];
          haveChildrenTextEditingController.text = haveChildren;
          noOfChildren = snapshot.data()!["noOfChildren"];
          noOfChildrenTextEditingController.text = noOfChildren;
          profession = snapshot.data()!["profession"];
          professionTextEditingController.text = profession;
          employmentStatus = snapshot.data()!["employmentStatus"];
          employmentStatusTextEditingController.text = employmentStatus;
          income = snapshot.data()!["income"];
          incomeTextEditingController.text = income;
          livingSituation = snapshot.data()!["livingSituation"];
          livingSituationTextEditingController.text = livingSituation;
          willingToRelocate = snapshot.data()!["willingToRelocate"];
          willingToRelocateTextEditingController.text = willingToRelocate;
          relationshipYouAreLookingFor = snapshot.data()!["relationshipYouAreLookingFor"];
          relationYouAreLookingForTextEditingController.text = relationshipYouAreLookingFor;

          /* Life style */
          nationality = snapshot.data()!["nationality"];
          education = snapshot.data()!["education"];
          languageSpoken = snapshot.data()!["languageSpoken"];
          religion = snapshot.data()!["religion"];
          ethnicity = snapshot.data()!["ethnicity"];
        });
      }
    });
  }

  updateUserDataToFirestoreDatabase(
      /* personal info */
      String name,
      String age,
      String phoneNo,
      String city,
      String country,
      String profileHeading,
      String lookingForInPartner,

      /* Appearance */
      String height,
      String weight,
      String bodyType,

      /* Life style */
      String drink,
      String smoke,
      String martialStatus,
      String haveChildren,
      String noOfChildren,
      String profession,
      String employmentStatus,
      String income,
      String livingSituation,
      String willingToRelocate,
      String relationshipYouAreLookingFor,

      /* Life style */
      String nationality,
      String education,
      String languageSpoken,
      String religion,
      String ethnicity,
    )async{
    showDialog(
      context: context,
      builder: (context){
        return const AlertDialog(
          content: SizedBox(
            height: 200,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10,),
                  Text("uploading images..."),
                ],
              ),
            ),
          ),
        );
      },
    );
    await uploadedImages();

    await FirebaseFirestore.instance.collection("users").doc(currentUserID).update({
      /* personal info */
      "name": name,
      "age": int.parse(age),
      "phoneNo": phoneNo,
      "city": city,
      "country": country,
      "profileHeading": profileHeading,
      "lookingForInPartner": lookingForInPartner,

      /* Appearance */
      "height": height,
      "weight": weight,
      "bodyType": bodyType,

      /* Life style */
      "drink": drink,
      "smoke": smoke,
      "martialStatus": martialStatus,
      "haveChildren": haveChildren,
      "noOfChildren": noOfChildren,
      "profession": profession,
      "employmentStatus": employmentStatus,
      "income": income,
      "livingSituation": livingSituation,
      "willingToRelocate": willingToRelocate,
      "relationshipYouAreLookingFor": relationshipYouAreLookingFor,

      /* Background = cultural values */
      "nationality": nationality,
      "education": education,
      "languageSpoken": languageSpoken,
      "religion": religion,
      "ethnicity": ethnicity,

      /* images */
      'urlImage1': urlsList[0].toString(),
      'urlImage2': urlsList[1].toString(),
      'urlImage3': urlsList[2].toString(),
      'urlImage4': urlsList[3].toString(),
      'urlImage5': urlsList[4].toString(),
    });

    Get.snackbar("Updated", "Your account has been updated successfully");

    Get.to(()=> const HomeScreen());

    setState(() {
      uploading = false;
      _image.clear();
      urlsList.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    retrieveUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(next ? "Profile Information" : "Choose 5 Images", style: const TextStyle(color: Colors.black, fontSize: 20),),
        actions: [
          next
          ? Container()
          : IconButton(
              onPressed: (){
                if(_image.length==5){
                  setState(() {
                    uploading = true;
                    next = true;
                  });
                }
                else{
                  Get.snackbar("5 Image", "Please choose 5 images");
                }
              },
              icon: const Icon(Icons.navigate_next_outlined, size: 35,),
            ),
        ],
      ),
      body: next
        ? SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20,),

                /**** personal info ****/
                const Text("Personal Information", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600,),),
                const SizedBox(height: 10,),
                /* name */
                CustomTextField(
                  editingController: nameTextEditingController,
                  labelText: "Name",
                  iconData: Icons.person_outline,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* age */
                CustomTextField(
                  editingController: ageTextEditingController,
                  labelText: "Age",
                  iconData: Icons.numbers_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* phoneNo */
                CustomTextField(
                  editingController: phoneNoTextEditingController,
                  labelText: "Phone Number",
                  iconData: Icons.phone_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* city */
                CustomTextField(
                  editingController: cityTextEditingController,
                  labelText: "City",
                  iconData: Icons.location_city_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* country */
                CustomTextField(
                  editingController: countryTextEditingController,
                  labelText: "Country",
                  iconData: Icons.location_pin,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* profileHeading */
                CustomTextField(
                  editingController: profileHeadingTextEditingController,
                  labelText: "Profile Heading",
                  iconData: Icons.text_fields_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* lookingForInPartner */
                CustomTextField(
                  editingController: lookingForInPartnerTextEditingController,
                  labelText: "What you're looking for in a partner?",
                  iconData: Icons.face_2_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 20,),

                /**** appearance ****/
                const Text("Appearance", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600,),),
                const SizedBox(height: 10,),
                /* height */
                CustomTextField(
                  editingController: heightTextEditingController,
                  labelText: "Height",
                  iconData: Icons.height_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* weight */
                CustomTextField(
                  editingController: weightTextEditingController,
                  labelText: "Weight",
                  iconData: Icons.line_weight_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* bodyType */
                CustomTextField(
                  editingController: bodyTypeTextEditingController,
                  labelText: "Body Type",
                  iconData: Icons.looks,
                  isObscure: false,
                ),
                const SizedBox(height: 20,),

                /**** life style ****/
                const Text("Life Style", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600,),),
                const SizedBox(height: 10,),
                /* drink */
                CustomTextField(
                  editingController: drinkTextEditingController,
                  labelText: "Drink",
                  iconData: Icons.local_drink_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* smoke */
                CustomTextField(
                  editingController: smokeTextEditingController,
                  labelText: "Smoke",
                  iconData: Icons.smoking_rooms_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* martialStatus */
                CustomTextField(
                  editingController: martialStatusTextEditingController,
                  labelText: "Have married?",
                  iconData: Icons.family_restroom_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* haveChildren */
                CustomTextField(
                  editingController: haveChildrenTextEditingController,
                  labelText: "Have Children?",
                  iconData: Icons.groups,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* noOfChildren */
                CustomTextField(
                  editingController: noOfChildrenTextEditingController,
                  labelText: "Number of children you have?",
                  iconData: Icons.numbers_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* profession */
                CustomTextField(
                  editingController: professionTextEditingController,
                  labelText: "Profession",
                  iconData: Icons.business_center_sharp,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* employmentStatus */
                CustomTextField(
                  editingController: employmentStatusTextEditingController,
                  labelText: "Employment Status",
                  iconData: Icons.money,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* income */
                CustomTextField(
                  editingController: incomeTextEditingController,
                  labelText: "Annual Income",
                  iconData: Icons.monetization_on_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* livingSituation */
                CustomTextField(
                  editingController: livingSituationTextEditingController,
                  labelText: "Living Situation",
                  iconData: Icons.group_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* willingToRelocate */
                CustomTextField(
                  editingController: willingToRelocateTextEditingController,
                  labelText: "Can you relocate?",
                  iconData: Icons.share_location,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* relationYouAreLookingFor */
                CustomTextField(
                  editingController: relationYouAreLookingForTextEditingController,
                  labelText: "Relation you're looking for?",
                  iconData: Icons.favorite_border_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 20,),

                /**** Background - Cultural Value ****/
                const Text("Background - Cultural Value", style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600,),),
                const SizedBox(height: 10,),
                /* nationality */
                CustomTextField(
                  editingController: nationalityTextEditingController,
                  labelText: "Nationality",
                  iconData: Icons.flag_circle_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* education */
                CustomTextField(
                  editingController: educationTextEditingController,
                  labelText: "Education",
                  iconData: Icons.menu_book_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* languagesSpoken */
                CustomTextField(
                  editingController: languagesSpokenTextEditingController,
                  labelText: "Language",
                  iconData: Icons.language_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* religion */
                CustomTextField(
                  editingController: religionTextEditingController,
                  labelText: "Religion",
                  iconData: Icons.temple_hindu_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),
                /* ethnicity */
                CustomTextField(
                  editingController: ethnicityTextEditingController,
                  labelText: "Ethnicity",
                  iconData: Icons.boy_outlined,
                  isObscure: false,
                ),
                const SizedBox(height: 15,),

                /* Register button */
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width - 36,
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.all(Radius.circular(12,),),
                  ),
                  child: InkWell(
                    onTap: ()async{
                      if(
                      /* personal info */
                      nameTextEditingController.text.trim().isNotEmpty &&
                          ageTextEditingController.text.trim().isNotEmpty &&
                          phoneNoTextEditingController.text.trim().isNotEmpty &&
                          cityTextEditingController.text.trim().isNotEmpty &&
                          countryTextEditingController.text.trim().isNotEmpty &&
                          profileHeadingTextEditingController.text.trim().isNotEmpty &&
                          lookingForInPartnerTextEditingController.text.trim().isNotEmpty &&
                          /* appearance */
                          heightTextEditingController.text.trim().isNotEmpty &&
                          weightTextEditingController.text.trim().isNotEmpty &&
                          bodyTypeTextEditingController.text.trim().isNotEmpty &&
                          /* life style */
                          drinkTextEditingController.text.trim().isNotEmpty &&
                          smokeTextEditingController.text.trim().isNotEmpty &&
                          martialStatusTextEditingController.text.trim().isNotEmpty &&
                          haveChildrenTextEditingController.text.trim().isNotEmpty &&
                          noOfChildrenTextEditingController.text.trim().isNotEmpty &&
                          professionTextEditingController.text.trim().isNotEmpty &&
                          employmentStatusTextEditingController.text.trim().isNotEmpty &&
                          incomeTextEditingController.text.trim().isNotEmpty &&
                          livingSituationTextEditingController.text.trim().isNotEmpty &&
                          willingToRelocateTextEditingController.text.trim().isNotEmpty &&
                          relationYouAreLookingForTextEditingController.text.trim().isNotEmpty &&
                          /* Background - cultural status */
                          nationalityTextEditingController.text.trim().isNotEmpty &&
                          educationTextEditingController.text.trim().isNotEmpty &&
                          languagesSpokenTextEditingController.text.trim().isNotEmpty &&
                          religionTextEditingController.text.trim().isNotEmpty &&
                          ethnicityTextEditingController.text.trim().isNotEmpty
                      ){
                        _image.isNotEmpty ?

                        await updateUserDataToFirestoreDatabase(
                          /* personal info */
                            nameTextEditingController.text.trim(),
                            ageTextEditingController.text.trim(),
                            phoneNoTextEditingController.text.trim(),
                            cityTextEditingController.text.trim(),
                            countryTextEditingController.text.trim(),
                            profileHeadingTextEditingController.text.trim(),
                            lookingForInPartnerTextEditingController.text.trim(),
                            /* appearance */
                            heightTextEditingController.text.trim(),
                            weightTextEditingController.text.trim(),
                            bodyTypeTextEditingController.text.trim(),
                            /* life style */
                            drinkTextEditingController.text.trim(),
                            smokeTextEditingController.text.trim(),
                            martialStatusTextEditingController.text.trim(),
                            haveChildrenTextEditingController.text.trim(),
                            noOfChildrenTextEditingController.text.trim(),
                            professionTextEditingController.text.trim(),
                            employmentStatusTextEditingController.text.trim(),
                            incomeTextEditingController.text.trim(),
                            livingSituationTextEditingController.text.trim(),
                            willingToRelocateTextEditingController.text.trim(),
                            relationYouAreLookingForTextEditingController.text.trim(),
                            /* Background - cultural status */
                            nationalityTextEditingController.text.trim(),
                            educationTextEditingController.text.trim(),
                            languagesSpokenTextEditingController.text.trim(),
                            religionTextEditingController.text.trim(),
                            ethnicityTextEditingController.text.trim()
                        ) : null;
                      }
                      else{
                        Get.snackbar("Empty Field", "Please fill all the fields.");
                      }
                    },
                    child: const Center(child: Text('Update', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold,),),),
                  ),
                ),
                const SizedBox(height: 15,),
              ],
            ),
          ),
        )
        : Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              child: GridView.builder(
                itemCount: _image.length + 1,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,),
                itemBuilder: (context, index){
                  return index==0
                  ? Container(
                      color: Colors.pink[300],
                      child: Center(
                        child: IconButton(
                          onPressed: (){
                            if(_image.length < 5){
                              !uploading ? chooseImage() : null;
                            }
                            else{
                              setState(() {
                                uploading == true;
                              });
                              Get.snackbar("5 images Chosen", "5 images already selected");
                            }
                          },
                          icon: const Icon(Icons.add,),
                        ),
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: FileImage(_image[index-1],), fit: BoxFit.cover,),
                      ),
                    );
                },
              ),
            ),
          ],
        ),
    );
  }
}
