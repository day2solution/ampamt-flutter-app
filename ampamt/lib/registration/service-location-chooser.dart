import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/docupload/business-document-upload.dart';
import 'package:ampamt/model/CityModel.dart';
import 'package:ampamt/model/StateModel.dart';
import 'package:ampamt/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ServiceLocationChooser extends StatefulWidget {

  ServiceLocationChooser({this.accountId}) : super();
  final String accountId;

  @override
  _ServiceLocationChooserState createState() => _ServiceLocationChooserState(accountId: accountId);
}

class _ServiceLocationChooserState extends State<ServiceLocationChooser> {
  _ServiceLocationChooserState({this.accountId});
  final String accountId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title: Row(
          children: [
            Image.asset('assets/images/home/business_login.png',
                width: 40, height: 40),
            Container(
                padding: const EdgeInsets.all(10.0),
                child: Text('Service Location Chooser'))
          ],
        ),
      ),
      body: ServiceLocationChooserForm(accountId: accountId,),
    );
  }
}

class ServiceLocationChooserForm extends StatefulWidget {

  ServiceLocationChooserForm({this.accountId});
  final String accountId;
  @override
  ServiceLocationChooserFormState createState() {
    return ServiceLocationChooserFormState(accountId:accountId );
  }
}

enum BestTutorSite { PANINDIA, MANUALSELECT }

