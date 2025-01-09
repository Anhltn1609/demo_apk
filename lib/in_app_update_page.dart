import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:install_plugin/install_plugin.dart';
import 'package:path_provider/path_provider.dart';

class InAppUpdatePage extends StatefulWidget {
  const InAppUpdatePage({super.key});

  @override
  State<InAppUpdatePage> createState() => _InAppUpdatePageState();
}

class _InAppUpdatePageState extends State<InAppUpdatePage> {
  bool _isDownloading = false;
  double _downloadProgress = 0.0;
  final String _apkUrl =
      'https://github.com/Anhltn1609/demo_apk/raw/refs/heads/main/otapackage/build/app/outputs/flutter-apk/app-release.apk'; // Link file APK

  Future<void> _downloadAndInstallApk() async {
    final dio = Dio();
    try {
      String fileName = 'app-latest.apk';
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      // _saveFile(filePath);
      setState(() {
        _isDownloading = true;
      });
      await dio.download(
        _apkUrl,
        filePath,
        onReceiveProgress: (received, total) {
          setState(() {
            _downloadProgress = received / total;
          });
        },
      );

      // after downloaded
      setState(() {
        _isDownloading = false;
      });
      // install apk file
      await InstallPlugin.installApk(
        filePath,
      );
    } catch (e) {
      setState(() {
        _isDownloading = false;
      });
      debugPrint("Error : download unsuccessful : $e ");
    }
  }

  Future<void> _saveFile(String filePath) async {
    final dio = Dio();
    try {
      setState(() {
        _isDownloading = true;
      });
      await dio.download(
        _apkUrl,
        filePath,
        onReceiveProgress: (received, total) {
          setState(() {
            _downloadProgress = received / total;
          });
        },
      );

      // after downloaded
      setState(() {
        _isDownloading = false;
      });
    } catch (e) {
      debugPrint('Error saving image: $e');
      throw Exception('Failed to save image to internal storage.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _isDownloading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    value: _downloadProgress,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                      'Downloading ... ${(_downloadProgress * 100).toStringAsFixed(2)} %'),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('version 3'),
                  ElevatedButton(
                      onPressed: _downloadAndInstallApk,
                      child: Text('Download & Install Update')),
                ],
              ),
      ),
    );
  }
}
