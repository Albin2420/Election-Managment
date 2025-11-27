// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class LoginPage extends StatelessWidget {
//   LoginPage({super.key});
//
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: const Color(0xFFFfffff),
//
//       body: SingleChildScrollView(
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
//             child: Container(
//               width: screenWidth < 500 ? double.infinity : 420,
//               padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 35),
//
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.18),
//                     blurRadius: 20,
//                     offset: const Offset(0, 8),
//                   ),
//                 ],
//               ),
//
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // LOGO
//                   Container(
//                     child: Image.asset(
//                       "assets/images/tick_mark.png",
//                       height: 80,
//                       width: 80,
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   Text(
//                     "Election Management System",
//                     textAlign: TextAlign.center,
//                     style: GoogleFonts.inter(
//                       fontSize: screenWidth < 400 ? 16 : 18,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Text(
//                     "Booth Officer Login",
//                     style: GoogleFonts.inter(
//                       fontSize: screenWidth < 400 ? 16 : 17,
//                       color: Colors.black54,
//                       fontWeight: FontWeight.w600
//                     ),
//                   ),
//
//                   const SizedBox(height: 35),
//
//                   // USERNAME
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "Username",
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//
//                   TextField(
//                     controller: usernameController,
//                     decoration: InputDecoration(
//                       hintText: "Enter username",
//                       hintStyle: TextStyle(
//                         color: Colors.grey[600], // Light grey hint
//                         fontSize: 16,
//                       ),
//                       prefixIcon: const Icon(
//                         Icons.person_outline,
//                         color: Colors.grey, // Icon color
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey[600]!, // Light grey border
//                           width: 1,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey[300]!,
//                           width: 1,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: const BorderSide(
//                           color: Color(0xFF2F5DFE), // Blue color on focus
//                           width: 2,
//                         ),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 12,
//                         horizontal: 16,
//                       ),
//                     ),
//                   ),
//
//
//                   const SizedBox(height: 20),
//
//                   // PASSWORD
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "Password",
//                       style: GoogleFonts.poppins(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//
//                   TextField(
//                     controller: passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       hintText: "Enter password",
//                       hintStyle: TextStyle(
//                         color: Colors.grey[600], // Light grey hint
//                         fontSize: 16,
//                       ),
//                       prefixIcon: const Icon(
//                         Icons.lock_outline,
//                         color: Colors.grey, // Icon color
//                       ),
//                       filled: true,
//                       fillColor: Colors.white,
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey[600]!, // Light grey border
//                           width: 1,
//                         ),
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: BorderSide(
//                           color: Colors.grey[300]!,
//                           width: 1,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                         borderSide: const BorderSide(
//                           color: Color(0xFF2F5DFE), // Blue color on focus
//                           width: 2,
//                         ),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         vertical: 12,
//                         horizontal: 16,
//                       ),
//                     ),
//                   ),
//
//
//                   const SizedBox(height: 30),
//
//                   // LOGIN BUTTON
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         final username = usernameController.text.trim();
//                         final password = passwordController.text.trim();
//
//                         if (username.isEmpty || password.isEmpty) {
//                           Get.snackbar(
//                             "Error",
//                             "Please enter username and password",
//                             snackPosition: SnackPosition.BOTTOM,
//                             backgroundColor: Colors.red,
//                             colorText: Colors.white,
//                             duration: const Duration(seconds: 2),
//                           );
//                         } else {
//                           Get.snackbar(
//                             "Login Successful",
//                             "Welcome $username",
//                             snackPosition: SnackPosition.BOTTOM,
//                             backgroundColor: const Color(0xFF2F5DFE),
//                             colorText: Colors.white,
//                             duration: const Duration(seconds: 2),
//                           );
//                         }
//                       },
//
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFF2F5DFE),
//                         padding: const EdgeInsets.symmetric(vertical: 16),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//
//                       child: Text(
//                         "Login to Booth",
//                         style: GoogleFonts.inter(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   const SizedBox(height: 20),
//
//                   Text(
//                     "For demo purposes, use any username and password",
//                     style: GoogleFonts.poppins(
//                       fontSize: 13,
//                       color: Colors.grey[800],
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controller/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // GetX controller
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
            child: Container(
              width: screenWidth < 500 ? double.infinity : 420,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 35),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.18),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Image.asset(
                    "assets/images/tick_mark.png",
                    height: 80,
                    width: 80,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 20),

                  // Title
                  Text(
                    "Election Management System",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: screenWidth < 400 ? 16 : 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Booth Officer Login",
                    style: GoogleFonts.inter(
                      fontSize: screenWidth < 400 ? 16 : 17,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 35),

                  // Username
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Username",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.usernameController,
                    decoration: InputDecoration(
                      hintText: "Enter username",
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                      prefixIcon: const Icon(
                        Icons.person_outline,
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF2F5DFE),
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter password",
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 16,
                      ),
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xFF2F5DFE),
                          width: 2,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2F5DFE),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Login to Booth",
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "For demo purposes, use any username and password",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
