import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class WillTabBar extends StatefulWidget {

  ///The function that is to be called when the current index/value of this [WillTabBar] changes.
  final Function(int) onTap;

  ///The function that is to be used to get the current index/value of this [WillTabBar].
  final Function currentValue;

  ///
  final List<String> tabBarItemTitles;

  ///
  final double customBarWidth;

  ///
  final Color normalTextColor;

  ///
  final Color selectTextColor;

  ///
  final Color customBarColor;

  ///
  final double normalTextFontSize;

  ///
  final double selectTextFontSize;

  ///
  final double horizontalMargin;

  const WillTabBar({
    Key key,
    this.tabBarItemTitles,
    this.onTap,
    this.currentValue,
    this.customBarWidth = 0.5,
    this.normalTextColor = const Color(0xffA1A8BD),
    this.normalTextFontSize = 16,
    this.selectTextColor = const Color(0xff0062E0),
    this.selectTextFontSize = 16,
    this.horizontalMargin = 10,
    this.customBarColor = const Color(0xff0062E0)
  }) : assert(tabBarItemTitles != null,'tabBarItemTitles must not be null'),assert(tabBarItemTitles.length < 6,'tabBarItemTitles must be less than 5');

  @override
  _WillTabBarState createState() => _WillTabBarState();
}

class _WillTabBarState extends State<WillTabBar> {
  List<GlobalKey> _globalKeys;
  bool _showSelf;
  double _maxWidth;
  double _maxHeight;
  double _barH = 5;

  int selectIndex = 0;
  void tabBarSelected(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  void onPostFrameCallback(Duration duration) {
    if (!_showSelf) {
      setState(() {
        _maxWidth = 0;
        _maxHeight = 0;
        for (int i = 0; i < _globalKeys.length; i++) {
          RenderBox _renderBox =
          _globalKeys[i].currentContext.findRenderObject();
          if (_renderBox.size.width > _maxWidth) {
            _maxWidth = _renderBox.size.width;
          }
          if (_renderBox.size.height > _maxHeight) {
            _maxHeight = _renderBox.size.height;
          }
        }
        _maxWidth = _maxWidth - (widget.horizontalMargin*2/widget.tabBarItemTitles.length);
        _showSelf = true;
      });
    }
  }

  void initState() {
    super.initState();
    _globalKeys = List<GlobalKey>();
    for (int i = 0; i < widget.tabBarItemTitles.length; i++) {
      _globalKeys.add(GlobalKey());
    }
    _showSelf = false;
    WidgetsBinding.instance.addPostFrameCallback(onPostFrameCallback);
  }

  List<Widget> tabBars() => List<Widget>.generate(widget.tabBarItemTitles.length, (int index) {
    return Expanded(
        flex: 1,
        child: GestureDetector(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  widget.tabBarItemTitles[index],
                  style: index == widget.currentValue()
                      ? TextStyle(fontSize: widget.selectTextFontSize, color: widget.selectTextColor)
                      : TextStyle(fontSize: widget.normalTextFontSize, color: widget.normalTextColor),
                )
              ],
            ),
          ),
          onTap: (){
            widget.onTap(index);
          },
        )
    );
  });

  Alignment _getAlignment() {
    return Alignment(-1.0 + widget.currentValue() / (widget.tabBarItemTitles.length - 1) * 2, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = tabBars();
    if (!_showSelf) {
      return Stack(
        children: <Widget>[
          Row(
            children: List<Widget>.generate(_globalKeys.length, (int index) {
              if (index < _list.length) {
                return Container(
                  key: _globalKeys[index],
                  child: tabBars()[index],
                );
              } else {
                return Container(
                  key: _globalKeys[index],
                  constraints: null,
                );
              }
            }),
          )
        ],
      );
    } else {
      return Container(
        margin: EdgeInsets.fromLTRB(widget.horizontalMargin,widget.horizontalMargin,widget.horizontalMargin,0),
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(14),topRight: Radius.circular(14))
        ),
        child: Stack(
          alignment: AlignmentDirectional.centerStart,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Color(0xffeeeeee),width: 1,style: BorderStyle.solid),)
              ),
              child: Row(
                  children: tabBars()
              ),
            ),
            AnimatedAlign(
              alignment: _getAlignment(),
              duration: const Duration(milliseconds: 200),
              child: Container(
                width: _maxWidth,
                height: _barH,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: _maxWidth*(1-widget.customBarWidth)/2,
                      height: _barH,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    ),
                    Container(
                      width: _maxWidth*widget.customBarWidth,
                      height: _barH,
                      decoration: BoxDecoration(
                        color: widget.customBarColor,
                      ),
                    ),
                    Container(
                      width: _maxWidth*(1-widget.customBarWidth)/2,
                      height: _barH,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
