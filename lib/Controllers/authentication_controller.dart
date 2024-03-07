
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:perfect_couple/AuthenticationScreens/login_screen.dart';
import 'package:perfect_couple/HomeScreen/home_screen.dart';
import 'package:perfect_couple/Models/person.dart' as personModel;

class AuthenticationController extends GetxController{
  static AuthenticationController authController = Get.find();

  late Rx<User?> firebaseCurrentUser;

  late Rx<File?> pickedFile;
  File? get profileImage => pickedFile.value;
  XFile? imageFile;

  pickImageFileFromGallery()async{
    imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if(imageFile!=null){
      Get.snackbar("Profile Image", "You've successfully picked your profile image");
    }
    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  captureImageFileFromPhoneCamera()async{
    imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if(imageFile!=null){
      Get.snackbar("Profile Image", "You've successfully captured your profile image");
    }
    pickedFile = Rx<File?>(File(imageFile!.path));
  }

  Future<String> uploadImageToStorage(File imageFile)async{
    /* 1st decide the reference of storage, where you want to store the image */
    Reference referenceStorage = FirebaseStorage.instance.ref().child("Profile Image").child(FirebaseAuth.instance.currentUser!.uid);
    /* declare which file you want to store in the database of given reference */
    UploadTask task = referenceStorage.putFile(imageFile);
    /* take snapshot of task, i.e. where which file store */
    TaskSnapshot snapshot = await task;
    /* image storage can get in the form of url */
    String downloadImageUrl = await snapshot.ref.getDownloadURL();
    /* return the downloadUrl */
    return downloadImageUrl;
  }

  createNewUserAccount(
  /* personal info */
  File imageProfile,
  String email,
  String password,
  String name,
  String age,
  String phoneNo,
  String city,
  String country,
  String profileHeading,
  String lookingForInPartner,
  // String publishedDateTime,

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
    try{
      // 1. authenticate user and create user with email & password
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      // 2. upload image to storage
      String urlOfDownloadedImage = await uploadImageToStorage(imageProfile);

      // 3. save user info to firebase storage
      personModel.Person personInstance = personModel.Person(
        /* personal info */
        uid: FirebaseAuth.instance.currentUser!.uid,
        imageProfile: urlOfDownloadedImage,
        email: email,
        password: password,
        name: name,
        age: int.parse(age),
        phoneNo: phoneNo,
        city: city,
        country: country,
        profileHeading: profileHeading,
        lookingForInPartner: lookingForInPartner,
        publishedDateTime: DateTime.now().millisecondsSinceEpoch,

        /* Appearance */
        height: height,
        weight: weight,
        bodyType: bodyType,

        /* Life style */
        drink: drink,
        smoke: smoke,
        martialStatus: martialStatus,
        haveChildren: haveChildren,
        noOfChildren: noOfChildren,
        profession: profession,
        employmentStatus: employmentStatus,
        income: income,
        livingSituation: livingSituation,
        willingToRelocate: willingToRelocate,
        relationshipYouAreLookingFor: relationshipYouAreLookingFor,

        /* Life style */
        nationality: nationality,
        education: education,
        languageSpoken: languageSpoken,
        religion: religion,
        ethnicity: ethnicity,
      );
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set(personInstance.toJson());
      Get.snackbar("Account Created", "Congratulations, your account has been created");
      Get.to(()=> const HomeScreen());
    }
    catch(errorMsg){
      Get.snackbar("Account Creation Unsuccessful", "Error occurred: $errorMsg");
    }
  }

  loginUser(String emailUser, String passwordUser) async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailUser, password: passwordUser);
      Get.snackbar("Logged in successfully", "You're logged in successfully");
      Get.to(()=> const HomeScreen(),);
    }
    catch(errorMsg){
      Get.snackbar("Login Failed", "Error occurs: $errorMsg");
    }
  }

  checkIfUserIsLoggedIn(User? currentUser){
    if(currentUser==null){
      Get.to(()=> const LoginScreen(),);
    }
    else{
      Get.to(()=> const HomeScreen(),);
    }
  }

  @override
  void onReady() {
    super.onReady();
    firebaseCurrentUser = Rx<User?>(FirebaseAuth.instance.currentUser);
    firebaseCurrentUser.bindStream(FirebaseAuth.instance.authStateChanges());

    ever(firebaseCurrentUser, checkIfUserIsLoggedIn);
  }

}