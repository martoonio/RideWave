import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
import "package:google_fonts/google_fonts.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";
import "package:intl/intl.dart";
import "package:lottie/lottie.dart";
import "package:ridewave/constants.dart";
import "package:ridewave/global/global_var.dart";
import "package:ridewave/pages/profile_page.dart";
import "package:ridewave/pages/trips_history_page.dart";
import "package:ridewave/widgets/logout_dialog.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool visibility = false;

  retrieveCurrentUserInfo() async {
    await FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(FirebaseAuth.instance.currentUser!.uid)
        .once()
        .then((snap) {
      userName = (snap.snapshot.value as Map)["name"];
      userPhone = (snap.snapshot.value as Map)["phone"];
      userFaculty = (snap.snapshot.value as Map)["faculty"];
      userEmail = (snap.snapshot.value as Map)["email"];
      userPhoto = (snap.snapshot.value as Map)["photo"];
    });
  }

  @override
  void initState() {
    super.initState();
    retrieveCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          },
          icon: const Icon(Icons.person),
        ),
        title: Image.asset(
          "images/riders.png",
          height: 50,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return LogOutDialog(
                      title: "Logout",
                      description: "Are you sure you want to logout?",
                    );
                  });
            },
            icon: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    color: kPrimaryColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Hi, $userName!",
                                          style: GoogleFonts.poppins(
                                            color: whiteColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Current Location",
                                          style: GoogleFonts.poppins(
                                            color: whiteColor,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 10),
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 5,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: Stack(
                                  children: [
                                    Center(
                                      child: GoogleMap(
                                        initialCameraPosition:
                                            googlePlexInitialPosition,
                                        myLocationEnabled: true,
                                        myLocationButtonEnabled: true,
                                        zoomControlsEnabled: false,
                                        scrollGesturesEnabled: false,
                                        mapType: MapType.normal,
                                        onMapCreated: (GoogleMapController
                                            controller) async {
                                          currentPositionOfUser =
                                              await Geolocator
                                                  .getCurrentPosition(
                                            desiredAccuracy:
                                                LocationAccuracy.high,
                                          );
                                          controller.animateCamera(
                                            CameraUpdate.newCameraPosition(
                                              CameraPosition(
                                                target: LatLng(
                                                  currentPositionOfUser!
                                                      .latitude,
                                                  currentPositionOfUser!
                                                      .longitude,
                                                ),
                                                zoom: 18,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Lottie.asset(
                                            "images/helmet.json",
                                            height: 100,
                                            repeat: false)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "History",
                          style: GoogleFonts.poppins(
                            color: kPrimaryColor,
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TripsHistoryPage(),
                              ),
                            );
                          },
                          child: Text(
                            "View All",
                            style: GoogleFonts.poppins(
                              color: kPrimaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                              decorationColor: kPrimaryColor,
                              decorationThickness: 2,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                        height: height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: StreamBuilder(
                            stream: completedTripRequestsOfCurrentUser.onValue,
                            builder: (BuildContext context, snapshotData) {
                              if (snapshotData.hasError) {
                                return Center(
                                  child: Text(
                                    "Error Occurred.",
                                    style: GoogleFonts.poppins(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              }

                              if (!(snapshotData.hasData)) {
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

                              Map dataTrips =
                                  snapshotData.data!.snapshot.value as Map;
                              List tripsList = [];
                              dataTrips.forEach((key, value) =>
                                  tripsList.add({"key": key, ...value}));

                              tripsList = tripsList
                                  .where((trip) =>
                                      (trip["status"] == "cancelled" ||
                                          trip["status"] == "ended") &&
                                      trip["userID"] ==
                                          FirebaseAuth
                                              .instance.currentUser!.uid)
                                  .toList();

                              visibility = tripsList.isNotEmpty;

                              return visibility
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: tripsList.length,
                                      itemBuilder: ((context, index) {
                                        if (tripsList[index]["status"] ==
                                                "cancelled" ||
                                            tripsList[index]["status"] ==
                                                "ended") {
                                          String dropOffAddress = "";
                                          dropOffAddress =
                                              tripsList[index]["pickUpAddress"];
                                          return Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0.0),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(25),
                                                        child: Image.network(
                                                          tripsList[index]
                                                                  ["riderPhoto"]
                                                              .toString(),
                                                          height: 50,
                                                          width: 50,
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          tripsList[index]
                                                                  ["riderName"]
                                                              .toString(),
                                                          style: GoogleFonts
                                                              .poppins(
                                                            color:
                                                                kPrimaryColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
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
                                                                width:
                                                                    5), // Add a small gap between the icon and the text
                                                            SizedBox(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  0.5, // Adjust width as needed
                                                              child: Text(
                                                                dropOffAddress,
                                                                style:
                                                                    GoogleFonts
                                                                        .jost(
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
                                                        Text(
                                                          DateFormat(
                                                                  'dd MMM yyyy HH:mm')
                                                              .format(DateTime.parse(
                                                                  tripsList[index]
                                                                          [
                                                                          "publishDateTime"]
                                                                      .toString())),
                                                          style:
                                                              GoogleFonts.jost(
                                                            color:
                                                                kSecondaryColor,
                                                            fontSize: 12,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  tripsList[index]["status"]
                                                              .toString() ==
                                                          "ended"
                                                      ? "Done"
                                                      : "Cancelled",
                                                  style: GoogleFonts.jost(
                                                      color: tripsList[index]
                                                                      ["status"]
                                                                  .toString() ==
                                                              "ended"
                                                          ? Colors.green
                                                          : Colors.red,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 11),
                                                ),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return Container();
                                        }
                                      }),
                                    )
                                  : SizedBox(
                                      height: height * 0.4,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Lottie.asset(
                                            "images/norecord.json",
                                            height: 100,
                                            repeat: false,
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
                            })),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
