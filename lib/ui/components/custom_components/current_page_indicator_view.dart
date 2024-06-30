import 'package:flutter/material.dart';
import 'package:minddy/ui/theme/theme.dart';

class CurrentPageIndicatorView extends StatefulWidget {
  const CurrentPageIndicatorView({super.key, required this.controller, required this.pageController});

  final PageController pageController;

  final CurrentPageIndicatorController controller;


  @override
  State<CurrentPageIndicatorView> createState() => _PageIndexIndicatorViewState();
}

class _PageIndexIndicatorViewState extends State<CurrentPageIndicatorView> {


  List<Widget> buildIndiactors() {
    List<Widget> indicators = [];
    for (int i = 0; i < widget.controller.totalPages; i++) {
      indicators.add(
        _Indicator(
          currentPageIndex: widget.controller.currentPageIndex,
          pageController: widget.pageController, 
          index: i
        )
      );
    }
    return indicators;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: AnimatedBuilder(
        animation: widget.controller, 
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: buildIndiactors(),
          );
        }
      ),
    );
  }
}

class _Indicator extends StatefulWidget {
  const _Indicator({required this.currentPageIndex, required this.index, required this.pageController});
  final int index;

  final PageController pageController;

  final int currentPageIndex;

  @override
  State<_Indicator> createState() => _IndicatorState();
}

class _IndicatorState extends State<_Indicator> {
  @override
  Widget build(BuildContext context) {
    final StylesGetters theme = StylesGetters(context);
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: GestureDetector(
        onTap: () {
          widget.pageController.animateToPage(
            widget.index, 
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeInOutCubicEmphasized
          );
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 600),
          curve: Curves.fastEaseInToSlowEaseOut,
          width: widget.index == widget.currentPageIndex ? 30 : 10,
          height: 10,
          decoration: BoxDecoration(
            color: theme.brightness == Brightness.light ? theme.primaryContainer : theme.onPrimary.withAlpha(110),
            borderRadius: BorderRadius.circular(5)
          ),
        ),
      ),
    );
  }
}

class CurrentPageIndicatorController extends ChangeNotifier {
  int currentPageIndex = 0;
  int totalPages = 0;

  void pageChanged(int newPageIndex) {
    currentPageIndex = newPageIndex;
    notifyListeners();
  }
}