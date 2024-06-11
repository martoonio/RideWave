import 'package:google_fonts/google_fonts.dart';
import 'package:ridewave/constants.dart';
import 'package:ridewave/global/global_var.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:ridewave/widgets/logout_dialog.dart";

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();

  setDriverInfo() {
    setState(() {
      nameTextEditingController.text = userName;
      phoneTextEditingController.text = userPhone;
      
      emailTextEditingController.text =
          FirebaseAuth.instance.currentUser!.email.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setDriverInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: whiteColor,
          ),
        ),
        backgroundColor: kPrimaryColor,
        // elevation: 10,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(userPhoto),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              //driver name
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 8),
                child: TextField(
                  controller: nameTextEditingController,
                  textAlign: TextAlign.start,
                  enabled: false,
                  style: GoogleFonts.poppins(fontSize: 16, color: whiteColor),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white24,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                        width: 3,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.person,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              //driver phone
              Padding(
                padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 4),
                child: TextField(
                  controller: phoneTextEditingController,
                  textAlign: TextAlign.start,
                  enabled: false,
                  style: GoogleFonts.poppins(fontSize: 16, color: whiteColor),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white24,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                        width: 3,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.phone_android_outlined,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              //driver email
              Padding(
                padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 4),
                child: TextField(
                  controller: emailTextEditingController,
                  textAlign: TextAlign.start,
                  enabled: false,
                  style: GoogleFonts.poppins(fontSize: 16, color: whiteColor),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white24,
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                        width: 3,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.email,
                      color: whiteColor,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              //driver car info
              
              const SizedBox(
                height: 20,
              ),

              //logout btn
              ElevatedButton(
                onPressed: () {
                  showDialog(context: context, builder: (BuildContext context) {
                  return LogOutDialog(
                    title: "Logout",
                    description: "Are you sure you want to logout?",
                  );
              });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 18)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.logout, color: whiteColor,),
                        SizedBox(width: 20,),
                        Text("Logout",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          letterSpacing: 2.5,
                          color: whiteColor,
                        )),
                      ],
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
