import 'package:brapa/data/commons/data_contanst.dart';
import 'package:brapa/data/services/secure_storage_service.dart';
import 'package:injectable/injectable.dart';

@injectable
class LanguageRepository {
  final SecureStorageService storageService;
  LanguageRepository(this.storageService);

  Future<void> setLocale(String locale) async {
    await storageService.set(DataConstant.localeCode, locale);
  }

  Future<String?> getLocale() async {
    var result = await storageService.get(DataConstant.localeCode);
    if (result == null) {
      await setLocale("en");
      result = await storageService.get(DataConstant.localeCode);
    }
    return result;
  }
}
