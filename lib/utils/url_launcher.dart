import 'package:flutter_web_browser/flutter_web_browser.dart';

class UrlLauncher {
  static launhcUrl(String url) {
    FlutterWebBrowser.openWebPage(
        url: url,
        customTabsOptions: CustomTabsOptions(
            colorScheme: CustomTabsColorScheme.light,
            instantAppsEnabled: true,
            showTitle: true));
  }
}
