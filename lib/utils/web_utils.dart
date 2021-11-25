import 'package:file_selector/file_selector.dart';
import 'package:simple_logger/simple_logger.dart';

final logger = SimpleLogger();

class WebUtils {
  static String localDirPath = "";

  static Future<String> getLocalDirectoryPath() async {

    final typeGroup =
        XTypeGroup(label: 'images', extensions: ['jpg', 'png', 'txt']);
    final file = await openFile(acceptedTypeGroups: [typeGroup]);
    if (file != null) {
      String? directoryPath = file.path;
      if (directoryPath != null) {
        // Operation was canceled by the user.
        localDirPath = directoryPath;
        return directoryPath;
      } else {
        localDirPath = "Not Supported";
        return "";
      }
    }
    return "";
  }

  static Future<String> getSavePath() async {
    final String? path = await getSavePath();
    if (path == null) {
      // Operation was canceled by the user.
      return"";
    } else {
      return path;
    }
  }
}
