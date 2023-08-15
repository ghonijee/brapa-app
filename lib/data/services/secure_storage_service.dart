import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class SecureStorageService {
  final FlutterSecureStorage storage;

  SecureStorageService(this.storage);
  Future<void> set(String key, String value) async {
    await storage.write(key: key, value: value);
  }

  Future<String?> get(String key) async {
    var result = await storage.read(key: key);
    return result;
  }

  Future<void> clear(String key) async {
    await storage.delete(key: key);
  }
}
