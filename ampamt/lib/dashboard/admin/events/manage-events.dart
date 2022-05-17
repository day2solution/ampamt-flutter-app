import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/dashboard/admin/view-user-details.dart';
import 'package:ampamt/model/event/event-model.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ManageEvents extends StatefulWidget {
  final String accountId;
  ManageEvents({this.accountId}) : super();
  @override
  _ManageEventsState createState() => _ManageEventsState(accountId: accountId);
}

class _ManageEventsState extends State<ManageEvents> {
  final String accountId;
  _ManageEventsState({this.accountId}) : super();
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  // static double screenHeight;
  Future<List<EventModel>> eventModelFutureList;

  List<EventModel> eventModelList = [];
int totalEvents=0;
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
    // screenHeight = _mediaQueryData.size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title: Row(
          children: [
            Image.asset('assets/images/dashboard/app/41.png', width: 40, height: 40),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Manage Event',
                  style: TextStyle(fontSize: screenWidth / 20),
                ))
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              color: CompanyStyle.primaryColor[200],
              padding: EdgeInsets.all(5.0),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('Event List',  style: TextStyle(fontSize: screenWidth/20,fontWeight: FontWeight.bold),),
                            SizedBox(width: 20,),
                            InputChip(
                              tooltip: 'Total Events',
                              disabledColor: Colors.white,
                              label: Text(totalEvents.toString(),style: TextStyle(fontSize: screenWidth/30,color: Colors.black,fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      ElevatedButton(
                        style: CompanyStyle.getButtonStyle(),
                        child:Text(
                          'Refresh',
                          style:
                          TextStyle(fontSize: screenWidth / 25),
                        ),
                        onPressed: (){
                          setState(() {
                            eventModelFutureList=getEventList();
                          });

                        },
                      ),

                    ],
                  ),
                ],
              ),
            ),
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

    try {
      final response = await _provider.post("/event/get-event-list", eventMap);
      eventModelList = (response as List).map((data) => EventModel.fromJson(data)).toList();
      setState(() {
        totalEvents=eventModelList.length;
      });
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
            CommonUtil.getImageFromBase64OriginalSize(eventModel.eventImgBase64,context),
            Container(
              padding:EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment:MainAxisAlignment.start ,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(CommonUtil.convertToTitleCase(eventModel.eventTitle),style: TextStyle(fontSize: 20,fontWeight:FontWeight.bold ),),
                  SizedBox(height: 10,),
                  Text(eventModel.eventDescription),
                  SizedBox(height: 15,),
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
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      Expanded(
                        child:Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                            Text('Uploaded By : '),
                            SizedBox(height: 5,),
                          TextButton(onPressed: () {
                            showAccountDetails(eventModel.accountId);
                          },
                            child: Text(eventModel.accountId,style: TextStyle(color: Colors.blue,),),
                          ),

                            ]
                        )
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          TextButton(
                            onPressed: (){
                              _onWillPop(eventModel);
                            }, child: Icon(Icons.delete_forever,color: Colors.red,), ),
                          ]
                      ),
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
  Future<bool> _onWillPop(EventModel eventModel) async {
    return (await showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        backgroundColor: CompanyStyle.primaryColor,
        title: new Text('Are you sure?'),
        content: new Text('Do you want to delete ${eventModel.eventTitle.toUpperCase()} ?'),
        actions: <Widget>[
          new TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: new Text('No',style: TextStyle(color: Colors.green)),
          ),
          new TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
              deleteEvent(eventModel);
            },
            child: new Text('Yes',style: TextStyle(color: Colors.red),),
          ),
        ],
      ),
    )) ??
        false;
  }

  void deleteEvent(EventModel eventModel) async{
    Map<String, dynamic> deleteForm = new Map<String, String>();
    deleteForm={
      'eventId':eventModel.eventId,
      'eventTitle':eventModel.eventTitle,
      'createDate':eventModel.createDate,
      'accountId':eventModel.accountId,
      'eventState':eventModel.eventState,
      'eventCity':eventModel.eventCity,
      'eventDescription':eventModel.eventDescription,
      'eventImgBase64':eventModel.eventImgBase64,
      'activeFlag':eventModel.activeFlag,
      'eventImg':eventModel.eventImg,
    };
    debugPrint('event deleteForm='+deleteForm.toString());
    ApiProvider _provider = new ApiProvider();
    showProgressIndicator("Processing...");
    SuccessModel responseModel;
    try {
      final response = await _provider.post("/event/delete-event", deleteForm);
      responseModel = SuccessModel.fromJson(response);

      dismissProgressIndicator();
      if (responseModel != null) {
        if (responseModel.status == CommonConstant.STATUS_SUCCESS) {
          showSuccessIndicator("Success");
          setState(() {
            eventModelFutureList=getEventList();
          });

        } else if (responseModel.status == CommonConstant.STATUS_FAILED) {
          showSnackBar(context, 'Failed to delete event, please try again.', Colors.red, Colors.white);
        } else {
          showSnackBar(context, 'Something went wrong please try again.', Colors.red, Colors.white);
        }
      }else{
        showSnackBar(context, 'Something went wrong please try again.', Colors.red, Colors.white);
      }
    } catch (e) {
      dismissProgressIndicator();
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }
  }

  showProgressIndicator(String msg){
    EasyLoading.show(status: msg);
  }
  showSuccessIndicator(String msg){
    EasyLoading.showSuccess(msg,duration: Duration(milliseconds: 700));
  }
  dismissProgressIndicator(){
    EasyLoading.dismiss(animation: true);
  }

  showSnackBar(BuildContext context, String msg, Color bgcolor, Color txtColor) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(

        content: Text(
          msg,
          style: TextStyle(color: txtColor),
        ),
        backgroundColor: bgcolor,
      ));
    });
  }

  void showAccountDetails(String accountId) {
    print('display account details for $accountId');
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewUserDetails(accountId: accountId,)));
  }
}
