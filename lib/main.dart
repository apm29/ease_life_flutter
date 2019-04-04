import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      routes: {
        "/": (context) {
          return MyHomePage(title: 'Flutter Demo Home Page');
        },
        "/web": (context) {
          return WebviewScaffold(
            appBar: AppBar(),
            url: "http://www.baidu.com",
            withJavascript: true,
            initialChild: Center(
              child: Text("wait.."),
            ),
          );
        }
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key) {
    print("create statefulWidget");
  }

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  RandomWordState createState() {
    return RandomWordState();
  }
}

class RandomWordState extends State<MyHomePage> {
  final List<WordPair> _suggestions = <WordPair>[];
  final List<WordPair> _favourites = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WordPairs"),
        elevation: 8.0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.star),
              onPressed: () {
                _toSavedPage();
              },
            ),
          )
        ],
      ),
      body: buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("主页")),
          BottomNavigationBarItem(icon: Icon(Icons.person), title: Text("我的")),
          BottomNavigationBarItem(icon: Icon(Icons.message), title: Text("消息")),
        ],
        currentIndex: _currentIndex,
      ),
    );
  }

  Widget buildBody() {
    switch (_currentIndex) {
      case 0:
        return ListView.builder(itemBuilder: (context, index) {
          return buildItem(index);
        });
        break;
      case 1:
        return buildMineBody();
        break;
      case 2:
        return buildMessageBody();
        break;
    }
    return null;
  }

  Widget buildMessageBody() {
    return OutlineButton(
      padding: EdgeInsets.all(0.0),
      textTheme: ButtonTextTheme.primary,
      onPressed: (){
        Navigator.of(context).pushNamed("/web");
      },
      child: Text("web"),
    );
  }

  Widget buildMineBody() {
    return GridView.count(
      childAspectRatio: 0.5,
      crossAxisCount: 3,
      children: <Widget>[
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(
                size: 40.0,
              ),
              Center(child: Title(color: Colors.cyan, child: Text("前往设置"))),
              OutlineButton(
                  onPressed: () async {
                    await PermissionHandler().openAppSettings();
                  },
                  child: Text("立即前往"))
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(
                size: 40.0,
              ),
              Center(child: Title(color: Colors.cyan, child: Text("请求权限"))),
              OutlineButton(
                  onPressed: () async {
                    await requestPermission(
                        context, PermissionGroup.contacts, "联系人权限");
                  },
                  child: Text("通讯录"))
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(
                size: 40.0,
              ),
              Center(child: Title(color: Colors.cyan, child: Text("请求权限"))),
              OutlineButton(
                  onPressed: () async {
                    await requestPermission(
                        context, PermissionGroup.location, "位置权限");
                  },
                  child: Text("位置信息"))
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(
                size: 40.0,
              ),
              Center(child: Title(color: Colors.cyan, child: Text("请求权限"))),
              OutlineButton(
                  onPressed: () async {
                    await requestPermission(
                        context, PermissionGroup.camera, "相机权限");
                  },
                  child: Text("拍照权限"))
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(
                size: 40.0,
              ),
              Center(child: Title(color: Colors.cyan, child: Text("请求权限"))),
              OutlineButton(
                  onPressed: () async {
                    await requestPermission(
                        context, PermissionGroup.microphone, "录音权限");
                  },
                  child: Text("录音权限"))
            ],
          ),
        ),
        Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(
                size: 40.0,
              ),
              Center(child: Title(color: Colors.cyan, child: Text("请求权限"))),
              OutlineButton(
                  onPressed: () async {
                    await requestPermission(
                        context, PermissionGroup.phone, "电话权限");
                  },
                  child: Text("电话权限"))
            ],
          ),
        ),
      ],
    );
  }

  Future requestPermission(BuildContext context, PermissionGroup permission,
      String permissionName) async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([permission]);
    PermissionStatus permissionStatus = permissions[permission];
    print('$permissionStatus');

    showDialog<void>(
        context: context,
        builder: (context) {
          if (permissionStatus != PermissionStatus.granted && permissionStatus != PermissionStatus.unknown) {
            return AlertDialog(
              title: Text("提醒"),
              content: SingleChildScrollView(
                  child: Text(
                      "$permissionName被拒绝,请手动跳转到系统设置页允许App获取$permissionName")),
              actions: <Widget>[
                RaisedButton(
                  onPressed: () async {
                    bool isShown = await PermissionHandler().openAppSettings();
                    print('$isShown');
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "立即前往",
                    style: const TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          } else {
            return AlertDialog(
              title: Text("提醒"),
              content: SingleChildScrollView(child: Text("$permissionName已获取")),
            );
          }
        });
  }

  Widget buildItem(int index) {
    if (index >= _suggestions.length) {
      var generated = generateWordPairs().take(20);
      _suggestions.addAll(generated);
    }
    var currentWord = _suggestions[index];
    var saved = _favourites.contains(currentWord);
    return InkWell(
      customBorder: RoundedRectangleBorder(side: BorderSide()),
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  currentWord.asPascalCase,
                  style: _biggerFont,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (_favourites.contains(currentWord)) {
                        _favourites.remove(currentWord);
                      } else {
                        _favourites.add(currentWord);
                      }
                    });
                  },
                  icon: new Icon(
                    saved ? Icons.favorite : Icons.favorite_border,
                    color: saved ? Colors.red : null,
                  ),
                ),
              )
            ],
          ),
          Divider(
            height: 1.0,
          )
        ],
      ),
    );
  }

  void _toSavedPage() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return SavedPairPage(_favourites);
    }));
  }
}

class SavedPairPage extends StatelessWidget {
  final List<WordPair> data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  title: Text(data[index].asPascalCase),
                ),
                Divider()
              ],
            );
          },
          itemCount: data.length),
    );
  }

  SavedPairPage(this.data);
}
