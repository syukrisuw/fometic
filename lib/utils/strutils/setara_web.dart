//Uncomment for Web Build Only
// import 'dart:html';

class StrWebUtil {

  String getOSInsideWeb() {
    //Uncomment for Web Build Only
/*    final userAgent = window.navigator.userAgent.toString().toLowerCase();
    if (userAgent.contains("iphone")) return "ios";
    if (userAgent.contains("ipad")) return "ios";
    if (userAgent.contains("android")) return "Android";
    if (userAgent.contains("windows")) return "Windows";
    return "WebView";
 */
    return "Windows";//userAgent;
  }
}