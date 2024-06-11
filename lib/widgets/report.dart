import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridewave/constants.dart';

class ReportDialog extends StatefulWidget {
  const ReportDialog({super.key});

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final reportDescriptionTextEditingController = TextEditingController();

  final FirebaseAuth userFirebase = FirebaseAuth.instance;

  final List<String?> items = [
    null, // Added a null item for the "Select Here" option
    "Medical",
    "Safety",
    "Technical",
    "Others",
  ];
  String? selectedReportType;

  void submitReport() {
    DatabaseReference userReportRef = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(userFirebase.currentUser!.uid)
        .child("report");

    Map report = {
      "reportType": selectedReportType,
      "reportDescription": reportDescriptionTextEditingController.text.trim(),
    };
    userReportRef.push().set(report);
    Navigator.pop(context, "Report sent!");
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(0.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.close,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  "Report",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  width: 40,
                ), // Adjust as needed
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 1.5,
              color: Colors.white70,
              thickness: 1.0,
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Report Type:",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 92),
                    decoration: BoxDecoration(
                      color: kSecondaryColor, // Set to kSecondaryColor
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.white),
                    ),
                    child: DropdownButton<String?>(
                      value: selectedReportType,
                      items: items.map((String? value) {
                        return DropdownMenuItem<String?>(
                          value: value,
                          child: Text(
                            value ??
                                "Select..", // Display "Select Here" when null
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedReportType = newValue;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          Text(
                            "Description (Optional): ",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: reportDescriptionTextEditingController,
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      labelText: 'Type Here...',
                      labelStyle: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                        fontSize: 12,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.white),
                      ),
                      filled: true,
                      fillColor: kSecondaryColor, // Set to kSecondaryColor
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 31,
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedReportType == null) {
                  // Report type not selected
                  // Set button color to grey and text color to white
                  // Adjust the colors as needed
                  Navigator.pop(context, "Report type not selected!");
                } else {
                  // Report type selected
                  submitReport();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedReportType == null
                    ? Colors.grey // Grey color when report type not selected
                    : kPrimaryColor, // Original color when report type selected
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(
                    color: Colors.white,
                    width: 3.0, // Set the border width
                  ),
                ),
                minimumSize: const Size(130, 45),
                elevation: 10, // Set the elevation for shadow
                shadowColor: Colors.black, // Set the shadow color
              ),
              child: Text(
                "Send",
                style: GoogleFonts.poppins(
                  color: selectedReportType == null
                      ? Colors.white // White text when report type not selected
                      : Colors
                          .white, // Original text color when report type selected
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(
              height: 41,
            )
          ],
        ),
      ),
    );
  }
}
