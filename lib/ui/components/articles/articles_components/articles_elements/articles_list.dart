import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:minddy/system/interface/articles_write_element_interface.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_list_element_widget.dart';
import 'package:minddy/ui/components/articles/articles_components/articles_elements/articles_element_envelop.dart';

class ArticlesListElementcontroller extends ChangeNotifier {
  final List<dynamic> initalContent;
  late List<dynamic> stringContent;
  late List<ArticlesListElementModel> content;

  late List<ArticlesListElementWidget> widgetContent;

  modifyText(String newText, int index) {
   content.firstWhere((element) => element.index == index).text = newText;
   stringContent = getContentAsStrings();
  }

  List<dynamic> getContentAsStrings() {
    List<dynamic> stringList = [];
    stringList = content.map((e) {
      return e.text;
    }).toList();
    return stringList;
  }

  void addNewElement(ArticlesListElementModel element, FocusNode actualFocusedNode) {
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
      } catch(e) {
        return;
      } 
    });
  }

  void removeEmptyElements() {
    content.removeWhere((element) => element.text.isEmpty);
  }

  ArticlesListElementcontroller(this.initalContent) {
    content = _buildListElementsModels(initalContent);
    stringContent = getContentAsStrings();
    if (content.isEmpty) {
      content.add(ArticlesListElementModel(text: "", index: 0, isNew: false, focusNode: FocusNode()));
      stringContent = getContentAsStrings();
    }
  }
}

class ArticlesListElement extends StatelessWidget {
  final List<dynamic>? initialContent;
  final Function(Key) removeFunction;
  late final ArticlesListElementcontroller controller;

  ArticlesListElement({
    super.key, 
    this.initialContent,
    required this.removeFunction
  }) {
    controller = ArticlesListElementcontroller(initialContent ?? []);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 25),
      child: ArticlesElemementEnvelop(
        removeFunction: removeFunction, 
        keyToRemove: key ?? UniqueKey(), 
        sideMenuIconOffsetOnYAxis: 5, 
        child: _ArticlesListElementContent(controller: controller)
      )
    );
  }
}

class _ArticlesListElementContent extends StatefulWidget implements IArticlesWriteElement{
  const _ArticlesListElementContent({required this.controller});

  final ArticlesListElementcontroller controller;

  @override
  State<_ArticlesListElementContent> createState() => __ArticlesListElementContentState();
  
  @override
  List get data => controller.stringContent;
  
  @override
  set data(newData) {
    controller.stringContent = newData;
  } 
}

class __ArticlesListElementContentState extends State<_ArticlesListElementContent> {
  
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        widget.controller.content = _buildListElementsModels(widget.controller.stringContent);
        _buildListElements(widget.controller, widget.controller.content, context);
        return Column(
          children: widget.controller.widgetContent
        );
      }
    );
  }
}

void _buildListElements(ArticlesListElementcontroller controller, List<ArticlesListElementModel> list, BuildContext context) {
  double screenWidth = MediaQuery.of(context).size.width;
  double maxWidth = screenWidth > 1000 ? screenWidth / 3 : screenWidth / 2.5;
  List<ArticlesListElementWidget> listElementsList = [];
  for (int i = 0; i < list.length; i++) {

    listElementsList.add(
      ArticlesListElementWidget(
        key: UniqueKey(),
        initialText: list[i].text,
        index: list[i].index,
        focusNode: list[i].focusNode,
        controller: controller, 
        isNew: list[i].isNew,
        maxWidth: maxWidth,
      )
    );
  }
  controller.widgetContent = listElementsList;
}

List<ArticlesListElementModel> _buildListElementsModels(List<dynamic> list) {
  List<ArticlesListElementModel> listElementsModelsList = [];
  for (int i = 0; i < list.length; i++) {
    listElementsModelsList.add(
     ArticlesListElementModel(
      focusNode: FocusNode(),
      isNew: false,
      text: list[i],
      index: i
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