import 'package:app_ui/app_ui.dart';
import 'package:brapa/data/commons/data_contanst.dart';
import 'package:injectable/injectable.dart';

import '../services/secure_storage_service.dart';

@singleton
class SecurityRepository {
  final SecureStorageService storageService;
  SecurityRepository(this.storageService);

  Future<void> setSecureApp(bool value) async {
    await storageService.set(DataConstant.isAppSecure, value.toString());
  }

  Future<bool> getSecureApp() async {
    var result = await storageService.get(DataConstant.isAppSecure);
    if (result == null) {
      return false;
    }
    return result.parseBool();
  }

  Future<bool> getUseBiometrik() async {
    var result = await storageService.get(DataConstant.isUseBiometrik);
    if (result == null) {
      return false;
    }
    return result.parseBool();
  }

  Future<void> setUseBiometrik(bool value) async {
    await storageService.set(DataConstant.isUseBiometrik, value.toString());
  }

  Future<void> setPIN(String value) async {
    await storageService.set(DataConstant.pinAppSecure, value);
  }

  Future<String> getPIN() async {
    var result = await storageService.get(DataConstant.pinAppSecure);

    return result!;
  }

  Future<bool> pinHaveBeenSet() async {
    var result = await storageService.get(DataConstant.pinAppSecure);
    if (result == null) {
      return false;
    }
    return true;
  }
}
