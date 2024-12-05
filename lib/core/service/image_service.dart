// import 'dart:async';
// import 'dart:ui' as ui;

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';
// // import 'package:share_plus/share_plus.dart';
// import 'package:sportRex/core/util/appUtil/platform_info.dart';

// ///Handle image require action
// class ImageService {
  
//   Future<void> save(State state, RenderRepaintBoundary boundary,
//       {required String name}) async {
//     Uint8List? pngBytes = await _getPngFromBoundary(boundary);
//     final mounted = state.mounted;
//     if (pngBytes != null && mounted) {
//       if (PlatformInfo.isMobile) {
//         await ImageGallerySaver.saveImage(pngBytes, quality: 200, name: name);
//       } else {
//         await Future.delayed(const Duration(milliseconds: 500));
//       }
//       if (state.mounted) {
//         // $toastService.showSuccess("Saved Successfully ");
//       }
//     }
//   }

//   // Future<void> share(BuildContext context, RenderRepaintBoundary boundary,
//   //     {required String name, String imageName = 'sportRex'}) async {
//   //   Uint8List? pngBytes = await _getPngFromBoundary(boundary);
//   //   if (pngBytes != null) {
//   //     final directory = (await getApplicationDocumentsDirectory()).path;
//   //     File imgFile = File('$directory/$name.png');
//   //     await imgFile.writeAsBytes(pngBytes);
//   //     Share.shareXFiles([XFile(imgFile.path)],
//   //         subject: '$imageName image', text: 'Check out this $imageName!');
//   //   }
//   // }
// }

// Future<Uint8List?> _getPngFromBoundary(RenderRepaintBoundary boundary) async {
//   ui.Image uiImage = await boundary.toImage();
//   ByteData? byteData = await uiImage.toByteData(format: ui.ImageByteFormat.png);
//   if (byteData != null) {
//     return byteData.buffer.asUint8List();
//   }
//   return null;
// }
