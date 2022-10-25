import 'package:cardamon/login/LoginScreen.dart';
import 'package:cardamon/login/Methods.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  _CreateAccountState createState() => _CreateAccountState();
}

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  List<Map<String, dynamic>> membersList = [];

  bool isLoading = false;
  // final List<String> nearbyplaces = [
  //   'Kanjirappally',
  //   'Ponkunnam',
  //   'Pampady',
  //   'Mundakkayam',
  //   'Kottayam',
  //   'Changanassery'
  // ];
  String? placeselected;
  final snackBar = const SnackBar(
    content: Text('Please fill all the fields!'),
  );
  final snackBarsuccess = const SnackBar(
    content: Text('Account Created Sucessfully!'),
  );

  getCurrentUserDetails() async {
    membersList = (await _firestore
        .collection('groups')
        .doc("Kanjikuzhy")
        .collection("members")
        .get()) as List<Map<String, dynamic>>;
    await _firestore
        .collection('users')
        .doc(_auth.currentUser!.uid)
        .get()
        .then((map) {
      setState(() {
        membersList.add({
          "name": map['name'],
          "email": map['email'],
          "uid": map['uid'],
          "isAdmin": true,
        });
      });
    });
    await _firestore.collection('groups').doc("placeselected").update({
      "members": membersList,
      "id": "placeselected",
    });
  }

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
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: size.height / 20,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    width: size.width / 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                  ),
                  SizedBox(
                    height: size.height / 70,
                  ),
                  SizedBox(
                    width: size.width / 1.1,
                    child: const Text(
                      "New Account",
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: size.width / 1.1,
                    child: Text(
                      "bla bla",
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "Name", Icons.account_box, _name),
                    ),
                  ),
                  Container(
                    width: size.width,
                    alignment: Alignment.center,
                    child: field(size, "Email", Icons.mail, _email),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
                    child: Container(
                      width: size.width,
                      alignment: Alignment.center,
                      child: field(size, "Password", Icons.lock, _password),
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
                    // child: DropdownButtonFormField2(
                    //   decoration: InputDecoration(
                    //     isDense: true,
                    //     contentPadding: EdgeInsets.zero,
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15),
                    //     ),
                    //    ),
                    //   isExpanded: true,
                    //   hint: const Text(
                    //     'Select Your Nearest Location',
                    //     style: TextStyle(fontSize: 16),
                    //   ),
                    //   icon: const Icon(
                    //     Icons.arrow_drop_down,
                    //     color: Colors.black45,
                    //   ),
                    //   iconSize: 30,
                    //   buttonHeight: size.height / 14,
                    //   buttonWidth: size.width / 1.1,
                    //   buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    //   dropdownDecoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   items: nearbyplaces
                    //       .map((item) => DropdownMenuItem<String>(
                    //             value: item,
                    //             child: Text(
                    //               item,
                    //               style: const TextStyle(
                    //                 fontSize: 14,
                    //               ),
                    //             ),
                    //           ))
                    //       .toList(),
                    //   validator: (value) {
                    //     if (value == null) {
                    //       return 'Please select location.';
                    //     }
                    //     return null;
                    //   },
                    //   onChanged: (newValue) {
                    //     setState(() {
                    //       placeselected = newValue as String?;
                    //     });
                    //   },
                    //   // onSaved: (value) {
                    //   //   placeselected = value.toString();
                    //   // },
                    // ),
                  ),
                  SizedBox(
                    height: size.height / 20,
                  ),
                  customButton(size),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  Widget customButton(Size size) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      onPressed: () {
        if (_name.text.isNotEmpty &&
                _email.text.isNotEmpty &&
                _password.text.isNotEmpty
            // &&
            // placeselected!.isNotEmpty
            ) {
          setState(() {
            isLoading = true;
          });

          createAccount(
            _name.text, _email.text, _password.text,
            // placeselected!
          ).then((user) {
            if (user != null) {
              setState(() {
                isLoading = false;
              });
              getCurrentUserDetails();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => LoginScreen()));
              ScaffoldMessenger.of(context).showSnackBar(snackBarsuccess);
            } else {
              //snackbar
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text('Login Failed')));
              print("Login Failed");
              setState(() {
                isLoading = false;
              });
            }
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      child: Container(
          height: size.height / 15,
          width: size.width / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blue,
          ),
          alignment: Alignment.center,
          child: const Text(
            "Create Account",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          )),
    );
  }

  Widget field(
      Size size, String hintText, IconData icon, TextEditingController cont) {
    return SizedBox(
      height: size.height / 14,
      width: size.width / 1.1,
      child: TextField(
        controller: cont,
        decoration: InputDecoration(
          prefixIcon: Icon(icon),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
