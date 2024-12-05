import 'package:sportRex/core/service/local_storage_service.dart';

abstract class LocalStorageService {
  factory LocalStorageService() => LocalStorageServiceImpls();

  Future initDb();

  dynamic create(String key, String data);

  dynamic read(String key);

  Future<void> delete(String key);

  dynamic createJsonData(String key, dynamic data);

  dynamic readJsonData(String key);

  dynamic putData(String key, String data);

  dynamic getDynamicData(String key, bool isJson);

  clearAllData();

  dynamic saveEncyptedData(String key, dynamic value);
  dynamic retrieveEncyptedData(String key);
}
