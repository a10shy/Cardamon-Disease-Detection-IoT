import 'package:flutter/material.dart';

Image logoWidget(String imageName) {
  return Image.asset(
    imageName,
    fit: BoxFit.fitWidth,
    width: 240,
    height: 240,
    color: Colors.white,
  );
}

TextField reusableTextField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: const Color.fromARGB(255, 0, 0, 0),
    style:
        TextStyle(color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(icon),
      hintText: text,
      hintStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container firebaseUIButton(BuildContext context, String title, Function onTap) {
  return Container(
    height: MediaQuery.of(context).size.height / 15,
    width: MediaQuery.of(context).size.width / 2,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      child: const Text("Reset Password"),
      // Container(
      // height: 100,
      // width: 500,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(5),
      //   color: Colors.blue,
      // ),
      // alignment: Alignment.center,
      // child: const Text(
      //   "Create Account",
      //   style: TextStyle(
      //     color: Colors.white,
      //     fontSize: 18,
      //     fontWeight: FontWeight.bold,
      //   ),
      // )),
      //  Text(
      //   title,
      //   style: const TextStyle(
      //       color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      // ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
    ),
  );
}
