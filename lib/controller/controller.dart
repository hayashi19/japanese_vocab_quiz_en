import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_admob/native_admob_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kana_kit/kana_kit.dart';
import 'package:path_provider/path_provider.dart';

//////////////////////////////////////////////////////////////////////////////////////////////////// THEME
class AppTheme {
  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF002868),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      backgroundColor: Color(0xFF002868),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFF002868),
        onPrimary: Colors.white,
        shadowColor: Colors.blueAccent[400],
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: const Color(0xFF002868),
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF002868),
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[50],
      elevation: 4,
      shadowColor: Colors.black,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white,
    ),
  );

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF002868),
    scaffoldBackgroundColor: Colors.grey[900],
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Colors.blueAccent,
      unselectedItemColor: Colors.grey,
      backgroundColor: Color(0xFF002868), //Color(0xFF55192A),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: const Color(0xFF002868), //const Color(0xFF55192A),
        onPrimary: Colors.white,
        shadowColor: const Color(0xFF002868),
        textStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: const Color(0xFFACE8DD),
      ),
    ),
    appBarTheme: const AppBarTheme(
        color: Color(0xFF002868), //Color(0xFF55192A),
        titleTextStyle: TextStyle(color: Colors.white)),
    cardTheme: CardTheme(
      color: Colors.blueGrey[900],
      elevation: 4,
      shadowColor: Colors.grey[900],
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Color(0xFF1D1E2C),
    ),
  );
}

class ThemeService {
  final _box = GetStorage();
  final _key = 'isDarkMode';

  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  /// Save isDarkMode to local storage
  _saveThemeToBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  /// Switch theme and save to local storage
  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!_loadThemeFromBox());
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////// THEME

//////////////////////////////////////////////////////////////////////////////////////////////////// HOMEPAGE CONTROLLER
class HomePageController extends GetxController {
  var currentIndex = 0.obs;
  late PageController pageViewController;

  changeIndex(index) => currentIndex.value = index;

  @override
  void onInit() {
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
    pageViewController = PageController(initialPage: currentIndex.value);
  }
}
//////////////////////////////////////////////////////////////////////////////////////////////////// HOMEPAGE CONTROLLER

class AllPageController extends GetxController {
  // QUIZ ////////////////////////////////////////////////////////////////////////////////////////////////
  // SCORE SECTION
  var trueScore = 0.obs;
  var falseScore = 0.obs;
  var falseOrTrue = "".obs;
  var falseOrTrueColor = (Colors.lightGreen).obs;

  // QUESTION SECTION
  var kanjiVisibility = true.obs;
  var romajiVisibility = false.obs;
  var englishVisibility = true.obs;
  var quizWordList = [].obs;
  var rand = 0.obs;

  // SETTING SECTION
  var answerTypeItem = ['Kanji', 'Romaji', 'English'].obs;
  var answerTypeValue = "Romaji".obs;
  final wordTypeItem =
      ["Verb", "Adjective", "Noun", "Hiragana", "Katakana"].obs;
  var wordTypeValue = "Verb".obs;
  final levelTypeItem = ["N5", "N4"].obs;
  var levelTypeValue = "N5".obs;

  var spellingVisibility = false.obs;

  // TEXTFIELD SECTION
  TextEditingController submitTextfield = TextEditingController();

  randNum() => quizWordList.length.isNull
      ? 0
      : rand.value = Random().nextInt(quizWordList.length);

  void changeSpellingVisibility(value) {
    spellingVisibility.value = value;
    answerTypeValue.value.contains("Romaji")
        ? englishVisibility.value = !value
        : answerTypeValue.value.contains("Kanji")
            ? romajiVisibility.value = !value
            : romajiVisibility.value = !value;
  }

