import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    HomePageController homePageController = Get.put(HomePageController());
    return Scaffold(
      body: PageView(
        onPageChanged: (index) => homePageController.changeIndex(index),
        controller: homePageController.pageViewController,
        children: const <Widget>[
          QuizPage(),
          DictionaryPage(),
          KanaPage(),
          SettingPage(),
        ],
      ),

      // Bot nav bar contain icon of pages
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: homePageController.currentIndex.value,
          onTap: (index) => homePageController.pageViewController.animateToPage(
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
