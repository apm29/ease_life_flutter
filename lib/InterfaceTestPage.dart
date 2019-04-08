import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:io';

class InterfacePage extends StatefulWidget {
  @override
  _InterfacePageState createState() => _InterfacePageState();
}

class _InterfacePageState extends State<InterfacePage> {
  String resText;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          loading
              ? Positioned.fill(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(),
          ListView(
            children: <Widget>[
              Text(resText ?? "empty"),
              RaisedButton(
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  try {
                    HttpClient httpClient = HttpClient();
                    var request = await httpClient
                                          .getUrl(Uri.parse("http://www.flutter.dev"));
                    var response = await request.close();
                    var res = await response.transform(utf8.decoder).join();
                    setState(() {
                      resText = res;
                    });
                  } catch (e) {
                    print(e);
                    setState(() {
                      resText = e.toString();
                    });
                  } finally {
                    setState(() {
                      loading = false;
                    });
                  }

                },
                child: Text("login"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
