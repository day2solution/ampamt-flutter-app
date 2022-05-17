import 'dart:async';
import 'dart:convert';

import 'package:ampamt/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ApplyRampTnc extends StatefulWidget{
  @override
  _ApplyRampTncState createState()=>_ApplyRampTncState();

}
class _ApplyRampTncState extends State<ApplyRampTnc>{
  String kNavigationExamplePage = '''
<!DOCTYPE html><html>
<head>
<style>
* {
  color: #fff;
}
body{
    background-color: #5C0202;
}
.content {
  display: flex;
  margin: 10px auto;
  padding: 0 8px;
  font-size: 14px;
  flex-direction: column;
  
}
</style>
<title>Terms & Conditions</title>
</head>
<body>
 <div style="text-align: center !important;" >
    <img width="80%" src="https://amci-india.org/sites/upload_files/npi/AMCI2.jpg" style="border-radius: 5px;">
  </div>
  <div class="content">
    <p>
      AMCI is a body incorporated for safeguarding, boosting and certifying the alternate medicine practice and
      medicines treatment PAN INDIA as well as GLOBALLY. The medicinal practice and treatment and medicines under AMCI
      is restricted to the field and sub-fields of Yoga, Siddha, Naturopathy, Unani, Homeopathy, Ayurveda and all other
      alternate medicinal facilities but does not include allopathic treatment, practice and medicines in whatsoever
      ways.

      AMCI council members are basically globally reputed alternate medical practitioners hailing from India and other
      nations who have gathered to protect and safeguard the essence and existence of alternate medicines.
      Alternate Medical Doctors Law Volume I - Alternate Medical Council of India (Rules, Regulations, Notifications,
      Circulars, Acts and Laws from British era and as enacted by the Government of India till today
      Alternate Medical Doctors Law Volume II - Alternate Medical Council of India (Judgements passed by the Hon’ble
      Supreme Court of India and various Hon’ble High Courts across India).

    </p>
    
  <h4>For more details visit:&nbsp; 
     <span style="color:#00a2ff;"> www.amci-india.org</span>
  </h4>

  </div>
  
</body>
</html>
''';

  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller =
    Completer<WebViewController>();
    return Scaffold(

      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title:  Row(
          children: [
            Image.asset('assets/images/icon.png',width: 40,height: 40),
            Container(
                padding: const EdgeInsets.all(10.0), child: Text('Terms & Conditions'))
          ],
        ),
      ),
      body: Container(
          color: CompanyStyle.primaryColor,
          //  padding: EdgeInsets.all(5.0),
          child: Column(
            children:  <Widget>[
              Expanded(
                child:WebView(
                  initialUrl: 'https://ampamt.com/#/terms-conditions',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {
                    // _controller.complete(webViewController);
                    final String contentBase64 = base64Encode(const Utf8Encoder().convert(kNavigationExamplePage));
                    webViewController.loadUrl('data:text/html;base64,$contentBase64');

                  },
                  onProgress: (int progress) {
                    print("WebView is loading (progress : $progress%)");
                  },
                  javascriptChannels: <JavascriptChannel>{
                    _toasterJavascriptChannel(context),
                  },
                  navigationDelegate: (NavigationRequest request) {
                    if (request.url.startsWith('https://www.ampamt.com/')) {
                      print('blocking navigation to $request}');
                      return NavigationDecision.prevent;
                    }
                    print('allowing navigation to $request');
                    return NavigationDecision.navigate;
                  },
                  onPageStarted: (String url) {
                    print('Page started loading: $url');
                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');
                    Text("Hi");
                  },
                  gestureNavigationEnabled: true,
                ) ,
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                alignment: Alignment.center,
                child:ElevatedButton(
                  style: CompanyStyle.getButtonStyle(),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(2),
                    child: Text('I ACCEPT',),
                    width: double.infinity,
                  ),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ),
            ],
          )
      ),
    );
  }
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}