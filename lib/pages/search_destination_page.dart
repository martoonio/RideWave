import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ridewave/constants.dart';
import 'package:ridewave/global/global_var.dart';
import 'package:ridewave/methods/common_methods.dart';
import 'package:ridewave/models/prediction_model.dart';
import 'package:ridewave/widgets/prediction_place_ui.dart';


class SearchDestinationPage extends StatefulWidget {
  const SearchDestinationPage({super.key});

  @override
  State<SearchDestinationPage> createState() => _SearchDestinationPageState();
}

class _SearchDestinationPageState extends State<SearchDestinationPage> {
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController destinationTextEditingController =
      TextEditingController();
  List<PredictionModel> dropOffPredictionsPlacesList = [];

  ///Places API - Place AutoComplete
  searchLocation(String locationName) async {
    if (locationName.length > 1) {
      String apiPlacesUrl =
          "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$locationName&key=$googleMapKey&components=country:ID";

      var responseFromPlacesAPI =
          await CommonMethods.sendRequestToAPI(apiPlacesUrl);

      if (responseFromPlacesAPI == "error") {
        return;
      }

      if (responseFromPlacesAPI["status"] == "OK") {
        var predictionResultInJson = responseFromPlacesAPI["predictions"];
        var predictionsList = (predictionResultInJson as List)
            .map((eachPlacePrediction) =>
                PredictionModel.fromJson(eachPlacePrediction))
            .toList();

        setState(() {
          dropOffPredictionsPlacesList = predictionsList;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // pickUpTextEditingController.text = userAddress;
    destinationTextEditingController.text = "ITB Jatinangor";

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              // elevation: 10,
              child: Container(
                height: 290,
                decoration: const BoxDecoration(
                  color: kPrimaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 24, top: 48, right: 24, bottom: 20),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 6,
                      ),

                      //icon button - title
                      Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                              setState(() {
                                dropOffPredictionsPlacesList.clear();
                                pickUpTextEditingController.clear();
                              });
                            },
                            child: const Icon(
                              Icons.chevron_left,
                              color: Colors.white,
                            ),
                          ),
                          Center(
                            child: Text(
                              "Set Location",
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 18,
                      ),

                      //pickup text field
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: whiteColor, size: 15),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Pickup Location",
                                      style: GoogleFonts.poppins(
                                        color: whiteColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: TextField(
                                      controller: pickUpTextEditingController,
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      onChanged: (inputText) {
                                        searchLocation(inputText);
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Pickup Address",
                                        hintStyle: const TextStyle(
                                          color: Colors.black54,
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: const EdgeInsets.only(
                                            left: 11, top: 9, bottom: 9),
                                        suffixIcon: pickUpTextEditingController
                                                .text.isNotEmpty
                                            ? IconButton(
                                                icon: const Icon(Icons.clear),
                                                onPressed: () {
                                                  pickUpTextEditingController
                                                      .clear();
                                                  setState(() {
                                                    dropOffPredictionsPlacesList
                                                        .clear();
                                                    pickUpTextEditingController
                                                        .clear();
                                                  });
                                                },
                                              )
                                            : null,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 11,
                      ),

                      //destination text field
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(Icons.location_on,
                                        color: whiteColor, size: 15),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "Drop off Location",
                                      style: GoogleFonts.poppins(
                                        color: whiteColor,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: TextField(
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                      controller:
                                          destinationTextEditingController,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Destination Address",
                                        hintStyle: const TextStyle(
                                          color: Colors.black54,
                                        ),
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: InputBorder.none,
                                        isDense: true,
                                        contentPadding: const EdgeInsets.only(
                                            left: 11, top: 9, bottom: 9),
                                        suffixIcon:
                                            destinationTextEditingController
                                                    .text.isNotEmpty
                                                ? IconButton(
                                                    icon:
                                                        const Icon(Icons.clear),
                                                    onPressed: () {
                                                      destinationTextEditingController
                                                          .clear();
                                                    },
                                                  )
                                                : null,
                                      ),
                                      enabled: false,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            //display prediction results for destination place
            (dropOffPredictionsPlacesList.isNotEmpty)
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListView.separated(
                      padding: const EdgeInsets.all(0),
                      itemBuilder: (context, index) {
                        return Card(
                          // elevation: 3,
                          color: whiteColor,
                          // elevation: 3,
                          child: PredictionPlaceUI(
                            predictedPlaceData:
                                dropOffPredictionsPlacesList[index],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        height: 2,
                      ),
                      itemCount: dropOffPredictionsPlacesList.length,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