  // function to check which the wordtype is being used by user
  void changeWordType(wordType, levelType) async {
    final dir = await getApplicationDocumentsDirectory();
    switch (wordType) {
      case "Verb":
        final fileVerb = File('${dir.path}/verb.json');
        quizWordList.value = jsonDecode(fileVerb.readAsStringSync())[levelType];
        randNum();
        break;
      case "Adjective":
        final fileAdjective = File('${dir.path}/adjective.json');
        quizWordList.value =
            jsonDecode(fileAdjective.readAsStringSync())[levelType];
        randNum();
        break;
      case "Noun":
        final fileNoun = File('${dir.path}/noun.json');
        quizWordList.value = jsonDecode(fileNoun.readAsStringSync())[levelType];
        randNum();
        break;
      case "Hiragana":
        final fileKana = File('${dir.path}/kana.json');
        quizWordList.value = jsonDecode(fileKana.readAsStringSync());
        randNum();
        break;
      case "Katakana":
        final fileKana = File('${dir.path}/kana.json');
        quizWordList.value = jsonDecode(fileKana.readAsStringSync());
        randNum();
        break;
      default:
    }
  }

  // set the visibility function to visibilty change base on answer type
  wordVisibility(answerType) {
    switch (answerType) {
      case "Kanji":
        if (spellingVisibility.isTrue) {
          englishVisibility.value = true;
          romajiVisibility.value = kanjiVisibility.value = false;
          return;
        }
        romajiVisibility.value = englishVisibility.value = true;
        kanjiVisibility.value = false;
        break;
      case "Romaji":
        if (spellingVisibility.isTrue) {
          kanjiVisibility.value = true;
          englishVisibility.value = romajiVisibility.value = false;
          return;
        }
        kanjiVisibility.value = englishVisibility.value = true;
        romajiVisibility.value = false;
        break;
      case "English":
        if (spellingVisibility.isTrue) {
          kanjiVisibility.value = true;
          englishVisibility.value = romajiVisibility.value = false;
          return;
        }
        kanjiVisibility.value = romajiVisibility.value = true;
        englishVisibility.value = false;
        break;
      default:
    }
  }

