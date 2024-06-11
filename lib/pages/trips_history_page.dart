import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:ridewave/constants.dart';
import 'package:ridewave/global/global_var.dart';

class TripsHistoryPage extends StatefulWidget {
  const TripsHistoryPage({super.key});

  @override
  State<TripsHistoryPage> createState() => _TripsHistoryPageState();
}

class _TripsHistoryPageState extends State<TripsHistoryPage> {
  bool visibility = false;
  String tripsCompleted = "";

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, color: kPrimaryColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: whiteColor,
        title: Text(
          'My Trips History',
          style: GoogleFonts.poppins(
              color: kPrimaryColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: height * 0.1,
                child: StreamBuilder(
                    stream: completedTripRequestsOfCurrentUser.onValue,
                    builder: (BuildContext context, snapshotData) {
                      if (snapshotData.hasError ||
                          !snapshotData.hasData ||
                          snapshotData.data!.snapshot.value == null) {
                        return Center(
                          child: Text(
                            "No record found.",
                            style: GoogleFonts.poppins(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      } else if (snapshotData.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: kPrimaryColor,
                          ),
                        );
                      }

                      Map dataTrips = snapshotData.data!.snapshot.value as Map;
                      List tripsList = [];
                      dataTrips.forEach((key, value) =>
                          tripsList.add({"key": key, ...value}));

                      tripsList = tripsList
                          .where((trip) =>
                              (trip["status"] == "cancelled" ||
                                  trip["status"] == "ended") &&
                              trip["userID"] ==
                                  FirebaseAuth.instance.currentUser!.uid)
                          .toList();

                      tripsCompleted = tripsList
                          .where((trip) => trip["status"] == "ended")
                          .length
                          .toString();
                      visibility = tripsList.isNotEmpty;

                      return Container(
                        height: height * 0.25,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Completed Trips",
                                  style: GoogleFonts.poppins(
                                    color: whiteColor,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "$tripsCompleted trips",
                                  style: GoogleFonts.poppins(
                                    color: whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ],
                            ),
                            Lottie.asset(
                              "images/bear.json",
                              height: 140,
                            )
                          ],
                        ),
                      );
                    }),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: height * 0.77,
                width: MediaQuery.of(context).size.width * 0.9,
                child: StreamBuilder(
                  stream: completedTripRequestsOfCurrentUser.onValue,
                  builder: (BuildContext context, snapshotData) {
                    if (snapshotData.hasError ||
                        !snapshotData.hasData ||
                        snapshotData.data!.snapshot.value == null) {
                      return Center(
                        child: Text(
                          "No record found.",
                          style: GoogleFonts.poppins(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }

                    Map dataTrips = snapshotData.data!.snapshot.value as Map;
                    List tripsList = [];
                    dataTrips.forEach(
                        (key, value) => tripsList.add({"key": key, ...value}));

                    tripsList = tripsList
                        .where((trip) =>
                            (trip["status"] == "cancelled" ||
                                trip["status"] == "ended") &&
                            trip["userID"] ==
                                FirebaseAuth.instance.currentUser!.uid)
                        .toList();

                    tripsList.sort((a, b) {
                      DateTime dateA = DateTime.parse(a["publishDateTime"]);
                      DateTime dateB = DateTime.parse(b["publishDateTime"]);
                      return dateB.compareTo(dateA);
                    });

                    visibility = tripsList.isNotEmpty;

                    return visibility
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: tripsList.length,
                            itemBuilder: ((context, index) {
                              if (tripsList[index]["status"] == "cancelled" ||
                                  tripsList[index]["status"] == "ended") {
                                String dropOffAddress =
                                    tripsList[index]["dropOffAddress"];
                                String riderName =
                                    tripsList[index]["riderName"];
                                String riderPhoto =
                                    tripsList[index]["riderPhoto"];
                                String pickUpAddress =
                                    tripsList[index]["pickUpAddress"];
                                String status = tripsList[index]["status"];
                                String publishDateTime =
                                    tripsList[index]["publishDateTime"];
                                DateTime currentDate =
                                    DateTime.parse(publishDateTime);
                                DateTime previousDate = index > 0
                                    ? DateTime.parse(
                                        tripsList[index - 1]["publishDateTime"])
                                    : currentDate;
                                bool showDateDivider = index == 0 ||
                                    currentDate.day != previousDate.day ||
                                    currentDate.month != previousDate.month ||
                                    currentDate.year != previousDate.year;

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (showDateDivider)
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Text(
                                          DateFormat('dd MMM yyyy')
                                              .format(currentDate),
                                          style: GoogleFonts.poppins(
                                            color: kPrimaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    Container(
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                        color: whiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25),
                                                    child: Image.network(
                                                      riderPhoto,
                                                      height: 50,
                                                      width: 50,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      riderName,
                                                      style: GoogleFonts.poppins(
                                                        color: kPrimaryColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons
                                                              .push_pin_rounded,
                                                          color:
                                                              kSecondaryColor,
                                                          size: 15,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                          child: Text(
                                                            pickUpAddress,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  kSecondaryColor,
                                                              fontSize: 12,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Icons.pin_drop,
                                                          color:
                                                              kSecondaryColor,
                                                          size: 15,
                                                        ),
                                                        const SizedBox(
                                                            width: 5),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.5,
                                                          child: Text(
                                                            dropOffAddress,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              color:
                                                                  kSecondaryColor,
                                                              fontSize: 12,
                                                            ),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      DateFormat(
                                                              'dd MMM yyyy HH:mm')
                                                          .format(currentDate),
                                                      style: GoogleFonts.poppins(
                                                        color: kSecondaryColor,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Text(
                                              status == "ended"
                                                  ? "Done"
                                                  : "Cancelled",
                                              style: GoogleFonts.jost(
                                                color: status == "ended"
                                                    ? Colors.green
                                                    : Colors.red,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              } else {
                                return Container();
                              }
                            }),
                          )
                        : SizedBox(
                            height: height * 0.4,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Lottie.asset(
                                  "images/norecord.json",
                                  height: 100,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  "No record found.",
                                  style: GoogleFonts.poppins(
                                    color: kPrimaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}