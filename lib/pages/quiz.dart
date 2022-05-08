import 'package:flutter/material.dart';
import 'package:flutter_native_admob/flutter_native_admob.dart';
import 'package:flutter_native_admob/native_admob_options.dart';
import 'package:get/get.dart';

import 'package:japanese_vocab_quiz_en/controller/controller.dart';
import 'package:kana_kit/kana_kit.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.put(AllPageController());
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Stack(
        children: <Widget>[
          ListView(
            children: const <Widget>[
              QuizScore(),
              SizedBox(height: 8),
              // QuizAd1(),
              SizedBox(height: 8),
              QuizQuestion(),
              SizedBox(height: 8),
              QuizAnswer(),
              SizedBox(height: 8),
              // QuizAd2(),
              Divider(
                color: Colors.blueGrey,
                height: 36,
                thickness: 4,
              ),
              QuizDropdownMenu(),
              SizedBox(height: 8),
            ],
          ),
          const QuizHint()
        ],
      ),
    );
  }
}

class QuizScore extends StatelessWidget {
  const QuizScore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.find();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Card(
          elevation: 4,
          shadowColor: Colors.redAccent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFFCB2D3E), Color(0xFFEF473A)],
              ),
            ),
            child: Obx(
              () => Text(
                "INCORRECT ${allPageController.falseScore}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        Obx(
          () => Text(
            allPageController.falseOrTrue.value,
            style: TextStyle(color: allPageController.falseOrTrueColor.value),
          ),
        ),
        Card(
          elevation: 4,
          shadowColor: Colors.greenAccent,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFFA8E063), Color(0xFF56AB2F)],
              ),
            ),
            child: Obx(
              () => Text(
                "CORRECT ${allPageController.trueScore}",
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class QuizQuestion extends StatelessWidget {
  const QuizQuestion({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.find();
    // Averall card to be a backfround for the question
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(
          () {
            if (allPageController.quizWordList.isEmpty) {
              // check if the list is emtry or not
              // if yes just return the circle indicator
              return const Center(
                child: SizedBox(
                  height: 50,
                  width: 50,
                  child: CircularProgressIndicator(
                    color: Colors.redAccent,
                    semanticsLabel: "Loading words . . .",
                  ),
                ),
              );
            } else {
              // if not true so check again if its choose kana or not
              // if kana so change question to kana layout
              if (allPageController.wordTypeValue.contains("Hiragana") ||
                  allPageController.wordTypeValue.contains("Katakana")) {
                return Column(
                  children: <Widget>[
                    //
                    Obx(
                      () => Visibility(
                        visible: allPageController.kanjiVisibility.value,
                        child: Obx(
                          () => Text(
                            allPageController.wordTypeValue == "Hiragana" &&
                                    !(allPageController.quizWordList.isNull)
                                ? const KanaKit()
                                    .toHiragana(allPageController.quizWordList[
                                        allPageController.rand.value]["Spell"])
                                    .toString()
                                : const KanaKit()
                                    .toKatakana(allPageController.quizWordList[
                                        allPageController.rand.value]["Spell"])
                                    .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 64,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Romaji question
                    Obx(
                      () => Visibility(
                        visible: allPageController.romajiVisibility.value,
                        child: Obx(
                          () => Text(
                            allPageController
                                .quizWordList[allPageController.rand.value]
                                    ["Spell"]
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Column(
                  children: <Widget>[
                    // Kanji question
                    Obx(
                      () => Visibility(
                        visible: allPageController.kanjiVisibility.value,
                        child: Obx(
                          () => Text(
                            allPageController
                                .quizWordList[allPageController.rand.value]
                                    ["KanjiCasualPositive"]
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 64,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Romaji question
                    Obx(
                      () => Visibility(
                        visible: allPageController.romajiVisibility.value,
                        child: Obx(
                          () => Text(
                            allPageController
                                .quizWordList[allPageController.rand.value]
                                    ["RomajiCasualPositive"]
                                .toString(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Bahasa question
                    Obx(
                      () => Visibility(
                        visible: allPageController.englishVisibility.value,
                        child: Obx(
                          () => Text(
                            (allPageController.quizWordList[allPageController
                                    .rand.value]["EnglishCasualPositive"])
                                .toString()
                                .split("; ")[0],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
          },
        ),
      ),
    );
  }
}

class QuizSwitch extends StatelessWidget {
  const QuizSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.find();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              "Hide Spelling",
              style: TextStyle(fontSize: 16),
            ),
            Obx(
              () => Switch(
                value: allPageController.spellingVisibility.value,
                onChanged: (value) =>
                    allPageController.changeSpellingVisibility(value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizAnswer extends StatelessWidget {
  const QuizAnswer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.find();
    return Obx(
      () {
        if ((allPageController.answerTypeValue.value == "English") &&
            (allPageController.wordTypeValue.value == "Hiragana" ||
                allPageController.wordTypeValue.value == "Katakana")) {
          return const Center(
            child: Text(
                "Unavailable, English input can not be used while the word type is hiragana or katana."),
          );
        } else {
          return Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Obx(
                      () => TextField(
                        controller: allPageController.submitTextfield,
                        onEditingComplete: () => allPageController.checkAnswer(
                            allPageController.answerTypeValue.value,
                            allPageController.wordTypeValue.value),
                        decoration: InputDecoration(
                          hintText:
                              "asnwer with ${allPageController.answerTypeValue.value}",
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  // Set onPressed to get rand number
                  onPressed: () => allPageController.checkAnswer(
                      allPageController.answerTypeValue.value,
                      allPageController.wordTypeValue.value),
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'CHECK',
                      maxLines: 1,
                      softWrap: false,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Josefin Sans',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}

// ignore: must_be_immutable
class Dropdown extends StatelessWidget {
  // Parameter
  String altValue;
  final List<String> altItem;
  final ValueChanged altOnChange;

  // Initialize
  Dropdown(
      {Key? key,
      required this.altItem,
      required this.altValue,
      required this.altOnChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: altValue,
            isExpanded: true,
            onChanged: (String? newValue) {
              altOnChange(newValue);
            },
            items: altItem.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }
}

class QuizDropdownMenu extends StatelessWidget {
  const QuizDropdownMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Quiz Settings",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        const QuizSwitch(),
        Obx(
          () => Row(
            children: <Widget>[
              // Level
              allPageController.wordTypeValue == "Hiragana" ||
                      allPageController.wordTypeValue == "Katakana"
                  ? Container()
                  : Expanded(
                      child: Obx(
                        () => Dropdown(
                          altItem: allPageController.levelTypeItem,
                          altValue: allPageController.levelTypeValue.value,
                          altOnChange: (value) {
                            allPageController.levelTypeValue.value = value;
                            allPageController.changeWordType(
                              allPageController.wordTypeValue.value,
                              allPageController.levelTypeValue.value,
                            );
                          },
                        ),
                      ),
                    ),
              // Word Type
              Expanded(
                child: Obx(
                  () => Dropdown(
                    altItem: allPageController.wordTypeItem,
                    altValue: allPageController.wordTypeValue.value,
                    altOnChange: (value) {
                      allPageController.wordTypeValue.value = value;
                      allPageController.changeWordType(
                        allPageController.wordTypeValue.value,
                        allPageController.levelTypeValue.value,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        // Answer type
        Obx(
          () => Dropdown(
            altItem: allPageController.answerTypeItem,
            altValue: allPageController.answerTypeValue.value,
            altOnChange: (value) {
              allPageController.answerTypeValue.value = value;
              allPageController
                  .wordVisibility(allPageController.answerTypeValue.value);
            },
          ),
        )
      ],
    );
  }
}

class QuizHint extends StatelessWidget {
  const QuizHint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Align(
      alignment: Alignment.bottomRight,
      child: FlatButton.icon(
        onPressed: () => showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            if (allPageController.wordTypeValue == "Hiragana" ||
                allPageController.wordTypeValue == "Katakana") {
              return Container(
                height: 150,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Card(
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Obx(
                          () => Text(
                            "${allPageController.wordTypeValue == "Hiragana" ? KanaKit().toHiragana(allPageController.quizWordList[allPageController.rand.value]["Spell"]) : KanaKit().toKatakana(allPageController.quizWordList[allPageController.rand.value]["Spell"])} [${allPageController.quizWordList[allPageController.rand.value]["Spell"]}]",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      child: const Text("Close"),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              );
            } else {
              return Container(
                height: 500,
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: ListView(
                        children: <Widget>[
                          // Content inside the bottom sheet
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Obx(
                                () => Text(
                                  "${allPageController.quizWordList[allPageController.rand.value]["KanjiCasualPositive"]} (${allPageController.quizWordList[allPageController.rand.value]["RomajiCasualPositive"]})",
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 42,
                            child: Obx(
                              () => ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: (allPageController.quizWordList[
                                            allPageController.rand.value]
                                        ["EnglishCasualPositive"])
                                    .toString()
                                    .split("; ")
                                    .length,
                                itemBuilder: (context, index) => Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Obx(
                                      () => Text((allPageController
                                                      .quizWordList[
                                                  allPageController.rand.value]
                                              ["EnglishCasualPositive"])
                                          .toString()
                                          .split("; ")[index]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            "Conjugation:",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(height: 8),
                          Obx(() => Text(
                              "JPLT Level: ${allPageController.quizWordList[allPageController.rand.value]["Level"]}")),
                          Obx(() => Text(
                              "Type ${allPageController.wordTypeValue}: ${allPageController.quizWordList[allPageController.rand.value]["WordType"]}")),
                          const SizedBox(height: 8),
                          Obx(() => Text(
                              "Negative Casual: ${allPageController.quizWordList[allPageController.rand.value]["KanjiCasualNegative"]} (${allPageController.quizWordList[allPageController.rand.value]["RomajiCasualNegative"]})")),
                          Obx(() => Text(
                              "Casual Past: ${allPageController.quizWordList[allPageController.rand.value]["KanjiCasualPast"]} (${allPageController.quizWordList[allPageController.rand.value]["RomajiCasualPast"]})")),
                          const SizedBox(height: 8),
                          Obx(() => Text(
                              "Positive Polite: ${allPageController.quizWordList[allPageController.rand.value]["KanjiPolitePositive"]} (${allPageController.quizWordList[allPageController.rand.value]["RomajiPolitePositive"]})")),
                          Obx(() => Text(
                              "Negative Polite: ${allPageController.quizWordList[allPageController.rand.value]["KanjiPoliteNegative"]} (${allPageController.quizWordList[allPageController.rand.value]["RomajiPoliteNegative"]})")),
                          Obx(() => Text(
                              "Polite Past: ${allPageController.quizWordList[allPageController.rand.value]["KanjiPolitePast"]} (${allPageController.quizWordList[allPageController.rand.value]["RomajiPolitePast"]})")),
                        ],
                      ),
                    ),
                    // Close button
                    ElevatedButton(
                      child: const Text("Close"),
                      onPressed: () => Navigator.pop(context),
                    )
                  ],
                ),
              );
            }
          },
        ),
        icon: const Icon(Icons.help),
        label: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text('Hint'),
        ),
        color: const Color(0xFF002868),
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }
}

class QuizAd1 extends StatelessWidget {
  const QuizAd1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Container(
      height: 66,
      color: Colors.blueGrey[300],
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Obx(
        () => NativeAdmob(
          error: const Center(child: Text("Ads not available")),
          adUnitID: allPageController.quizBanner1.value,
          controller: allPageController.quizAdsController,
          type: NativeAdmobType.full,
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

class QuizAd2 extends StatelessWidget {
  const QuizAd2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AllPageController allPageController = Get.find();
    return Container(
      height: 66,
      color: Colors.blueGrey[300],
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Obx(
        () => NativeAdmob(
          error: const Center(child: Text("Ads not available")),
          adUnitID: allPageController.quizBanner2.value,
          controller: allPageController.quizAdsController,
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
