import 'dart:async';
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sportRex/core/data/local_data_source.dart';
import 'package:sportRex/core/util/appUtil/app_strings.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';

import '../commonLibs/common_libs.dart';

class LocalStorageServiceImpls implements LocalStorageService {
  // const LocalStorageServiceImpls{
  //   init();
  // }
  // ignore: prefer_typing_uninitialized_variables

  /// Instance of flutter secure storage
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  Box<dynamic>? _prefs;

  @override
  Future initDb() async {
    debugPrint("init Db");

    await Hive.initFlutter();

    await Hive.openBox(dotenv.get('STORAGE_KEY'));

    _prefs = Hive.box(dotenv.get('STORAGE_KEY'));
  }

  @override
  clearAllData() async {
    await _prefs!.clear();
  }

  @override
  dynamic create(String key, String data) async {
    if (read(key) != null) {
      await _prefs!.delete(key);
    }
    await putData(key, data);
    return data;
  }

  @override
  dynamic createJsonData(String key, dynamic data) async {
    if (read(key) != null) {
      await _prefs!.delete(key);
    }
    await putData(key, jsonEncode(data));
    return data;
  }

  @override
  Future<void> delete(String key) async {
    if (read(key) != null) {
      await _prefs!.delete(key);
    }
  }

  @override
  dynamic putData(String key, String data) async {
    await _prefs!.put(key, data);
  }

  @override
  dynamic read(String key) {
    return _prefs!.get(key);
  }

  @override
  dynamic readJsonData(String key) async {
    return _prefs!.get(key) != null ? await decodeJson(_prefs!.get(key)) : null;
  }

  @override
  dynamic getDynamicData(String key, bool isJson) {
    return isJson
        ? ((readJsonData(key) != null) ? readJsonData(key) : null)
        : ((read(key) != null) ? read(key) : null);
  }

  @override
  retrieveEncyptedData(String key) async {
    final response = await _getEncrypted(key);
    print("retrive response $response");
    if (response == null) {
      return null;
    }
    final token = response.toString();

    debugPrint(' Encypted Data fetched successfully$token');

    return token;
  }

  // @override
  @override
  saveEncyptedData(String key, dynamic val) async {
    debugPrint('saveEncyptedData ==> $val');
    unawaited(
      _setEncrypted(key, val),
    );
  }

  /// Sets the encrypted value for the key to encrypted box
  Future<void> _setEncrypted(String key, dynamic value) async {
    try {
      List<int> encryptionKey;

      //attempt to fetch secret i.e check if it exists
      final secretKey = await _secureStorage.read(
        key: AppString.appSecret,
      );

      if (secretKey == null) {
        //no secretKey, generate one
        encryptionKey = Hive.generateSecureKey();

        //save secret
        await _secureStorage.write(
          key: AppString.appSecret,
          value: base64UrlEncode(encryptionKey),
        );
      } else {
        encryptionKey = base64Url.decode(secretKey);
      }


      //open box
      final encryptedBox = await Hive.openBox<String>(
        AppString.appEncryptedBox,
        encryptionCipher: HiveAesCipher(
          encryptionKey,
        ),
      );
      debugPrint('EncyptedData ==> $value');

      //set value
      await encryptedBox.put(key, value);
      return;
    } on PlatformException catch (ex) {
      debugPrint('$ex');
    }
  }

  // /// Reads the decrypted value for the key from encrypted box
  Future<String?> _getEncrypted(String key) async {
    try {
      //fetch secrete key

      final secretKey = await _secureStorage.read(
        key: AppString.appSecret,
      );

      if (secretKey == null) {
        //if secret key is null, there's no secret saved
        return null;
      }

      final encryptionKey = base64Url.decode(secretKey);

      final encryptedBox = await Hive.openBox<String>(
        AppString.appEncryptedBox,
        encryptionCipher: HiveAesCipher(
          encryptionKey,
        ),
      );

      final value = encryptedBox.get(key);

      return value;
    } on PlatformException catch (ex) {
      debugPrint('$ex');
      return Future<String?>.value();
    }
  }
}
