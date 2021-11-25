import "dart:io";
import "package:path_provider/path_provider.dart";


class NonWebUtils {


  static Future<String> getLocalDirectoryPath() async {
    final Directory? localDirectory = await getApplicationDocumentsDirectory();
    if (localDirectory != null) {
      return localDirectory.path;
    } else {
      return "";
    }
  }

}