  // if answer false
  answerFalse(answerType) {
    falseScore.value++;
    kanjiVisibility.value =
        romajiVisibility.value = englishVisibility.value = true;
    falseOrTrue.value = "SALAH";
    falseOrTrueColor.value = Colors.red;
    submitTextfield.clear();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        wordVisibility(answerType);
        falseOrTrue.value = "";
        randNum();
      },
    );
  }

  // if answer true
  answerTrue() {
    randNum();
    trueScore.value++;
    submitTextfield.clear();
    falseOrTrue.value = "BENAR";
    falseOrTrueColor.value = Colors.green;
    Future.delayed(
      const Duration(seconds: 1),
      () {
        falseOrTrue.value = "";
      },
    );
  }

  // function for checking the answer
  void checkAnswer(answerType, wordType) {
    // check which answer tyle that user use, than execute the function if answer base on answer type is same as the question
    switch (answerType) {
      case "Kanji":
        if (wordType.contains("Verb") ||
            wordType.contains("Adjective") ||
            wordType.contains("Noun")) {
          if (submitTextfield.text
              .contains(quizWordList[rand.value]["KanjiCasualPositive"])) {
            answerTrue();
          } else {
            answerFalse(answerType);
          }
          break;
        } else {
          if ((submitTextfield.text.contains(
                      KanaKit().toHiragana(quizWordList[rand.value]["Spell"])) &
                  wordType.contains("Hiragana")) ||
              (submitTextfield.text.contains(
                      KanaKit().toKatakana(quizWordList[rand.value]["Spell"])) &
                  wordType.contains("Katakana"))) {
            answerTrue();
          } else {
            answerFalse(answerType);
          }
          break;
        }
      case "Romaji":
        if (wordType.contains("Verb") ||
            wordType.contains("Adjective") ||
            wordType.contains("Noun")) {
          if (submitTextfield.text
              .contains(quizWordList[rand.value]["RomajiCasualPositive"])) {
            answerTrue();
          } else {
            answerFalse(answerType);
          }
          break;
        } else {
          if ((submitTextfield.text
                      .contains(quizWordList[rand.value]["Spell"]) &
                  wordType.contains("Hiragana")) ||
              (submitTextfield.text
                      .contains(quizWordList[rand.value]["Spell"]) &
                  wordType.contains("Katakana"))) {
            answerTrue();
          } else {
            answerFalse(answerType);
          }
          break;
        }
      case "English":
        if (quizWordList[rand.value]["EnglishCasualPositive"]
                .toString()
                .replaceAll(RegExp('\\(.*?\\)'), '')
                .toLowerCase()
                .split("; ")
                .contains(submitTextfield.text.toLowerCase()) &
            ((!wordType.contains("Hiragana") ||
                !wordType.contains("Katakana")))) {
          answerTrue();
        } else {
          answerFalse(answerType);
        }
        break;
      default:
    }
  }
  // QUIZ ////////////////////////////////////////////////////////////////////////////////////////////////

  // DICTIONARY ////////////////////////////////////////////////////////////////////////////////////////////////
  var dictionaryWordList = [].obs;
  var dictionaryKanaList = [].obs;
  var foundWord = [].obs;

  // Textfield controler for search word in list dictionary
  TextEditingController txtQuery = TextEditingController();

  // function to initialize words to dictionary list from the downloaded file from firebase
  Future getList() async {
    final dir = await getApplicationDocumentsDirectory();
    final fileVerb = File('${dir.path}/verb.json');
    final fileAdjective = File('${dir.path}/adjective.json');
    final fileNoun = File('${dir.path}/noun.json');
    final fileKana = File('${dir.path}/kana.json');

    if (fileVerb.existsSync() ||
        fileAdjective.existsSync() ||
        fileAdjective.existsSync() ||
        fileKana.existsSync()) {
      dictionaryWordList.value = jsonDecode(fileVerb.readAsStringSync())['N5'] +
          jsonDecode(fileVerb.readAsStringSync())['N4'] +
          jsonDecode(fileAdjective.readAsStringSync())['N5'] +
          jsonDecode(fileAdjective.readAsStringSync())['N4'] +
          jsonDecode(fileNoun.readAsStringSync())['N5'] +
          jsonDecode(fileNoun.readAsStringSync())['N4'];

      foundWord.value = dictionaryWordList;
      foundWord.sort(
        (a, b) => a['KanjiCasualPositive'].toLowerCase().compareTo(
              b['KanjiCasualPositive'].toLowerCase(),
            ),
      );

      dictionaryKanaList.value = jsonDecode(fileKana.readAsStringSync());

      quizWordList.value = jsonDecode(fileVerb.readAsStringSync())['N5'];
      rand.value = Random().nextInt(quizWordList.length);
    } else {
      downloadAndUpdateWord();
    }
  }

  // This function is called whenever the text field changes
  void searchFIlter(String enteredKeyword) {
    List results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = dictionaryWordList;
    } else {
      results = dictionaryWordList.where((words) {
        final kanji = words["KanjiCasualPositive"].toLowerCase();
        final romaji = words["RomajiCasualPositive"].toLowerCase();
        final english = words["EnglishCasualPositive"].toLowerCase();
        final searchLower = enteredKeyword.toLowerCase();

        return kanji.contains(searchLower) ||
            romaji.contains(searchLower) ||
            english.contains(searchLower);
      }).toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    foundWord.value = results;
  }
  // DICTIONARY ////////////////////////////////////////////////////////////////////////////////////////////////

  // SETTING ////////////////////////////////////////////////////////////////////////////////////////////////
  // Set function to save word list verb, adjective and noun to be downloaded to local app directory
  Future downloadAndUpdateWord() async {
    final dir = await getApplicationDocumentsDirectory();

    // 1) set the reference form firebase storage file location
    Reference refVerb = FirebaseStorage.instance.ref('/word_list/verb.json');
    Reference refAdjective =
        FirebaseStorage.instance.ref('/word_list/adjective.json');
    Reference refNoun = FirebaseStorage.instance.ref('/word_list/noun.json');
    Reference refKana = FirebaseStorage.instance.ref('/word_list/kana.json');

    // 2) set the local file path
    final fileVerb = File('${dir.path}/${refVerb.name}');
    final fileAdjective = File('${dir.path}/${refAdjective.name}');
    final fileNoun = File('${dir.path}/${refNoun.name}');
    final fileKana = File('${dir.path}/${refKana.name}');

    // 3) write the firebase reference to local file path that has been defined
    await refVerb.writeToFile(fileVerb);
    await refAdjective.writeToFile(fileAdjective);
    await refNoun.writeToFile(fileNoun);
    await refKana.writeToFile(fileKana);

    Get.snackbar("Download and Update",
        "${refVerb.name}, ${refAdjective.name}, ${refNoun.name}, and ${refKana.name} has been downloaded. The list has been updated.");

    print("DONWLOAD DOWNLOAD DOWNLOAD DOWNLOAD");
    getList();
  }

  var aboutApp =
      "This application does not provide any certificates regarding Japanese English, such as JPLT or the like.\nThis application was created so that users can learn and memorize Japanese English vocabularies. This application also aims for users to memorize each kanji, how to pronounce it and the meaning of the word in Indonesian English. This application is made based on JPLT vocabulary. But it does not guarantee that the translation and pronunciation of the vocabulary is 100% correct. If there are kanji errors, translations, or suggestions, you can contact the developer email or via Google Playstore review. Thank you for downloading this app."
          .obs;
  var rateLink =
      'https://play.google.com/store/apps/details?id=com.japanesequizen.hayashi19'
          .obs;
  var websiteVersion = 'https://kuis-kosakata-english-jepang.web.app/'.obs;

  // theme button variable
  var themeButtonColor = (Colors.black).obs;
  var themeButtonTextColor = (Colors.white).obs;
  var themeButtonText = "Dark Mode".obs;
  var themeButtonIcon = const Icon(Icons.brightness_2);

  void changeButtonTheme() {
    if (Get.isDarkMode) {
      themeButtonColor.value = Colors.black;
      themeButtonTextColor.value = Colors.white;
      themeButtonText = "Dark Mode".obs;
      themeButtonIcon = const Icon(Icons.brightness_2);
      return;
    } else {
      themeButtonColor.value = Colors.white;
      themeButtonTextColor.value = Colors.black;
      themeButtonText = "Light Mode".obs;
      themeButtonIcon = const Icon(Icons.brightness_7_outlined);
    }
  }
  // SETTING ////////////////////////////////////////////////////////////////////////////////////////////////

  // ADS ////////////////////////////////////////////////////////////////////////////////////////////////
  // QUIZ ADS
  var quizBanner1 = 'ca-app-pub-3940256099942544/2247696110'.obs;
  var quizBanner2 = 'ca-app-pub-3940256099942544/2247696110'.obs;
  var quizAdsController = NativeAdmobController();

  // DICTIONARY ADS
  var dictionaryBanner1 = 'ca-app-pub-3940256099942544/2247696110'.obs;
  var dictionaryBanner2 = 'ca-app-pub-3940256099942544/2247696110'.obs;
  var dictionaryBannerExtra = 'ca-app-pub-3940256099942544/2247696110'.obs;
  var dictoinaryAdsController = NativeAdmobController();

  // SETTING ADS
  var settingBanner1 = 'ca-app-pub-3940256099942544/2247696110'.obs;
  var settingBanner2 = 'ca-app-pub-3940256099942544/2247696110'.obs;
  var settingAdsController = NativeAdmobController();
  // ADS ////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    getList();
  }
}
