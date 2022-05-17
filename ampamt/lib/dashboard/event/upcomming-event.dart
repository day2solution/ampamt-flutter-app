import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/dashboard/event/add-event.dart';
import 'package:ampamt/model/event/event-model.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpcommingEvent extends StatefulWidget {
  final String accountId;
  UpcommingEvent({this.accountId}) : super();
  @override
  _UpcommingEventState createState() => _UpcommingEventState(accountId: accountId);
}

class _UpcommingEventState extends State<UpcommingEvent> {
  final String accountId;
  _UpcommingEventState({this.accountId}) : super();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  Future<List<EventModel>> eventModelFutureList;

  List<EventModel> eventModelList = [];

  @override
  void initState() {
    debugPrint('getting event list');
    super.initState();
    debugPrint('accountId=$accountId');
    eventModelFutureList=getEventList();
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title: Row(
          children: [
            Image.asset('assets/images/dashboard/app/41.png', width: 40, height: 40),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Upcoming Event',
                  style: TextStyle(fontSize: screenWidth / 20),
                ))
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child:Container(
                padding:EdgeInsets.all(10),
                child:FutureBuilder(
                    future: eventModelFutureList,
                    builder: (context,AsyncSnapshot snapshot){
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return CommonUtil.showLoading("Loading events...",context);
                      }else if(snapshot.hasError){
                        print('error at haserror');
                        return Text('Error occurred');
                      }
                      else{
                        if(snapshot.data!=null && snapshot.data.length>0){
                          return ListView.builder(
                              itemCount:snapshot.data.length ,
                              itemBuilder: (context,int index){
                                return buildEventCards(snapshot.data[index]);
                              });
                        }else{
                          return CommonUtil.getEmptyMsg("Events not found", context);
                        }

                      }
                    }
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<EventModel>> getEventList() async {
    ApiProvider _provider = new ApiProvider();
    Map<String, dynamic> eventMap = new Map<String, String>();
    eventMap = {
      'accountId': accountId,
    };
    try {
      final response = await _provider.post("/event/get-nearest-event-list", eventMap);
      eventModelList = (response as List).map((data) => EventModel.fromJson(data)).toList();
    } catch (e) {
      print('error at getAdvertisementsList page=' + e.toString().toString());
      normalSnackBar(e.toString().toString(), Colors.red, Colors.white);
    }
    return eventModelList;
  }
  SnackBar normalSnackBar(String msg, Color bgcolor, Color txtColor) {
    return SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: txtColor),
        ),
        backgroundColor: bgcolor);
  }

  Widget buildEventCards(EventModel eventModel) {
    return Container(

      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(
              color: CompanyStyle.primaryColor[1003].withOpacity(0.2),
              width: 2,
            )
        ),
        color: CompanyStyle.primaryColor,
        child: Column(

          children: [
            CommonUtil.getImageFromBase64CustSize(eventModel.eventImgBase64, screenWidth,screenHeight/5),
            Container(
              padding:EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.start ,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(CommonUtil.convertToTitleCase(eventModel.eventTitle),style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold ),),
                  SizedBox(height: 10,),
                  Text(eventModel.eventDescription),
                  SizedBox(height: 5,),
                  Container(
                    child: Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(width: 5,),
                        Text(CommonUtil.getDDMMMYYYYStringDate(eventModel.eventDate))
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Text('State : '+CommonUtil.convertToTitleCase(eventModel.eventState)),
                      SizedBox(width: 10,),
                      Text('City : '+CommonUtil.convertToTitleCase(eventModel.eventCity)+","),
                    ],
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }

}