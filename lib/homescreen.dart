import 'package:cardamon/login/LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:cinch/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_dialogs/material_dialogs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final name = FirebaseAuth.instance.currentUser!.displayName;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: isLoading
            ? Center(
                child: SizedBox(
                  height: size.height / 20,
                  width: size.height / 20,
                  child: const CircularProgressIndicator(),
                ),
              )
            : SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    SizedBox(height: size.height / 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Hello ",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                        Text(name!,
                            style: const TextStyle(
                                fontSize: 34,
                                fontWeight: FontWeight.w600,
                                color: Colors.black)),
                        const Text(
                          "! ",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height / 100,
                    ),
                    SizedBox(
                      height: size.height / 50,
                    ),
                    SizedBox(
                      height: size.height / 100,
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: size.height / 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            StreamBuilder<QuerySnapshot>(
                              stream: _firestore
                                  .collection('Field1')
                                  .doc("Disease1")
                                  .collection('Occurances')
                                  .orderBy('timestamp')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  Map<String, dynamic> userMap =
                                      snapshot.data!.docs[0].data()
                                          as Map<String, dynamic>;
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  // mainAxisAlignment: MainAxisAlignment.center,
                                                  // crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Accuracy ",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.grey),
                                                    ),
                                                    const Text(
                                                      ": ",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(userMap['Accuracy'],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15)),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      "Location ",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.grey),
                                                    ),
                                                    const Text(
                                                      ": ",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(userMap['Location'],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15)),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      "Disease ",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.grey),
                                                    ),
                                                    const Text(
                                                      ": ",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(userMap['Disease'],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15)),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    const Text(
                                                      "Detected At",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.grey),
                                                    ),
                                                    const Text(
                                                      ": ",
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.grey),
                                                    ),
                                                    Text(userMap['Time'],
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15)),
                                                    const Text("\t-\t",
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15)),
                                                    Text(userMap['Date'],
                                                        textAlign:
                                                            TextAlign.end,
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 15)),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          // color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: IconButton(
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Dialogs.materialDialog(
                              color: Colors.white,
                              titleStyle: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15.w,
                              )),
                              msgStyle: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.w,
                              ),
                              msg: 'You will be Logged Out',
                              title: 'Are You Sure?',
                              context: context,
                              actions: [
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      minimumSize: Size(70.w, 52.w),
                                      primary: Colors.blue,
                                    ),
                                    onPressed: () {
                                      logOut(context);
                                    },
                                    child: const Text(
                                      "Log Out",
                                    )),
                              ],
                            );
                          }),
                    )
                  ])));
  }

  Future logOut(BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    try {
      await _auth.signOut().then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => LoginScreen()));
      });
    } catch (e) {
      print("error");
    }
  }
}
