import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridewave/constants.dart';
import 'package:ridewave/global/trip_var.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({Key? key, required String riderID}) : super(key: key);

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  final ratingDescriptionTextEditingController = TextEditingController();
  final FirebaseAuth userFirebase = FirebaseAuth.instance;
  int selectedRating = 0;

  void submitRating(String riderID) {
    DatabaseReference userReportRef = FirebaseDatabase.instance
        .ref()
        .child("riders")
        .child(riderID)
        .child("rating");

    Map rating = {
      "users": userFirebase.currentUser!.uid,
      "rating": selectedRating,
      "ratingDescription": ratingDescriptionTextEditingController.text.trim(),
    };
    userReportRef.push().set(rating);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(
        child: Form(
          // Wrap your content in a Form widget
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Text above the container
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Yeay! We have arrived...",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(0.0),
                width: double.infinity,
                // Set a fixed height to match the ReportDialog container height
                height: 400, // Adjust the height as needed
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            nameDriver,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            riderFaculty,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedRating = index + 1;
                                    });
                                  },
                                  child: Icon(
                                    Icons.star,
                                    color: index < selectedRating
                                        ? Colors.amber
                                        : Colors.grey,
                                    size: 40,
                                  ),
                                );
                              }),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              controller:
                                  ratingDescriptionTextEditingController,
                              style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                labelText: 'Write here...',
                                labelStyle: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                filled: true,
                                fillColor: kSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // Add your other widgets here
                    ],
                  ),
                ),
              ),
              // Elevated button below the container
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  submitRating(riderID);
                  Navigator.pop(context, "rated");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: kPrimaryColor),
                  ),
                  minimumSize: Size(130, 45),
                ),
                child: Text(
                  "Send",
                  style: GoogleFonts.poppins(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
