import 'package:flutter/material.dart';
import 'package:will_tabbar/will_tabbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WillTabbar Demo',
      home: MyHomePage(title: 'WillTabbar Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int willTabBarCurrentValue = 0;
  int willTabBarValue() => willTabBarCurrentValue;
  void tabBarItemClicked(int index) {
    setState(() {
      willTabBarCurrentValue = index;
    });
  }

  int willTabBarCurrentValue1 = 0;
  int willTabBarValue1() => willTabBarCurrentValue1;
  void tabBarItemClicked1(int index) {
    setState(() {
      willTabBarCurrentValue1 = index;
    });
  }

  int willTabBarCurrentValue2 = 0;
  int willTabBarValue2() => willTabBarCurrentValue2;
  void tabBarItemClicked2(int index) {
    setState(() {
      willTabBarCurrentValue2 = index;
    });
  }

  int willTabBarCurrentValue3 = 0;
  int willTabBarValue3() => willTabBarCurrentValue3;
  void tabBarItemClicked3(int index) {
    setState(() {
      willTabBarCurrentValue3 = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> titles = [
      'Tab1',
      'Tab2',
    ];
    List<String> titles1 = [
      'Tab1',
      'Tab2',
      'Tab3',
    ];
    List<String> titles2 = [
      'Tab1',
      'Tab2',
      'Tab3',
      'Tab4',
    ];
    List<String> titles3 = [
      'Tab1',
      'Tab2',
      'Tab3',
      'Tab4',
      'Tab5',
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        decoration: BoxDecoration(color: Color(0xfff3f2f8)),
        child: ListView(
          children: <Widget>[
            WillTabBar(
                onTap: tabBarItemClicked,
                currentValue: willTabBarValue,
                tabBarItemTitles: titles,
                normalTextFontSize: 13,
                selectTextFontSize: 20,
                normalTextColor: Colors.green,
                selectTextColor: Colors.red),
            WillTabBar(
                onTap: tabBarItemClicked1,
                currentValue: willTabBarValue1,
                horizontalMargin: 60,
                tabBarItemTitles: titles1),
            WillTabBar(
                onTap: tabBarItemClicked2,
                currentValue: willTabBarValue2,
                tabBarItemTitles: titles2,
                normalTextFontSize: 14,
                selectTextFontSize: 22,
                horizontalMargin: 30,
                normalTextColor: Colors.black,
                selectTextColor: Colors.purple),
            WillTabBar(
              onTap: (index){
                setState(() {
                  willTabBarCurrentValue3 = index;
                });
              },
              currentValue: (){
                return willTabBarCurrentValue3;
              },
              tabBarItemTitles: titles3,
              normalTextFontSize: 16,
              selectTextFontSize: 26,
              normalTextColor: Colors.green,
              selectTextColor: Colors.amber,
              customBarWidth: 0.8,
            ),
          ],
        ),
      ) // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
