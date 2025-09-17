import 'package:get_storage/get_storage.dart';

class StorageService {
    static const dbBox = 'db';
    static const authBox = 'auth';

    static Future<void> init() async {
    await GetStorage.init(dbBox);
    await GetStorage.init(authBox);
    }

    static GetStorage db() => GetStorage(dbBox);
    static GetStorage auth() => GetStorage(authBox);
}
