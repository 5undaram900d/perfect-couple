
import 'package:cloud_firestore/cloud_firestore.dart';

class Person {
  /* personal info */
  String? uid;
  String? imageProfile;
  String? email;
  String? password;
  String? name;
  int? age;
  String? phoneNo;
  String? city;
  String? country;
  String? profileHeading;
  String? lookingForInPartner;
  int? publishedDateTime;

  /* Appearance */
  String? height;
  String? weight;
  String? bodyType;

  /* Life style */
  String? drink;
  String? smoke;
  String? martialStatus;
  String? haveChildren;
  String? noOfChildren;
  String? profession;
  String? employmentStatus;
  String? income;
  String? livingSituation;
  String? willingToRelocate;
  String? relationshipYouAreLookingFor;

  /* Life style */
  String? nationality;
  String? education;
  String? languageSpoken;
  String? religion;
  String? ethnicity;

  Person({
    /* personal info */
    this.uid,
    this.imageProfile,
    this.email,
    this.password,
    this.name,
    this.age,
    this.phoneNo,
    this.city,
    this.country,
    this.profileHeading,
    this.lookingForInPartner,
    this.publishedDateTime,

    /* Appearance */
    this.height,
    this.weight,
    this.bodyType,

    /* Life style */
    this.drink,
    this.smoke,
    this.martialStatus,
    this.haveChildren,
    this.noOfChildren,
    this.profession,
    this.employmentStatus,
    this.income,
    this.livingSituation,
    this.willingToRelocate,
    this.relationshipYouAreLookingFor,

    /* Life style */
    this.nationality,
    this.education,
    this.languageSpoken,
    this.religion,
    this.ethnicity,
  });

  static Person fromDataSnapshot(DocumentSnapshot snapshot){
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;
    return Person(
      /* personal info */
      uid: dataSnapshot["uid"],
      imageProfile: dataSnapshot["imageProfile"],
      email: dataSnapshot["email"],
      password: dataSnapshot["password"],
      name: dataSnapshot["name"],
      age: dataSnapshot["age"],
      phoneNo: dataSnapshot["phoneNo"],
      city: dataSnapshot["city"],
      country: dataSnapshot["country"],
      profileHeading: dataSnapshot["profileHeading"],
      lookingForInPartner: dataSnapshot["lookingForInPartner"],
      publishedDateTime: dataSnapshot["publishedDateTime"],

      /* Appearance */
      height: dataSnapshot["height"],
      weight: dataSnapshot["weight"],
      bodyType: dataSnapshot["bodyType"],

      /* Life style */
      drink: dataSnapshot["drink"],
      smoke: dataSnapshot["smoke"],
      martialStatus: dataSnapshot["martialStatus"],
      haveChildren: dataSnapshot["haveChildren"],
      noOfChildren: dataSnapshot["noOfChildren"],
      profession: dataSnapshot["profession"],
      employmentStatus: dataSnapshot["employmentStatus"],
      income: dataSnapshot["income"],
      livingSituation: dataSnapshot["livingSituation"],
      willingToRelocate: dataSnapshot["willingToRelocate"],
      relationshipYouAreLookingFor: dataSnapshot["relationshipYouAreLookingFor"],

      /* Life style */
      nationality: dataSnapshot["nationality"],
      education: dataSnapshot["education"],
      languageSpoken: dataSnapshot["languageSpoken"],
      religion: dataSnapshot["religion"],
      ethnicity: dataSnapshot["ethnicity"],
    );
  }

  Map<String, dynamic> toJson()=> {
    /* personal info */
    "uid": uid,
    "imageProfile": imageProfile,
    "email": email,
    "password": password,
    "name": name,
    "age": age,
    "phoneNo": phoneNo,
    "city": city,
    "country": country,
    "profileHeading": profileHeading,
    "lookingForInPartner": lookingForInPartner,
    "publishedDateTime": publishedDateTime,

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

    /* Life style */
    "nationality": nationality,
    "education": education,
    "languageSpoken": languageSpoken,
    "religion": religion,
    "ethnicity": ethnicity,
  };

}