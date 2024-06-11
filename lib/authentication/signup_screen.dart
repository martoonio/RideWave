import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:ridewave/authentication/login_screen.dart';
import 'package:ridewave/constants.dart';
import 'package:ridewave/methods/common_methods.dart';
import 'package:ridewave/pages/dashboard.dart';
import 'package:ridewave/widgets/loading_dialog.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController userPhoneTextEditingController =
      TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  CommonMethods cMethods = CommonMethods();
  XFile? imageFile;
  String urlOfUploadedImage = "";

  bool _passwordVisible = false;

  final List<String> items = [
    "Fakultas Ilmu dan Teknologi Kebumian",
    "Fakultas Matematika dan Ilmu Pengetahuan Alam",
    "Fakultas Seni Rupa dan Desain",
    "Fakultas Teknologi Industri",
    "Fakultas Teknik Sipil dan Lingkungan",
    "Fakultas Teknik Mesin dan Dirgantara",
    "Fakultas Teknik Pertambangan dan Perminyakan",
    "Sekolah Arsitektur, Perencanaan dan Pengembangan Kebijakan",
    "Sekolah Bisnis dan Manajemen",
    "Sekolah Farmasi",
    "Sekolah Ilmu dan Teknologi Hayati",
    "Sekolah Teknik Elektro dan Informatika",
  ];
  String? selectedFaculty;

  void validateEmail(String email) {
    if (email.startsWith("160") ||
        email.startsWith("101") ||
        email.startsWith("102") ||
        email.startsWith("103") ||
        email.startsWith("105") ||
        email.startsWith("108")) {
      selectedFaculty = "FMIPA";
    } else if (email.startsWith("161") ||
        email.startsWith("104") ||
        email.startsWith("106")) {
      selectedFaculty = "SITH-S";
    } else if (email.startsWith("198") ||
        email.startsWith("112") ||
        email.startsWith("114") ||
        email.startsWith("115") ||
        email.startsWith("119")) {
      selectedFaculty = "SITH-R";
    } else if (email.startsWith("162") ||
        email.startsWith("107") ||
        email.startsWith("116")) {
      selectedFaculty = "SF";
    } else if (email.startsWith("164") ||
        email.startsWith("121") ||
        email.startsWith("122") ||
        email.startsWith("123") ||
        email.startsWith("125")) {
      selectedFaculty = "FTTM";
    } else if (email.startsWith("120") ||
        email.startsWith("128") ||
        email.startsWith("129") ||
        email.startsWith("151") ||
        email.startsWith("163")) {
      selectedFaculty = "FITB";
    } else if (email.startsWith("130") ||
        email.startsWith("133") ||
        email.startsWith("134") ||
        email.startsWith("143") ||
        email.startsWith("144") ||
        email.startsWith("145") ||
        email.startsWith("167")) {
      selectedFaculty = "FTI";
    } else if (email.startsWith("132") ||
        email.startsWith("165") ||
        email.startsWith("180") ||
        email.startsWith("181") ||
        email.startsWith("183")) {
      selectedFaculty = "STEI-R";
    } else if (email.startsWith("135") ||
        email.startsWith("182") ||
        email.startsWith("196")) {
      selectedFaculty = "STEI-K";
    } else if (email.startsWith("131") ||
        email.startsWith("136") ||
        email.startsWith("137") ||
        email.startsWith("169")) {
      selectedFaculty = "FTMD";
    } else if (email.startsWith("150") ||
        email.startsWith("153") ||
        email.startsWith("155") ||
        email.startsWith("157") ||
        email.startsWith("158") ||
        email.startsWith("166")) {
      selectedFaculty = "FTSL";
    } else if (email.startsWith("152") ||
        email.startsWith("154") ||
        email.startsWith("199")) {
      selectedFaculty = "SAPPK";
    } else if (email.startsWith("168") ||
        email.startsWith("170") ||
        email.startsWith("172") ||
        email.startsWith("173") ||
        email.startsWith("174") ||
        email.startsWith("175")) {
      selectedFaculty = "FSRD";
    } else if (email.startsWith("190") ||
        email.startsWith("192") ||
        email.startsWith("197")) {
      selectedFaculty = "SBM";
    } else {
      selectedFaculty = null; // Set to null if no match is found
    }
  }

  checkIfNetworkIsAvailable() {
    cMethods.checkConnectivity(context);

    signUpFormValidation();
  }

  signUpFormValidation() {
  if (userNameTextEditingController.text.trim().length < 3) {
    cMethods.displaySnackBar(
        "Your name must be at least 4 or more characters.", context);
  } else if (userPhoneTextEditingController.text.trim().length < 7) {
    cMethods.displaySnackBar(
        "Your phone number must be at least 8 or more characters.", context);
  } else if (!emailTextEditingController.text.contains("@")) {
    cMethods.displaySnackBar("Please write a valid email.", context);
  } else {
    validateEmail(emailTextEditingController.text);

    if (selectedFaculty == null) {
      cMethods.displaySnackBar("Faculty not recognized.", context);
    } else {

      if (passwordTextEditingController.text.trim().length < 5) {
        cMethods.displaySnackBar(
            "Your password must be at least 6 or more characters.", context);
      } else {
        registerNewUser();
      }
    }
  }
}

  uploadImageToStorage() async {
    String imageIDName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceImage =
        FirebaseStorage.instance.ref().child("Images").child(imageIDName);

    UploadTask uploadTask = referenceImage.putFile(File(imageFile!.path));
    TaskSnapshot snapshot = await uploadTask;
    urlOfUploadedImage = await snapshot.ref.getDownloadURL();

    setState(() {
      urlOfUploadedImage;
    });

    registerNewUser();
  }

  registerNewUser() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: "Registering your account..."),
    );

    final User? userFirebase = (await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
            // ignore: body_might_complete_normally_catch_error
            .catchError((errorMsg) {
      Navigator.pop(context);
      cMethods.displaySnackBar(errorMsg.toString(), context);
    }))
        .user;

    if (!context.mounted) return;
    Navigator.pop(context);

    //Real Time Database
    DatabaseReference usersRef =
        FirebaseDatabase.instance.ref().child("users").child(userFirebase!.uid);

    DatabaseReference riderRef =
        FirebaseDatabase.instance.ref().child("riders").child(userFirebase.uid);


    Map userDataMap = {
      "photo": urlOfUploadedImage,
      "name": userNameTextEditingController.text.trim(),
      "email": emailTextEditingController.text.trim(),
      "phone": userPhoneTextEditingController.text.trim(),
      "password": passwordTextEditingController.text.trim(),
      "faculty": selectedFaculty,
      "id": userFirebase.uid,
      "blockStatus": "no",
    };

    Map riderMap = {
      "photo": urlOfUploadedImage,
      "id": userFirebase.uid,
      "name": userNameTextEditingController.text.trim(),
      "phone": userPhoneTextEditingController.text.trim(),
      "faculty": selectedFaculty,
      "email": emailTextEditingController.text.trim(),
      "password": passwordTextEditingController.text.trim(),
      "vehicle_details": "",
      "blockStatus": "no",
    };

    usersRef.set(userDataMap);
    riderRef.set(riderMap);

    // if (userFirebase != null) {
    //       await usersRefFirestore
    //           .collection('users')
    //           .doc(userFirebase!.uid)
    //           .set({
    //   "id": userFirebase.uid,
    //   "name": userNameTextEditingController.text.trim(),
    //   "phone": userPhoneTextEditingController.text.trim(),
    //   "faculty": selectedFaculty,
    //   "email": emailTextEditingController.text.trim(),
    //   "password": passwordTextEditingController.text.trim(),
    //   "vehicle_details": "",
    //   "blockStatus": "no",
    //       });
    //     }

    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const Dashboard()));
  }

  chooseImageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        imageFile = pickedFile;
      });
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: kPrimaryColor,
        title: Text(
          'RideWave',
          style: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  chooseImageFromGallery();
                },
                child: imageFile != null
                ? Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,  // Mengubah bentuk menjadi rectangle
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.cover,  // Memastikan gambar mencakup seluruh container
                        image: FileImage(File(imageFile!.path)),
                      ),
                    ),
                  )
                : Container(
                    width: 180,
                    height: 180,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,  // Mengubah bentuk menjadi rectangle
                      color: Colors.transparent,
                      image: DecorationImage(
                        fit: BoxFit.cover,  // Memastikan gambar mencakup seluruh container
                        image: AssetImage("images/profile_default.png"),
                      ),
                    ),
                  ),  
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Choose Profile Picture",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),


              const SizedBox(
                height: 10,
              ),

              //text fields + button
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  children: [
                    TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                              color: kSecondaryColor),
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (text) => setState(() {
                        userNameTextEditingController.text = text;
                      }),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    IntlPhoneField(
                      showCountryFlag: true,
                      dropdownIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                              color: kSecondaryColor),
                        ),
                      ),
                      initialCountryCode: 'ID',
                      onChanged: (text) {
                        setState(() {
                          userPhoneTextEditingController.text =
                              text.completeNumber;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                      inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                              color: kSecondaryColor),
                        ),
                        prefixIcon: const Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                      ),
                      onChanged: (text) => setState(() {
                        emailTextEditingController.text = text;
                      }),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                      obscureText: !_passwordVisible,
                      inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                              color: kSecondaryColor),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      onChanged: (text) => setState(() {
                        passwordTextEditingController.text = text;
                      }),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    TextFormField(
                      obscureText: !_passwordVisible,
                      inputFormatters: [LengthLimitingTextInputFormatter(50)],
                      decoration: InputDecoration(
                        hintText: "Confirm Password",
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                              color: kSecondaryColor),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.white,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                      onChanged: (text) => setState(() {
                        confirmPasswordTextEditingController.text = text;
                      }),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        checkIfNetworkIsAvailable();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF054C67),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(color: Colors.white)),
                        minimumSize: const Size(200, 50),
                      ),
                      child: Text(
                        "Sign Up",
                        selectionColor: kSecondaryColor,
                        style: GoogleFonts.poppins(
                            color: whiteColor, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              //textbutton
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: Text(
                        "Log In!",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
