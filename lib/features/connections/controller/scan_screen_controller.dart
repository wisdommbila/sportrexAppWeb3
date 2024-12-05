import 'dart:developer';

import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sportRex/features/connections/view/connect_wallet_screen.dart';

import '../../../core/config/dependecies.dart';
import '../../../core/service/base_change_notifier.dart';

class ScanScreenController extends BaseChangeNotifier {
  ScanScreenController(this._read) {
    // navigateToConnectWallet();
  }


  // ignore: unused_field
  final Ref _read;
  ScanResult? scanResult;

  final _flashOnController = TextEditingController(text: 'Flash on');
  final _flashOffController = TextEditingController(text: 'Flash off');
  final _cancelController = TextEditingController(text: 'Cancel');

  final _aspectTolerance = 0.00;
  // ignore: unused_field
  final _numberOfCameras = 0;
  final _selectedCamera = -1;
  final _useAutoFocus = true;
  final _autoEnableFlash = false;

  static final _possibleFormats = BarcodeFormat.values.toList()
    ..removeWhere((e) => e == BarcodeFormat.unknown);

  List<BarcodeFormat> selectedFormats = [..._possibleFormats];

  void navigateToConnectWallet() async {
    $navigate.to(ConnectWalletScreen.routeName);
  }

  Future<void> scan() async {
    try {
      log("Starting  Scan");

      final result = await BarcodeScanner.scan(
        options: ScanOptions(
          strings: {
            'cancel': _cancelController.text,
            'flash_on': _flashOnController.text,
            'flash_off': _flashOffController.text,
          },
          restrictFormat: selectedFormats,
          useCamera: _selectedCamera,
          autoEnableFlash: _autoEnableFlash,
          android: AndroidOptions(
            aspectTolerance: _aspectTolerance,
            useAutoFocus: _useAutoFocus,
          ),
        ),
      );

      scanResult = result;
      log(" format note: ${result.formatNote}");
      log(" raw content: ${result.rawContent}");
      log("format : ${result.format}");
      log("type: ${result.type}");
      if (scanResult != null || scanResult!.rawContent.isEmpty) {}
    } on PlatformException catch (e) {
      scanResult = ScanResult(
        type: ResultType.Error,
        format: BarcodeFormat.unknown,
        rawContent: e.code == BarcodeScanner.cameraAccessDenied
            ? 'The user did not grant the camera permission!'
            : 'Unknown error: $e',
      );
    }
  }
}

final scanScreenProvider = ChangeNotifierProvider.autoDispose(
  (ref) => ScanScreenController(ref),
);
