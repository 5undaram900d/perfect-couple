
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect_couple/Controllers/authentication_controller.dart';
import 'package:perfect_couple/Widgets/custom_text_field.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

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

  bool showProgressBar = false;

  var authenticationController = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 80,),
              const Text('Create Account', style: TextStyle(fontSize: 25, color: Colors.pink, fontWeight: FontWeight.bold,),),
              // SizedBox(height: 5,),
              const Text('To get started now', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink,),),
              const SizedBox(height: 15,),
              /* circle avatar */
              authenticationController.imageFile == null
              ? const CircleAvatar(radius: 80, backgroundImage: AssetImage('images/profile.png'), backgroundColor: Colors.blue,)
              : Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                    image: DecorationImage(fit: BoxFit.fitHeight, image: FileImage(File(authenticationController.imageFile!.path),),),
                  ),
                ),
              /* choose image */
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () async{
                      await authenticationController.pickImageFileFromGallery();
                      setState(() {
                        authenticationController.imageFile;
                      });
                    },
                    icon: const Icon(Icons.image_outlined),
                  ),
                  const SizedBox(width: 10,),
                  IconButton(
                    onPressed: () async{
                      await authenticationController.captureImageFileFromPhoneCamera();
                      setState(() {
                        authenticationController.imageFile;
                      });
                    },
                    icon: const Icon(Icons.camera_alt_outlined),
                  ),
                ],
              ),
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
              /* email */
              CustomTextField(
                editingController: emailTextEditingController,
                labelText: "Email",
                iconData: Icons.email_outlined,
                isObscure: false,
              ),
              const SizedBox(height: 15,),
              /* password */
              CustomTextField(
                editingController: passwordTextEditingController,
                labelText: "Password",
                iconData: Icons.lock_clock_outlined,
                isObscure: true,
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
                    if(authenticationController.profileImage != null){
                      if(
                      /* personal info */
                      nameTextEditingController.text.trim().isNotEmpty &&
                      emailTextEditingController.text.trim().isNotEmpty &&
                      passwordTextEditingController.text.trim().isNotEmpty &&
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
                        setState(() {
                          showProgressBar = true;
                        });

                        await authenticationController.createNewUserAccount(
                          /* personal info */
                          authenticationController.profileImage!,
                          emailTextEditingController.text.trim(),
                          passwordTextEditingController.text.trim(),
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
                        );
                        setState(() {
                          showProgressBar = false;
                          authenticationController.imageFile = null;
                        });
                      }
                      else{
                        Get.snackbar("Empty Field", "Please fill all the fields.");
                      }
                    }
                    else{
                      Get.snackbar("Image File Missing", "Please select image form camera or gallery");
                    }
                  },
                  child: const Center(child: Text('Register', style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold,),),),
                ),
              ),
              const SizedBox(height: 15,),
              /* already have an account */
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? ", style: TextStyle(fontSize: 16, color: Colors.grey,),),
                  InkWell(
                    onTap: ()=> Get.back(),
                    child: const Text("Register here", style: TextStyle(fontSize: 18, color: Colors.blue, fontWeight: FontWeight.bold,),),
                  ),
                ],
              ),
              const SizedBox(height: 15,),
              /* progressBar */
              showProgressBar==true ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),) : Container(),
              const SizedBox(height: 30,),
            ],
          ),
        ),
      ),
    );
  }
}
