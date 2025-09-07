import '../../core/app/app_flavor.dart';

class ApiUrls {
  static String baseUrl = getServerUrl();

  static const String liveUrl =
      'https://api.github.com/'; //live server
  static const String devUrl =
      'https://api.github.com/'; // dev server
  static const String testUrl =
      'https://api.github.com/'; // test server

  static String getServerUrl() {
    if (AppFlavor.getFlavor == FlavorStatus.production) {
      return liveUrl;
    } else if (AppFlavor.getFlavor == FlavorStatus.development) {
      return devUrl;
    } else if (AppFlavor.getFlavor == FlavorStatus.staging) {
      return testUrl;
    } else {
      return liveUrl;
    }
  }

  // shop module
  static const String repoUrl = 'search/repositories';
}
