import 'package:share_plus/share_plus.dart';

class AppShare {

  static void shareApp() {
    Share.share(
      "Check out this awesome app!\n"
          "https://play.google.com/store/apps/details?id=com.lwm.jeebjab",
      subject: "Download this app",
    );
  }

}