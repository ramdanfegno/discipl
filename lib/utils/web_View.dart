import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewScreen extends StatefulWidget {
  final String url;
  final bool canPop;
  final Function(String?) onBackPressed;
  final Function(String) onWebViewCompleted;
  const WebViewScreen({Key? key,required this.onBackPressed,required this.canPop,required this.url,required this.onWebViewCompleted}) : super(key: key);

  @override
  _WebViewScreenState createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();
  // ignore: prefer_typing_uninitialized_variables
  var currentFocus;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
  }

  unFocus() {
    currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: unFocus,
      child: SafeArea(
        child: WebView(
          initialUrl: widget.url,
          onPageFinished: (String _url){
            print(_url);
            print('onWebViewCompleted RAMD');
            widget.onWebViewCompleted(_url);

          },
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>{
            JavascriptChannel(
              name: 'flutterHandler',
              onMessageReceived: (JavascriptMessage msg){
                print('message');
                print(msg.message);
                if (msg.message == "close"){

                }
              }

            )
          },
          onWebResourceError: (val) {
            print('error 2');
            print(val.description);
            print(val.errorCode);
            print(val.errorType);

            if(val.errorType == WebResourceErrorType.unsupportedScheme && widget.canPop){
              Navigator.pop(context,true);
              print('can popo adfgadfg');
              widget.onBackPressed(null);
            }
            if(Platform.isIOS && val.errorCode == -1002){
              decodeMessage(val.description);
              //Navigator.pop(context,true);
            }
            if(val.errorType == WebResourceErrorType.timeout && widget.canPop){
              Navigator.pop(context,true);
              widget.onBackPressed(null);
            }
            if(val.errorCode == 0){
              Navigator.pop(context,true);
              widget.onBackPressed(null);
            }
          },
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }

  decodeMessage(String message){
    try{
      String trimMsg = message.replaceAll(" ", "");
      var splitMsg = trimMsg.split(',');
      String redirectUrl = '';
      for(int i = 0 ; i < splitMsg.length ; i++){
        if(splitMsg[i].length > 26){
          String s1 = splitMsg[i].substring(0,26);
          String s2 = splitMsg[i].substring(0,20);
          if(s1 == 'NSErrorFailingURLStringKey'){
            redirectUrl = splitMsg[i].substring(27,splitMsg[i].length);
          }
          if(s2 == 'NSErrorFailingURLKey'){
            redirectUrl = splitMsg[i].substring(21,splitMsg[i].length);
          }
        }
      }
      print(redirectUrl);
      if(redirectUrl != ''){
        print('success');
        Navigator.pop(context,true);
        widget.onWebViewCompleted(redirectUrl);
      }
    }catch(e){
      print(e.toString());
      Navigator.pop(context,true);
    }

  }
}
