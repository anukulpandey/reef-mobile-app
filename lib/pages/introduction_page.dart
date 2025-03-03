import 'package:flutter/material.dart';
import 'package:reef_mobile_app/components/introduction_page/introduction_slide.dart';
import 'package:reef_mobile_app/utils/liquid_edge/liquid_carousel.dart';
import 'package:reef_mobile_app/utils/styles.dart';

typedef ShouldRebuildFunction<T> = bool Function(T oldWidget, T newWidget);

class ShouldRebuild<T extends Widget> extends StatefulWidget {
  final T child;
  final ShouldRebuildFunction<T>? shouldRebuild;
  const ShouldRebuild({super.key, required this.child, this.shouldRebuild});
  @override
  // ignore: library_private_types_in_public_api
  _ShouldRebuildState createState() => _ShouldRebuildState<T>();
}

class _ShouldRebuildState<T extends Widget> extends State<ShouldRebuild> {
  @override
  ShouldRebuild<T> get widget => super.widget as ShouldRebuild<T>;
  T? oldWidget;
  @override
  Widget build(BuildContext context) {
    final T newWidget = widget.child;
    if (oldWidget == null ||
        (widget.shouldRebuild == null
            ? true
            : widget.shouldRebuild!(oldWidget!, newWidget))) {
      oldWidget = newWidget;
    }
    return oldWidget as T;
  }
}

class IntroductionPage extends StatelessWidget {
  final Future<void> Function() onDone;
  const IntroductionPage({Key? key, required this.title, required this.onDone})
      : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    //? Use a key to interact with the carousel from another widget (for triggering swipeToNext or swipeToPrevious from a button for example)
    final carouselKey = GlobalKey<LiquidCarouselState>();
    return Scaffold(
      body: LiquidCarousel(
        key: carouselKey,
        children: <Widget>[
          IntroductionSlide(
              key: const ValueKey(1),
              isFirst: true,
              liquidCarouselKey: carouselKey,
              color: Styles.splashBackgroundColor,
              buttonColor: Colors.deepPurpleAccent,
              title: "First View",
              child: Flex(
                crossAxisAlignment: CrossAxisAlignment.start,
                direction: Axis.vertical,
                children: [
                  Expanded(
                    child: Image.asset(
                      "assets/images/intro.gif",
                      height: 240.0,
                      width: 240.0,
                    ),
                  ),
                  Flexible(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          "Reliable",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          "Extensible",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          "Efficient",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          "Fast.",
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          child: Text(
                            "Blockchain for DeFi, NFT and Gaming",
                            style: TextStyle(fontSize: 16),
                          )),
                    ],
                  ))
                ],
              )),
          IntroductionSlide(
              key: const ValueKey(2),
              isLast: true,
              liquidCarouselKey: carouselKey,
              color: Colors.deepPurple.shade900,
              buttonColor: Colors.amberAccent,
              title: "Second View",
              done: onDone,
              child: Flex(
                crossAxisAlignment: CrossAxisAlignment.center,
                direction: Axis.vertical,
                children: [
                  Expanded(
                    flex: 3,
                    child: Image.asset(
                      "assets/images/reef.png",
                      height: 20.0,
                      width: 240.0,
                    ),
                  ),
                  Flexible(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Padding(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              "Introducing Reef Chain",
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ),
                          ),
                          SizedBox(height: 35),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                "Reef chain is an EVM compatible blockchain for DeFi. It is fast, scalable, has low transaction costs and does no wasteful mining. It is built with Substrate Framework and comes with on-chain governance.",
                                style: TextStyle(
                                    fontSize: 16,
                                    height: 2,
                                    color: Colors.white),
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ))
                ],
              )),
        ],
      ),
    );
  }
}
