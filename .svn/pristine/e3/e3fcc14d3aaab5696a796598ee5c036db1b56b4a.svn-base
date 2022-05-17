import 'package:ampamt/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ModelProgressIndicator extends StatefulWidget{
  final double screenWidth;
  final double screenHeight;
  ModelProgressIndicator({this.screenHeight,this.screenWidth});
  _ModelProgressIndicatorState createState() => _ModelProgressIndicatorState(
    screenWidth: this.screenWidth,
    screenHeight: this.screenHeight,

  );
}
class _ModelProgressIndicatorState extends State<ModelProgressIndicator>{
  final double screenWidth;
  final double screenHeight;
  _ModelProgressIndicatorState({this.screenWidth,this.screenHeight});

  initState() {
    super.initState();

  }
  Widget build(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new Container(

          child: new Stack(
            children: <Widget>[

              Container(
                alignment: AlignmentDirectional.center,
                decoration: new BoxDecoration(
                  color: Colors.white10,
                ),
                child:  Container(
                  decoration: new BoxDecoration(
                      color: CompanyStyle.primaryColor,
                      borderRadius: new BorderRadius.circular(10.0)
                  ),
                  width: screenWidth/2,
                  height: screenHeight/6,
                  alignment: AlignmentDirectional.center,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: new SizedBox(
                          width: screenWidth/10,
                          height: screenWidth/10,
                          child: new CircularProgressIndicator(
                            backgroundColor: CompanyStyle.primaryColor[400],
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            value: null,
                            strokeWidth:5,
                          ),
                        ),
                      ),

                      Container(
                        alignment: AlignmentDirectional.center,
                        margin: const EdgeInsets.only(top: 25.0),
                        child: new Center(
                          child: new Text(
                              "Uploading...\r\nPlease wait...",
                              style: TextStyle(decoration: TextDecoration.none, color: Colors.white,fontSize: screenWidth/30)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
        // return Dialog(
        //
        //   new Container(
        //     child: new Row(
        //
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         new CircularProgressIndicator(),
        //         new Text("Loading"),
        //       ],
        //     ) ,
        //   ),
        //
        // );
      },
    );
  }
}