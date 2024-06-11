import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

String userName = "";
String userPhone = "";
String userID = FirebaseAuth.instance.currentUser!.uid;
String userEmail = FirebaseAuth.instance.currentUser!.email!;
String userPhoto = "";
String userFaculty = "";
String mode = "";

String stateOfApp = "normal";

Position? currentPositionOfUser;

final completedTripRequestsOfCurrentUser =
    FirebaseDatabase.instance.ref().child("tripRequests");

String googleMapKey = "AIzaSyDlN7pUZ_oPhroD-gHODW-f6uQ1sR6fH4Y";
String serverKeyFCM =
    "AAAA8T3NH9Q:APA91bGRVxUuAhTKq977f73yYzz8T8IPy4zd4-aopiDXB0_LDwfUJh-Q6sFS7lbrStyBmdSifHTjw5WlV9x7-dXAI0NhbP_8lR88vLtriiTAn7lXU5Ovpx1Zmd9NtTxTELHCH8LZPlhx";

const CameraPosition googlePlexInitialPosition = CameraPosition(
  target: LatLng(-6.929851, 107.769440),
  zoom: 14.4746,
);
