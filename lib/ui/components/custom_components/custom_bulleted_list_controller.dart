import 'package:flutter/material.dart';
import 'package:minddy/system/model/custom_bulleted_list_element_model.dart';
import 'package:minddy/ui/components/custom_components/custom_bulleted_list_element_widget.dart';

class CustomBulletedListController extends ChangeNotifier {
  final List<dynamic> initialContent;
  late List<dynamic> stringContent;
  late List<CustomBulletedListElementModel> content;
  late List<CustomBulletedListElementWidget> widgetContent;

  CustomBulletedListController(this.initialContent) {
    content = buildListElementsModels(initialContent);
    stringContent = getContentAsStrings();
    if (content.isEmpty) {
      content.add(CustomBulletedListElementModel(text: "", index: 0, isNew: false, focusNode: FocusNode()));
      stringContent = getContentAsStrings();
    }
  }

  modifyText(String newText, int index) {
    content.firstWhere((element) => element.index == index).text = newText;
    stringContent = getContentAsStrings();
  }

  List<dynamic> getContentAsStrings() {
    return content.map((e) => e.text).toList();
  }

  void addNewElement(CustomBulletedListElementModel element, FocusNode actualFocusedNode) {
    removeEmptyElements();
    content.add(element);
    stringContent = getContentAsStrings();
    notifyListeners();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      actualFocusedNode.unfocus();
      content.last.focusNode.requestFocus();
    });
  }

  void removeElementAtIndex(int index) {
    var elementToRemove = content.firstWhere((element) => element.index == index);
    content.remove(elementToRemove);
    stringContent = getContentAsStrings();
    notifyListeners();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Adding focus to the nearest element
      try {
        int nearestIndex = findClosestIndex(content.map((e) => e.index).toList(), index);
        if (nearestIndex <= -1) {
          if (content.length == 1) {
            content.first.focusNode.requestFocus();
            return;
          } else {
            return;
          }
        }
        content[nearestIndex].focusNode.requestFocus();
      } catch (e) {
        return;
      }
    });
  }

  void removeEmptyElements() {
    content.removeWhere((element) => element.text.isEmpty);
  }

  List<CustomBulletedListElementModel> buildListElementsModels(List<dynamic> list) {
    List<CustomBulletedListElementModel> listElementsModelsList = [];
    for (int i = 0; i < list.length; i++) {
      listElementsModelsList.add(
        CustomBulletedListElementModel(
          focusNode: FocusNode(),
          isNew: false,
          text: list[i],
          index: i,
        ),
      );
    }

    listElementsModelsList.sort((a, b) {
      if (a.text.isEmpty && b.text.isNotEmpty) {
        return 1;
      } else if (a.text.isNotEmpty && b.text.isEmpty) {
        return -1;
      } else {
        return 0;
      }
    });

    return listElementsModelsList;
  }

  int findClosestIndex(List<int> list, int target) {
    if (list.isEmpty) {
      throw ArgumentError('The list cannot be empty');
    }

    int closestInt = list.first;
    int minDifference = (closestInt - target).abs();

    for (int number in list) {
      int difference = (number - target).abs();
      if (difference < minDifference) {
        minDifference = difference;
        closestInt = number;
      }
    }

    return closestInt;
  }
}