class ServiceLocationChooserFormState
    extends State<ServiceLocationChooserForm> {
  ServiceLocationChooserFormState({this.accountId});
  final String accountId;
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  DateTime nowdate = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  BestTutorSite _site = BestTutorSite.PANINDIA;
  String selectedStateCode;
  final gender = TextEditingController();

  bool isPanIndiaSelected = true;
  bool showNextButton = true;
  bool isLoadingCity=false;
  bool isLoadingState=false;

  Future<List<StateModel>> stateModelFutureList;
  Future<List<CityModel>> cityModelFutureList;

  List<StateModel> stateModelList = [];
  List<CityModel> cityModellList = [];

  List<String> selectedStateList = [];
  List<String> selectedCitylList = [];

  bool isDataProcessed=false;
  //List<StateModel> selectedStateModelList = [];
  List<dynamic> selectedCityModellList = [];

  int totalSelectedState=0;
  int totalSelectedCity=0;

  @override
  void initState() {
    debugPrint('getting doctors list');
    super.initState();
    stateModelFutureList = getStateList(context);
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;

    // String locationGroup;
    return Center(
        child: ListView(children: <Widget>[
      ListTile(
        title: const Text('Pan India'),
        leading: Radio(
          value: BestTutorSite.PANINDIA,
          groupValue: _site,
          onChanged: (BestTutorSite value) {
            setState(() {
              _site = value;
              isPanIndiaSelected = true;
              showNextButton=true;

            });
          },
        ),
        onTap: () {
          setState(() {
            _site = BestTutorSite.PANINDIA;
            isPanIndiaSelected = true;
            showNextButton=true;
            selectedStateList=[];
            selectedCitylList=[];
            selectedStateCode=null;
            totalSelectedCity=0;
            totalSelectedState=0;
          });
        },
      ),
      Divider(
        color: CompanyStyle.primaryColor[1000],
      ),
      ListTile(
        title: const Text('Select Manualy'),
        leading: Radio(
          value: BestTutorSite.MANUALSELECT,
          groupValue: _site,
          onChanged: (BestTutorSite value) {
            setState(() {
              _site = value;
              isPanIndiaSelected = false;
              showNextButton=false;
            });
          },
        ),
        onTap: () {
          setState(() {
            _site = BestTutorSite.MANUALSELECT;
            isPanIndiaSelected = false;
            showNextButton=false;
          });
        },
      ),
      Divider(
        color: CompanyStyle.primaryColor[1000],
      ),
      !isPanIndiaSelected
          ? Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white54,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: FutureBuilder(
                        future: stateModelFutureList,
                        builder: (context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return showLoading('Loading State List...');
                          } else if (snapshot.hasError) {
                            print('error at haserror');
                            return Text('Error');
                          } else {
                            return buildStateList(snapshot.data);
                          }
                        }),
                  ),
                   SizedBox(
                    height: cityModellList.length>0?20.0:0,
                  ),
                  Container(
                    decoration:cityModellList.length>0? BoxDecoration(
                      border: Border.all(
                        color: Colors.white54,
                        width: 2
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ):null,
                    child: isLoadingCity?showLoading('Loading City List...'):buildCityList(cityModellList),
                  ),
                  SizedBox(
                    height: cityModellList.length>0?20.0:0,
                  ),
                  Container(
                    child:ElevatedButton(
                      style: CompanyStyle.getButtonStyle(),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(2),
                        child: Text(
                          'Add',
                          style:
                          TextStyle(fontSize: screenWidth / 25, letterSpacing: 2),
                        ),
                        width: double.infinity,
                      ),
                      onPressed: (){
                        addCityAndState();
                      },
                    ),
                  ),
                  CompanyStyle.getInputElementGap(),

                  Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child:Text('Total Selected State : '+totalSelectedState.toString()),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text('Total Selected City : '+totalSelectedCity.toString()),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            )
          : Text(''),
          // Container(
          //   padding: EdgeInsets.all(10.0),
          //   child:ElevatedButton(
          //     style: CompanyStyle.getButtonStyle(),
          //     child: Container(
          //       alignment: Alignment.center,
          //       decoration: const BoxDecoration(
          //         shape: BoxShape.circle,
          //       ),
          //       padding: EdgeInsets.all(2),
          //       child: Text(
          //         'Next',
          //         style:
          //         TextStyle(fontSize: screenWidth / 25, letterSpacing: 2),
          //       ),
          //       width: double.infinity,
          //     ),
          //     onPressed:showNextButton?(){
          //       submitDetails();
          //     }:null,
          //   ),
          // ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    !isPanIndiaSelected?Expanded(
                      flex: 1,
                      child:ElevatedButton(
                        style: CompanyStyle.getButtonStyle(),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(2),
                          child: Text(
                            'Reset',
                            style:
                            TextStyle(fontSize: screenWidth / 25, letterSpacing: 2),
                          ),
                          width: double.infinity,
                        ),
                        onPressed:showNextButton?(){
                          showResetDialog();
                        }:null,
                      ),
                    ):Text(''),
                    SizedBox(
                      width: !isPanIndiaSelected?10.0:0,
                    ),
                    Expanded(
                      flex: 1,
                      child: ElevatedButton(
                        style: CompanyStyle.getButtonStyle(),
                        child: Container(
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          padding: EdgeInsets.all(2),
                          child: Text(
                            'Next',
                            style:
                            TextStyle(fontSize: screenWidth / 25, letterSpacing: 2),
                          ),
                          width: double.infinity,
                        ),
                        onPressed:showNextButton?(){
                          submitDetails();
                        }:null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          CompanyStyle.getInputElementGap(),
    ]));
  }

  Widget showLoading(String msg) {
    return Container(
      padding: EdgeInsets.only(top: 15, bottom: 15),
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor:
                  AlwaysStoppedAnimation<Color>(CompanyStyle.primaryColor[900]),
            ),
            height: 1,
            width: screenWidth / 2,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            msg != null ? msg : 'Loading...',
            style: TextStyle(fontSize: screenWidth / 20),
          ),
        ],
      ),
    );
  }

  Widget buildStateList(List<StateModel> stateModelList) {
    return DropdownButtonFormField<StateModel>(
      itemHeight: 100,
      onSaved: (value) {
        debugPrint('values=$value');
      },
      validator: (value) => value == null ? 'Please select state' : null,
      style: TextStyle(
        fontSize: 20,
      ),
      dropdownColor: CompanyStyle.primaryColor,
      elevation: 9,

      // value: selected,
      items:
          stateModelList.map<DropdownMenuItem<StateModel>>((StateModel value) {
        return DropdownMenuItem<StateModel>(
          value: value,
          child: Text(value.stateName),
        );
      }).toList(),
      onChanged: (StateModel value) {
        debugPrint('StateModel=$value');
        debugPrint('stateCode=${value.stateCode}');
        debugPrint('stateName=${value.stateName}');
        setState(() => {
          selectedStateCode = value.stateCode,
          isLoadingCity=true
        });
        getCityList(context, value.stateCode);
      },

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.apartment, color: Colors.white),
        labelText: "Select State*",
        labelStyle: getInputFieldStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
      ),
    );
  }

  Widget buildCityList(List<CityModel> stateModelList) {
    return cityModellList.length>0? MultiSelectDialogField(

      unselectedColor: Colors.white54,
      checkColor: Colors.white,
      itemsTextStyle: TextStyle(color: Colors.white54),
      validator: (value) =>
          value == null ? 'Please select At Least One city' : null,
      selectedColor: CompanyStyle.primaryColor[300],
      selectedItemsTextStyle: TextStyle(color: Colors.white),
      searchHint: 'Select one or more',
      buttonText: Text('Select City *'),
      buttonIcon: Icon(Icons.arrow_drop_down),
      chipDisplay: MultiSelectChipDisplay(
        chipColor: CompanyStyle.primaryColor[300],
        scroll: true,
        scrollBar: HorizontalScrollBar(
          isAlwaysShown: true,
        ),
        textStyle: TextStyle(
          color: Colors.white,
        ),
      ),

      confirmText: Text('Select'),
      cancelText: Text('Cancel'),
      title: Text('Select Cities'),
      // closeSearchIcon: Icon(Icons.medical_services),
      backgroundColor: CompanyStyle.primaryColor,
      searchable: true,
      items: stateModelList.map((e) => MultiSelectItem(e, e.cityName)).toList(),
      listType: MultiSelectListType.LIST,
      onConfirm: (values) {
        debugPrint('values'+values.toString());
        selectedCityModellList=values;
        // selectedPracticing = values;
      },
    ):Text('',softWrap: true,);
  }

  static getInputFieldStyle() {
    return TextStyle(color: Colors.grey[350], fontSize: screenWidth / 25);
  }

  Future<List<StateModel>> getStateList(BuildContext context) async {
    ApiProvider _provider = new ApiProvider();

    try {
      final response = await _provider.post("/location/get-state-list", {});
      stateModelList =
          (response as List).map((data) => StateModel.fromJson(data)).toList();
      // items.addAll(DropdownMenuItem(ampamtTherapiesModelList));
    } catch (e) {
      print('error at getAdvertisementsList page=' + e.toString().toString());
      normalSnackBar(e.toString().toString(), Colors.red, Colors.white);
      // _scaffoldKey.currentState.ScaffoldMessenger.showSnackBar(snackBar);
    }
    return stateModelList;
  }

  Future<List<CityModel>> getCityList(
      BuildContext context, String stateCode) async {
    ApiProvider _provider = new ApiProvider();
    Map<String, dynamic> locationForm = new Map<String, String>();
    locationForm = {
      'stateCode': stateCode,
    };
    try {
      final response =
          await _provider.post("/location/get-city-list", locationForm);
      cityModellList =
          (response as List).map((data) => CityModel.fromJson(data)).toList();
      setState(() => {cityModellList = cityModellList,isLoadingCity=false});
      // items.addAll(DropdownMenuItem(ampamtTherapiesModelList));
    } catch (e) {
      print('error at getAdvertisementsList page=' + e.toString().toString());
      normalSnackBar(e.toString().toString(), Colors.red, Colors.white);
      // _scaffoldKey.currentState.ScaffoldMessenger.showSnackBar(snackBar);
    }
    return cityModellList;
  }

  SnackBar normalSnackBar(String msg, Color bgcolor, Color txtColor) {
    return SnackBar(
        content: Text(
          msg,
          style: TextStyle(color: txtColor),
        ),
        backgroundColor: bgcolor);
  }

  addCityAndState() {
    CityModel cityModel;
    if(selectedStateCode!=null){


    for(int i=0;i<selectedCityModellList.length;i++){
      cityModel = selectedCityModellList[i];
      debugPrint("cityName="+cityModel.cityCode);
      if(!selectedCitylList.contains(cityModel.cityCode)){
        selectedCitylList.add(cityModel.cityCode.trim());
      }
    }
      if(!selectedStateList.contains(selectedStateCode)){
        selectedStateList.add(selectedStateCode);

      }
    setState(() {
      totalSelectedCity=selectedCitylList.length;
      totalSelectedState=selectedStateList.length;
      if(totalSelectedState>0 && totalSelectedCity>0){
        showNextButton=true;
      }else{
        showNextButton=false;
      }
    });
    }
    debugPrint("selectedStateList="+selectedStateList.toString());
    debugPrint("selectedCitylList="+selectedCitylList.toString());
  }

  void submitDetails() async{
    Map<String, dynamic> documentReqBody = new Map<String, String>();
    ApiProvider _provider = new ApiProvider();
    debugPrint("submitting isPanIndiaSelected= $isPanIndiaSelected");
    documentReqBody['id']=accountId;
    if(isPanIndiaSelected){
      documentReqBody['serviceStates']=CommonConstant.ALL_STATES;
      documentReqBody['serviceCities']=CommonConstant.ALL_CITIES;
    }else{
      documentReqBody['serviceStates']=selectedStateList.join(",");
      documentReqBody['serviceCities']=selectedCitylList.join(",");
    }
    
    SuccessModel successModel;
    try {
      final response = await _provider.post("/account/update-business-acc-details", documentReqBody);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // Scaffold.of(context).hideCurrentSnackBar();
      successModel = SuccessModel.fromJson(response);

      if (successModel != null) {
        if (successModel.status == CommonConstant.STATUS_SUCCESS) {

          showSnackBar(context, 'Service Location added Successfully', Colors.green, Colors.white);

          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context)=>BusinessDocumentUpload(accountId: accountId,)));
        } else if (successModel.status == CommonConstant.STATUS_FAILED) {
          showSnackBar(
              context, 'Failed To Service Location, please try again.', Colors.red, Colors.white);
        } else {
          showSnackBar(
              context, 'Something went wrong please try again.', Colors.red, Colors.white);
        }
      }else{
        showSnackBar(
            context, 'Something went wrong please try again.', Colors.red, Colors.white);
      }
    } catch (e) {
      setState(() {
        isDataProcessed = false;
      });
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }



  }

  void resetDetails() {
    debugPrint("reseting");

    setState(() {
      selectedStateList=[];
      selectedCitylList=[];
      selectedCityModellList=[];
      //selectedStateModelList=[];
      selectedStateCode=null;
      totalSelectedCity=0;
      totalSelectedState=0;
      if(totalSelectedState>0 && totalSelectedCity>0){
        showNextButton=true;
      }else{
        showNextButton=false;
      }
    });

  }

  showResetDialog() async{
    await showDialog(
        context: context,
        builder: (context) => new AlertDialog(
      backgroundColor: CompanyStyle.primaryColor,
      title: new Text('Are you sure you want to reset selection?'),
      content: new Text('Your changes may be lost!'),
      actions: <Widget>[
        new TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: new Text('No',style: TextStyle(color: Colors.green),),
        ),
        new TextButton(
          onPressed: () => {
            resetDetails(),
            Navigator.of(context).pop(false),
          },
          child: new Text('Yes',style: TextStyle(color: Colors.red),),
        ),
      ],
    ),
    );
  }
}
showSnackBar(BuildContext context,String msg,Color bgcolor,Color txtColor) {
  WidgetsBinding.instance.addPostFrameCallback((_) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            msg,
            style: TextStyle(color: txtColor),
          ),
          backgroundColor: bgcolor,
        )
    );
  });

}
