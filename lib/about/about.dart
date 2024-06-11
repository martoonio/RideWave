import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class About extends StatefulWidget {
  const About({Key? key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 0),
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 8,
                    top: 40,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: -51,
                    top: 615,
                    child: Container(
                      width: 487,
                      height: 229,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/about/itbPreview.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 15,
                    top: 810,
                    child: Container(
                      width: 375,
                      height: 34,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(),
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(width: 375, height: 34),
                          ),
                          Positioned(
                            left: 121,
                            top: 20,
                            child: Container(
                              width: 134,
                              height: 5,
                              decoration: ShapeDecoration(
                                color: Color(0xFF060606),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 141,
                    child: SizedBox(
                      width: 266,
                      height: 73,
                      child: Text(
                        'RIDEWAVE',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          decoration: TextDecoration.none,
                          color: Color(0xFF054C67),
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 103,
                    child: Text(
                      'Welcome to',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        decoration: TextDecoration.none,
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        height: 0,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 43,
                    top: 337,
                    child: Container(
                      width: 288,
                      height: 66,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 2,
                            child: Container(
                              width: 70,
                              height: 58,
                              decoration: ShapeDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'images/about/forStudents.png'),
                                  fit: BoxFit.cover,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 80,
                            top: 0,
                            child: Text(
                              'For Students',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 80,
                            top: 22,
                            child: SizedBox(
                              width: 208,
                              child: Text(
                                'RideWave made by students for students',
                                style: GoogleFonts.poppins(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 43,
                    top: 436,
                    child: Container(
                      width: 288,
                      height: 70,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 79,
                            top: 4,
                            child: Text(
                              'Cost Savings',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 80,
                            top: 26,
                            child: SizedBox(
                              width: 208,
                              child: Text(
                                'Provide you to go to campus with minimum fare',
                                style: GoogleFonts.poppins(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('images/about/costSaving.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 43,
                    top: 539,
                    child: Container(
                      width: 288,
                      height: 70,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 79,
                            top: 4,
                            child: Text(
                              'Connecting People',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                decoration: TextDecoration.none,
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 80,
                            top: 26,
                            child: SizedBox(
                              width: 208,
                              child: Text(
                                "Let's connect with each other, fellow students!",
                                style: GoogleFonts.poppins(
                                  decoration: TextDecoration.none,
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'images/about/connectPeople.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 43,
                    top: 214,
                    child: SizedBox(
                      width: 281,
                      child: Text(
                        'RideWave is a Ride-Sharing application created by third-year students majoring in Information Systems and Technology at ITB.',
                        style: GoogleFonts.poppins(
                          decoration: TextDecoration.none,
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
