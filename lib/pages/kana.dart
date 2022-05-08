import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_vocab_quiz_en/controller/controller.dart';
import 'package:kana_kit/kana_kit.dart';

class KanaPage extends StatelessWidget {
  const KanaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.put(AllPageController());
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: ListKana(),
    );
  }
}

class ListKana extends StatelessWidget {
  const ListKana({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllPageController allPageController = Get.find();
    return Obx(
      () => ListView.separated(
        itemCount: allPageController.dictionaryKanaList.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(height: 8),
        itemBuilder: (context, index) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      const Text("Romaji"),
                      const Divider(thickness: 3, color: Colors.blueAccent),
                      Text(
                        allPageController.dictionaryKanaList[index]["Spell"]
                            .toString()
                            .toUpperCase(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      const Text("Hiragana"),
                      const Divider(thickness: 3, color: Colors.blueAccent),
                      Text(
                        const KanaKit()
                            .toHiragana(allPageController
                                .dictionaryKanaList[index]["Spell"])
                            .toString(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: <Widget>[
                      const Text("Katakana"),
                      const Divider(thickness: 3, color: Colors.blueAccent),
                      Text(
                        const KanaKit()
                            .toKatakana(allPageController
                                .dictionaryKanaList[index]["Spell"])
                            .toString(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
