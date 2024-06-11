// ignore_for_file: body_might_complete_normally_catch_error

import 'dart:io';

import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridewave/constants.dart';
import 'package:ridewave/pages/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../methods/common_methods.dart';
import '../widgets/loading_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'login_screen.dart';

class SignUpScreen2 extends StatefulWidget {
  const SignUpScreen2({super.key});

  @override
  State<SignUpScreen2> createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  TextEditingController userNameTextEditingController = TextEditingController();
  TextEditingController userPhoneTextEditingController =
      TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController vehicleModelTextEditingController =
      TextEditingController();
  TextEditingController vehicleColorTextEditingController =
      TextEditingController();
  TextEditingController vehicleNumberTextEditingController =
      TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  CommonMethods cMethods = CommonMethods();
  XFile? imageFile;
  String urlOfUploadedImage = "";

  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();

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

    if (imageFile != null) //image validation
    {
      signUpFormValidation();
    } else {
      cMethods.displaySnackBar("Please choose image first.", context);
    }
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
        uploadImageToStorage();
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

    registerNewDriver();
  }

  registerNewDriver() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) =>
          LoadingDialog(messageText: "Registering your account..."),
    );

    if (_formKey.currentState!.validate()) {
      final User? userFirebase = (await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
        email: emailTextEditingController.text.trim(),
        password: passwordTextEditingController.text.trim(),
      )
              .catchError((errorMsg) {
        Navigator.pop(context);
        cMethods.displaySnackBar(errorMsg.toString(), context);
      }))
          .user;

      if (!context.mounted) return;
      Navigator.pop(context);

      DatabaseReference usersRef = FirebaseDatabase.instance
          .ref()
          .child("riders")
          .child(userFirebase!.uid);

      DatabaseReference usersRef2 = FirebaseDatabase.instance
          .ref()
          .child("users")
          .child(userFirebase.uid);


      Map driverDataMap = {
        "photo": urlOfUploadedImage,
        "name": userNameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": userPhoneTextEditingController.text.trim(),
        "faculty": selectedFaculty,
        "password": passwordTextEditingController.text.trim(),
        "id": userFirebase.uid,
        "blockStatus": "no",
      };
      usersRef.set(driverDataMap);

      Map userDataMap = {
        "photo" : urlOfUploadedImage,
        "name": userNameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": userPhoneTextEditingController.text.trim(),
        "faculty": selectedFaculty,
        "password": passwordTextEditingController.text.trim(),
        "id": userFirebase.uid,
        "blockStatus": "no",
      };
      usersRef2.set(userDataMap);
      

      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const Dashboard()));
    } else {
      Navigator.pop(context);
      cMethods.displaySnackBar("Please fill up the form correctly", context);
    }
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
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 0,
        title: Text(
          "Sign Up",
          style: GoogleFonts.poppins(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
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
                      shape: BoxShape.circle,  // Mengubah bentuk menjadi rectangle
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
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: userNameTextEditingController,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            inputFormatters: [LengthLimitingTextInputFormatter(50)],
                            decoration: InputDecoration(
                              hintText: "Username",
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              filled: true,
                              fillColor: Color(0xFF82A5B3),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                    color: Color(0xFF82A5B3)),
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    IntlPhoneField(
                      showCountryFlag: true,
                      dropdownIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: "Phone Number",
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
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
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                              color: kSecondaryColor),
                        ),
                        prefixIcon: const Icon(
                          Icons.mail,
                          color: Colors.white,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        validateEmail(emailTextEditingController.text);
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (EmailValidator.validate(value) == false) {
                          return 'Please enter a valid email';
                        }
                        if (value.length < 3) {
                          return 'Please enter a valid email';
                        }
                        if (value.length > 99) {
                          return 'Email must be less than 100 characters long';
                        }
                        if (!value.endsWith("ac.id")) {
                          return 'Please use our ac.id email';
                        }
                        return null;
                      },
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
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (text.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        if (text.length > 49) {
                          return 'Password must be less than 50 characters long';
                        }
                        return null;
                      },
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
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: kSecondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value != passwordTextEditingController.text) {
                          return 'Password does not match!';
                        }
                        return null;
                      },
                      onChanged: (text) => setState(() {
                        confirmPasswordTextEditingController.text = text;
                      }),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        checkIfNetworkIsAvailable();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF054C67),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.white, width: 3)),
                        minimumSize: Size(200, 50),
                      ),
                      child: Text("Sign Up",
                      selectionColor: kSecondaryColor,
                        style: TextStyle(
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
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(width: 5),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LoginScreen()));
                                        },
                                        child: Text(
                                          "Log In!",
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            color: Colors.white,
                                          ),
                                        )),
                                  ],
                                ),
                    SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
