import 'package:adnc/pages/home/punch_success.dart';
import 'package:adnc/services/attendance.dart';
import 'package:adnc/statics/colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class PunchInPage extends StatefulWidget {
  const PunchInPage({super.key});

  @override
  State<PunchInPage> createState() => _PunchInPageState();
}

class _PunchInPageState extends State<PunchInPage> {
  final _attendanceService = AttendanceService();
  // CameraController? _controller;
  // bool _isInitialized = false;

  // @override
  // void initState() {
  //   super.initState();
  //   _initializeFrontCamera();
  // }

  // Future<void> _initializeFrontCamera() async {
  //   // 1. Fetch available device cameras
  //   final cameras = await availableCameras();

  //   // 2. Locate the front-facing camera for selfies
  //   final frontCamera = cameras.firstWhere(
  //     (cam) => cam.lensDirection == CameraLensDirection.front,
  //     orElse: () => cameras.first,
  //   );

  //   // 3. Initialize controller
  //   _controller = CameraController(
  //     frontCamera,
  //     ResolutionPreset.high,
  //     enableAudio: false,
  //   );

  //   await _controller!.initialize();

  //   if (mounted) {
  //     setState(() => _isInitialized = true);
  //   }
  // }

  void _takeSelfie() async {
    // Future<void> _takeSelfie() async {
    //   if (_controller == null || !_controller!.value.isInitialized) return;

    //   try {
    //     // Capture image file
    //     final XFile image = await _controller!.takePicture();

    //     if (mounted) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('Selfie captured: ${image.path}')),
    //       );
    //     }
    //   } catch (e) {
    //     print('Error taking selfie: $e');
    //   }
    try {
      // TODO: need to fech all the details while login in
      await _attendanceService.markPunchIn();

      if (!mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => const PunchSuccessPage(
            location: '10.9965, 76.2213',
            battery: '82%',
            internet: 'WI-Fi',
            device: 'Samsung Galaxy S24',
            type: 'Punch In',
            punchTime: '09:15 AM',
            punchDate: '27 June 2026',
            punchDay: 'Monday',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Punch in failed: $e')));
    }
  }

  // @override
  // void dispose() {
  //   _controller?.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // if (!_isInitialized || _controller == null) {
    //   return const Scaffold(body: Center(child: CircularProgressIndicator()));
    // }

    return Scaffold(
      appBar: AppBar(
        title: Text("Punch IN", style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: bgColor,
      body: Stack(
        children: [
          Positioned(
            top: size.height * .04,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  "Take a selfie",
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight(700),
                    fontSize: 18,
                  ),
                ),
                Text(
                  "Make sure your face is clearly visible",
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontWeight: FontWeight(600),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

          // Camera Preview
          // CameraPreview(_controller!),

          // Capture Button
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: () => _takeSelfie(),
                child: const Icon(Icons.camera_alt),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
