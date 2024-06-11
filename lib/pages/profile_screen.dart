import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridewave/constants.dart';
import 'package:ridewave/global/global_var.dart';
import 'package:ridewave/pages/profile_page.dart';
import 'package:ridewave/pages/trips_history_page.dart';
import 'package:ridewave/widgets/logout_dialog.dart';
import 'package:ridewave/widgets/report.dart';

import '../about/about.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Menu",
            style: GoogleFonts.poppins(
                fontSize: 25, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          backgroundColor: kPrimaryColor,
          // elevation: 10,
        ),
        backgroundColor: whiteColor,
        body: SingleChildScrollView(
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(8),
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 22),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 20,
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
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              userName,
                              style: GoogleFonts.poppins(
                                  fontSize: 25,
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              userFaculty,
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const ProfilePage()));
                                    },
                                    child: Text(
                                      "Edit Profile",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.history,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const TripsHistoryPage()));
                                    },
                                    child: Text(
                                      "History",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.report,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            const ReportDialog(),
                                      );
                                    },
                                    child: Text(
                                      "Report",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.info,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const About()));
                                    },
                                    child: Text(
                                      "About RideWave",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                    )),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.logout,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      showDialog(context: context, builder: (BuildContext context) {
                                        return LogOutDialog(
                                          title: "Logout",
                                          description: "Are you sure you want to logout?",
                                        );
                                    });
                                    },
                                    child: Text(
                                      "Logout",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Colors.red,
                                          fontWeight: FontWeight.normal),
                                    )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ));
  }
}
