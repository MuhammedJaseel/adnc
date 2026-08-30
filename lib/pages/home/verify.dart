import 'dart:io';

import 'package:adnc/services/account.dart';
import 'package:adnc/statics/colors.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final accountService = AccountService();
  bool busy = false;

  String page = "upload";

  CameraController? _controller;
  bool _isInitialized = false;
  XFile? _capturedImage;

  @override
  void initState() {
    super.initState();
    _initializeFrontCamera();
  }

  Future<void> _initializeFrontCamera() async {
    final cameras = await availableCameras();

    final frontCamera = cameras.firstWhere(
      (cam) => cam.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _controller = CameraController(
      frontCamera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    await _controller!.initialize();

    if (mounted) {
      setState(() => _isInitialized = true);
    }
  }

  Future<void> _takeSelfie() async {
    if (_controller == null || !_controller!.value.isInitialized) return;

    try {
      final image = await _controller!.takePicture();

      _controller?.dispose();
      _controller = null;
      _isInitialized = false;

      if (mounted) setState(() => _capturedImage = image);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Selfie capture failed: $e')));
    }
  }

  Future<void> _submitSelfie(XFile image) async {
    if (busy) return;
    setState(() => busy = true);
    try {
      if (page == "upload") {
        await accountService.uploadSelfie(image);
        if (!mounted) return;
        Fluttertoast.showToast(
          msg: "Photo uploaded successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        _capturedImage = null;
        page = "verify";
        await _initializeFrontCamera();
      } else {
        await accountService.verifySelfie(image);
        if (!mounted) return;
        Fluttertoast.showToast(
          msg: "Verified successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Punching failed: $e')));
    }
    setState(() => busy = false);
  }

  Future<void> _retakeSelfie() async {
    _capturedImage = null;
    await _initializeFrontCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (_capturedImage != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Upload Selfie', style: TextStyle(color: Colors.white)),
          backgroundColor: primaryColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
        backgroundColor: bgColor,
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.file(
                      File(_capturedImage!.path),
                      width: double.infinity,
                      height: size.height * 0.58,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      if (busy) Expanded(child: Text('loading...')),
                      if (!busy) ...[
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: _retakeSelfie,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Retake'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _submitSelfie(_capturedImage!),
                            icon: const Icon(Icons.check),
                            label: const Text('Use Photo'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (!_isInitialized || _controller == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          page == "upload" ? 'Upload Selfie' : 'Verify Photo',
          style: TextStyle(color: Colors.white),
        ),
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
                  page == "upload" ? "Take a selfie" : "Verify selfie",
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

          Positioned(
            top: 120,
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              child: CameraPreview(_controller!),
            ),
          ),

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
