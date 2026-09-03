import 'package:adnc/services/account.dart';
import 'package:adnc/services/auth.dart';
import 'package:adnc/services/http.dart';
import 'package:adnc/statics/colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _authService = AuthService();
  final _accountService = AccountService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();

  String otpToken = "";
  bool busy = false;

  Future<void> saveToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
  }

  void onSubmitOtp() async {
    if (busy) return;
    String otp = otpController.text;

    if (!mounted) return;
    setState(() => busy = true);

    await _authService.verifyOtp(otpToken, otp).then((res) async {
      HttpsService.accessToken = res['accessToken'];
      saveToken(res['accessToken']);
      await _accountService.getProfile();
      Navigator.pushNamedAndRemoveUntil(context, '/home', ((route) => false));
    });
    setState(() => busy = false);
  }

  // TODO: Need to set up login with google
  // TODO: Need to handle multiple tenants

  void onLogin() async {
    if (busy) return;
    setState(() => busy = true);
    String email = emailController.text;
    try {
      dynamic res = await _authService.verifyEmail(email);
      if (!mounted) throw ();
      otpToken = res['otpToken'];
      otpController.text = '';

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          // title: const Text('Enter otp'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          backgroundColor: Colors.white,
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enter Otp',
                  style: TextStyle(
                    fontWeight: FontWeight(700),
                    fontSize: 20,
                    color: textColor,
                  ),
                ),
                Text(
                  'Enter the otp received on your mail',
                  style: TextStyle(color: secondaryTextColor),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  margin: const EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                  ),
                  alignment: Alignment.center,
                  child: TextField(
                    controller: otpController,
                    textAlign: TextAlign.center,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: '000000',
                      hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                    ),
                  ),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Close popup
              child: const Text('Cancel'),
            ),
            GestureDetector(
              onTap: onSubmitOtp,
              child: Container(
                height: 44,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(8),
                  color: busy
                      ? const Color(0xFF94A3B8)
                      : const Color(0xff0066FF),
                ),
                alignment: Alignment.center,
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } finally {
      setState(() => busy = false);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SizedBox(
        height: double.infinity,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * .15),
              Image.asset(
                'assets/images/logo2.png',
                height: size.height * 0.1,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 40),
              Text(
                "Employee Login",
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Login to make your attendance",
                style: TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                margin: const EdgeInsets.only(top: 16),
                width: size.width * .8,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.person, size: 30),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'example@gmail.com',
                          hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 12),
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              //   margin: const EdgeInsets.only(top: 16),
              //   width: size.width * .8,
              //   decoration: BoxDecoration(
              //     border: Border.all(color: const Color(0xFFE5E7EB)),
              //     borderRadius: BorderRadius.circular(8),
              //     color: Colors.white,
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: [
              //       const Icon(Icons.lock, size: 30),
              //       const SizedBox(width: 12),
              //       Expanded(
              //         child: TextField(
              //           decoration: const InputDecoration(
              //             border: InputBorder.none,
              //             hintText: 'Password',
              //             hintStyle: TextStyle(color: Color(0xFF9CA3AF)),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              const SizedBox(height: 26),
              SizedBox(
                width: size.width * .8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 22,
                          height: 22,
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                            borderRadius: BorderRadius.circular(2),
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Remember Me",
                          style: TextStyle(
                            color: Color(0xFF6B7280),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "Forget PIN?",
                      style: TextStyle(
                        color: Color(0xFF0066FF),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: onLogin,
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: size.width * .8,
                  height: 54,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    borderRadius: BorderRadius.circular(8),
                    color: busy
                        ? const Color(0xFF94A3B8)
                        : const Color(0xff0066FF),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x400066FF),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "LOGIN",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * .05),
              SizedBox(
                width: size.width * .8,
                child: Row(
                  children: [
                    Expanded(child: Container(height: 1, color: borderColor)),
                    SizedBox(width: 10),
                    Text(
                      "OR",
                      style: TextStyle(
                        color: Color(0xFF94A3B8),
                        fontWeight: FontWeight(600),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(child: Container(height: 1, color: borderColor)),
                  ],
                ),
              ),
              SizedBox(height: size.height * .03),
              GestureDetector(
                onTap: () => {},
                child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: size.width * .8,
                  height: 54,
                  decoration: BoxDecoration(
                    border: Border.all(color: borderColor),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.g_mobiledata,
                        color: Color(0xFF475569),
                        size: 24,
                      ),
                      Text(
                        "Continue With Google",
                        style: TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height * .05),
            ],
          ),
        ),
      ),
    );
  }
}
