import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

// Import Files
import 'package:japanese_vocab_quiz_en/controller/controller.dart';
import 'package:japanese_vocab_quiz_en/pages/dictionary.dart';
import 'package:japanese_vocab_quiz_en/pages/kana.dart';
import 'package:japanese_vocab_quiz_en/pages/quiz.dart';
import 'package:japanese_vocab_quiz_en/pages/setting.dart';

class HomePages extends StatelessWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      GetPlatform.isMobile ? const MobileHomePage() : const DesktopHomePage();
}

class MobileHomePage extends StatelessWidget {
  const MobileHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.put(AllPageController());
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView(
              onPageChanged: (index) => allPageController.changeIndex(index),
              controller: allPageController.pageViewController,
              children: const <Widget>[
                QuizPage(),
                DictionaryPage(),
                KanaPage(),
                SettingPage(),
              ],
            ),
          ),
          ADS(ad: allPageController.allBanner)
        ],
      ),

      // Bot nav bar contain icon of pages
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: allPageController.currentIndex.value,
          onTap: (index) => allPageController.pageViewController.animateToPage(
            index,
            duration: const Duration(
              milliseconds: 450,
            ),
            curve: Curves.fastLinearToSlowEaseIn,
          ),
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              // Ic kuis
              icon: Icon(Icons.quiz_rounded),
              label: "Quiz",
            ),
            BottomNavigationBarItem(
              // Ic kamus
              icon: Icon(Icons.library_books_rounded),
              label: "Dictionary",
            ),
            BottomNavigationBarItem(
              // Ic kamus
              icon: Icon(Icons.translate),
              label: "Kana",
            ),
            BottomNavigationBarItem(
              // Ic setting
              icon: Icon(Icons.app_settings_alt_rounded),
              label: "Menu",
            ),
          ],
        ),
      ),
    );
  }
}

class DesktopHomePage extends StatelessWidget {
  const DesktopHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Hello, Desktop!"),
      ),
    );
  }
}

// ignore: must_be_immutable
class ADS extends StatelessWidget {
  AdWithView ad;
  ADS({Key? key, required this.ad}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: AdSize.banner.width.toDouble(),
      height: AdSize.banner.height.toDouble(),
      child: AdWidget(ad: ad),
    );
  }
}
