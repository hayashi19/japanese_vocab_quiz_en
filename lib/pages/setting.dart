import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:get/get.dart';
import 'package:japanese_vocab_quiz_en/controller/controller.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.put(AllPageController());
    return Container(
      margin: const EdgeInsets.all(8),
      child: ListView(
        children: const <Widget>[
          SettingRateApp(),
          SizedBox(height: 8),
          // SettingAd1(),
          SizedBox(height: 8),
          SettingExtraContent(),
          SizedBox(height: 8),
          // SettingAd2(),
          Divider(
            color: Colors.blueGrey,
            height: 36,
            thickness: 4,
          ),
          // SettingWebsiteVersion(),
          SizedBox(height: 8),
          SettingEmail(),
          SizedBox(height: 8),
          SettingDownloadFileButton(),
          SizedBox(height: 8),
          SettingThemeButton(),
        ],
      ),
    );
  }
}

class SettingRateApp extends StatelessWidget {
  const SettingRateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return ElevatedButton(
      // ignore: deprecated_member_use
      onPressed: () => launch(allPageController.rateLink.value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/logo.png',
                  height: 55,
                  width: 55,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    "Japanese Vocan Quiz",
                    softWrap: true,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Rate ★★★★★",
              style: TextStyle(
                color: Colors.yellowAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingExtraContent extends StatelessWidget {
  const SettingExtraContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Column(
      children: <Widget>[
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: ExpandablePanel(
              header: Row(
                children: const <Widget>[
                  Icon(Icons.ad_units),
                  Spacer(),
                  Text(
                    "About App",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              collapsed: Obx(
                () => Text(
                  allPageController.aboutApp.string,
                  softWrap: true,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              expanded: Obx(
                () => Text(
                  allPageController.aboutApp.string,
                  softWrap: true,
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ),
        Card(
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: ExpandablePanel(
              header: Row(
                children: const <Widget>[
                  Icon(Icons.ballot_rounded),
                  Spacer(),
                  Text(
                    "App Help",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              collapsed: const Text(
                "Application help, tips and tricks to use it.",
                softWrap: true,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              expanded: Column(
                children: <Widget>[
                  TextButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutAppHelp(),
                      ),
                    ),
                    icon: const Icon(Icons.ballot_outlined),
                    label: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Usage help"),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutAppTrick(),
                      ),
                    ),
                    icon: const Icon(Icons.ballot_outlined),
                    label: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Usage Tips"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

class SettingWebsiteVersion extends StatelessWidget {
  const SettingWebsiteVersion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return ElevatedButton.icon(
      // ignore: deprecated_member_use
      onPressed: () => launch(allPageController.websiteVersion.string),
      icon: const Icon(Icons.web),
      label: const Padding(
        padding: EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Website Version Quiz",
          ),
        ),
      ),
    );
  }
}

class SettingEmail extends StatelessWidget {
  const SettingEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async => await FlutterEmailSender.send(Email(
        subject: 'Error Reports And Suggestions Apk Japanese Vocabulary Quiz',
        recipients: ['tryniti0412@gmail.com'],
        isHTML: false,
      )),
      icon: const Icon(Icons.email_rounded),
      label: const Padding(
        padding: EdgeInsets.all(16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Email Report",
          ),
        ),
      ),
    );
  }
}

class AboutAppHelp extends StatelessWidget {
  const AboutAppHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Application Help"),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // Image.asset('assets/logo.png'),
          Image.asset('assets/help/Quiz1.png'),
          const SizedBox(width: 8),
          Image.asset('assets/help/Quiz2.png'),
          const SizedBox(width: 8),
          Image.asset('assets/help/Quiz3.png'),
          const SizedBox(width: 8),
          Image.asset('assets/help/Quiz4.png'),
          const SizedBox(width: 8),
          Image.asset('assets/help/Dictionary 1.png'),
          const SizedBox(width: 8),
          Image.asset('assets/help/Dictionary 2.png'),
          const SizedBox(width: 8),
          Image.asset('assets/help/Setting.png'),
        ],
      ),
    );
  }
}

class AboutAppTrick extends StatelessWidget {
  const AboutAppTrick({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Application Help"),
      ),
      body: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          // Image.asset('assets/logo.png'),
          Image.asset('assets/tips/Tips 3.png'),
          const SizedBox(width: 8),
          Image.asset('assets/tips/Tips 4.png'),
        ],
      ),
    );
  }
}

class SettingAd1 extends StatelessWidget {
  const SettingAd1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Container(
      height: 65,
      color: Colors.blueGrey[300],
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Obx(
        () => NativeAdmob(
          error: const Center(child: Text("Ads not available")),
          adUnitID: allPageController.settingBanner1.value,
          controller: allPageController.settingAdsController,
          type: NativeAdmobType.banner,
          options: const NativeAdmobOptions(
            headlineTextStyle: NativeTextStyle(
              fontSize: 6,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class SettingAd2 extends StatelessWidget {
  const SettingAd2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Container(
      height: 65,
      color: Colors.blueGrey[300],
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Obx(
        () => NativeAdmob(
          error: const Center(child: Text("Ads not available")),
          adUnitID: allPageController.settingBanner2.value,
          controller: allPageController.settingAdsController,
          type: NativeAdmobType.banner,
          options: const NativeAdmobOptions(
            headlineTextStyle: NativeTextStyle(
              fontSize: 6,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class SettingThemeButton extends StatelessWidget {
  const SettingThemeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Obx(
      () => ElevatedButton.icon(
        icon: allPageController.themeButtonIcon,
        style: ElevatedButton.styleFrom(
            primary: allPageController.themeButtonColor.value,
            onPrimary: allPageController.themeButtonTextColor.value,
            shadowColor: Colors.transparent),
        label: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(allPageController.themeButtonText.value),
          ),
        ),
        onPressed: () {
          ThemeService().switchTheme();
          allPageController.changeButtonTheme();
        },
      ),
    );
  }
}

class SettingDownloadFileButton extends StatelessWidget {
  const SettingDownloadFileButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.find();
    return ElevatedButton.icon(
      icon: const Icon(Icons.upgrade),
      label: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text("Update Vocabulary"),
        ),
      ),
      onPressed: () => allPageController.downloadAndUpdateWord(),
    );
  }
}
