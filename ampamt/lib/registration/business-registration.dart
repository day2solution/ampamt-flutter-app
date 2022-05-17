import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/model/AmpamtServiceModel.dart';
import 'package:ampamt/model/CityModel.dart';
import 'package:ampamt/model/StateModel.dart';
import 'package:ampamt/other/terms-and-conditions.dart';
import 'package:ampamt/registration/service-location-chooser.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class BusinessRegistration extends StatefulWidget {
  @override
  _BusinessRegistrationPageState createState() =>
      _BusinessRegistrationPageState();
}

class _BusinessRegistrationPageState extends State<BusinessRegistration> {
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
                child: Text('Business Registration'))
          ],
        ),
      ),
      body: BusinessRegistrationForm(),
    );
  }
}

class BusinessRegistrationForm extends StatefulWidget {
  @override
  BusinessRegistrationFormState createState() {
    return BusinessRegistrationFormState();
  }
}

class BusinessRegistrationFormState extends State<BusinessRegistrationForm> {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  DateTime nowdate = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");

  final _formKey = GlobalKey<FormState>();
  final companyTitle = TextEditingController();
  final companyName = TextEditingController();
  final ownerNameTitle = TextEditingController();
  final companyOwnerName = TextEditingController();
  final ownerGender = TextEditingController();
  final representativeNameTitle = TextEditingController();
  final representativeName = TextEditingController();
  final representativeGender = TextEditingController();
  final ownerNationality = TextEditingController();
  final ownerReligion = TextEditingController();
  final ownerDetail = TextEditingController();


  final sector = TextEditingController();
  final experiencEstablishment = TextEditingController();
  final registOfficeAdd = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final zipCode = TextEditingController();


  final contactNo = TextEditingController();
  final otherContactNo = TextEditingController();
  final whatsappNo = TextEditingController();

  final emailId = TextEditingController();
  final companyEmailId = TextEditingController();
  final otherEmailId = TextEditingController();

  final passportNo = TextEditingController();
  final password = TextEditingController();
  final conPassword = TextEditingController();
  final aadharNo = TextEditingController();
  final panNo = TextEditingController();
  final tncAccepted = TextEditingController();
  final landmark = TextEditingController();
  final landlineNo = TextEditingController();

  bool _showPassword = false;
  bool _showConPassword = false;
  bool isTncChecked = false;
  bool isSubmitClicked = false;
  bool isDataProcessed = false;
  Future<List<StateModel>> stateModelFutureList;
  Future<List<CityModel>> cityModelFutureList;

  List<StateModel> stateModelList = [];
  List<CityModel> cityModellList = [];
  List<AmpamtServiceModel> ampamtServiceModelList = [];
  List<dynamic> selectedServiceList=[];
  List<String> finalSelectedServiceList=[];
  List< Map<String, String>> ampamtServiceMapList = [
    { 'id': 'SRV2', 'serviceName': 'B2B' },
    { 'id': 'SRV3', 'serviceName': 'LEGAL ADVISORS(LAWYERS)' },
    { 'id': 'SRV4', 'serviceName': 'GOVERNMENT UPDATES' },
    { 'id': 'SRV5', 'serviceName': 'GOVERNMENPPROVED LABS' },
    { 'id': 'SRV6', 'serviceName': 'INSTITUTE & UNIVERSITIES' },
    { 'id': 'SRV7', 'serviceName': 'ARCHITECTS' },
    { 'id': 'SRV8', 'serviceName': 'MANFORCE CONSULTANT' },
    { 'id': 'SRV9', 'serviceName': 'BRANDING & PACKAGING' },
    { 'id': 'SRV10', 'serviceName': 'CONTENT WRITER' },
    { 'id': 'SRV11', 'serviceName': 'ENTREPRENUR' },
    { 'id': 'SRV12', 'serviceName': 'WELLNESS CENTERS' },
    { 'id': 'SRV13', 'serviceName': 'EQUIPMENT SUPPLIERS' },
    { 'id': 'SRV14', 'serviceName': 'SERVICE PROVIDER' },
    { 'id': 'SRV15', 'serviceName': 'EXIBITIONS' },
    { 'id': 'SRV16', 'serviceName': 'HOTEL' },
    { 'id': 'SRV17', 'serviceName': 'TRANSPORT' },

    { 'id': 'SRV19', 'serviceName': 'B2C' },
    { 'id': 'SRV20', 'serviceName': 'CHARTERED ACCOUNTANT & COMPANY SECTARY' },
    { 'id': 'SRV21', 'serviceName': 'GOVT. SCHEMES/SUBSIDIES' },
    { 'id': 'SRV22', 'serviceName': 'RESEARCH & DEVELOPMENT' },
    { 'id': 'SRV23', 'serviceName': 'FINANCE & INVESTMENT' },
    { 'id': 'SRV24', 'serviceName': 'ENGINEERS' },
    { 'id': 'SRV25', 'serviceName': 'MANUFACTURS' },
    { 'id': 'SRV26', 'serviceName': 'DESIGNING' },
    { 'id': 'SRV27', 'serviceName': 'SALES & MARKETING' },
    { 'id': 'SRV28', 'serviceName': 'HUMAN RIGHTS' },
    { 'id': 'SRV29', 'serviceName': 'CLINIC' },
    { 'id': 'SRV30', 'serviceName': 'MACHINERIES' },
    { 'id': 'SRV31', 'serviceName': 'INSURANCE' },
    { 'id': 'SRV32', 'serviceName': 'EVENTS' },
    { 'id': 'SRV33', 'serviceName': 'RESTAURANT' },
    { 'id': 'SRV34', 'serviceName': 'GAUSHALA' },
    { 'id': 'SRV35', 'serviceName': 'BANK' },
    { 'id': 'SRV36', 'serviceName': 'BOOKS LAUNCH' },
    { 'id': 'SRV37', 'serviceName': 'TRADE LICENCES' },
    { 'id': 'SRV38', 'serviceName': 'COURT ORDER' },
    { 'id': 'SRV39', 'serviceName': 'MEDICAL COMPANIES' },
    { 'id': 'SRV40', 'serviceName': 'COACHING & TRAINING' },
    { 'id': 'SRV41', 'serviceName': 'FINANCIAL PLANNER' },
    { 'id': 'SRV42', 'serviceName': 'AGRICULTURE' },
    { 'id': 'SRV43', 'serviceName': 'PRINTING' },
    { 'id': 'SRV44', 'serviceName': 'PRO' },
    { 'id': 'SRV45', 'serviceName': 'ASTROLOGY' },
    { 'id': 'SRV46', 'serviceName': 'HOSPITALS' },
    { 'id': 'SRV47', 'serviceName': 'RAW MATERIAL SUPPLIERS' },
    { 'id': 'SRV48', 'serviceName': 'DISTRIBUTOR' },
    { 'id': 'SRV49', 'serviceName': 'SOCIAL PROMOTER' },
    { 'id': 'SRV50', 'serviceName': 'TOURISM' },
    { 'id': 'SRV51', 'serviceName': 'REAL ESTATE' },
    { 'id': 'SRV52', 'serviceName': 'TEMPLE' },
    { 'id': 'SRV53', 'serviceName': 'PRACTITIONERS' },
    { 'id': 'SRV54', 'serviceName': 'OTHER SERVICES' },

    { 'id': 'SRV1', 'serviceName': 'AMPAMT' },
    { 'id': 'SRV18', 'serviceName': 'AMCI' },
  ];

  List<dynamic> selectedCityModellList = [];
  bool isLoadingCity=false;
  String selectedStateCode;
  String selectedCityCode;
  // AmpamtServiceModel ampamtServiceModel=new AmpamtServiceModel();
  @override
  void initState() {
    debugPrint('getting doctors list');
    super.initState();
    ampamtServiceModelList=(ampamtServiceMapList).map((data) => AmpamtServiceModel.fromJson(data)).toList();
    stateModelFutureList = getStateList(context);
  }

  @override
  Widget build(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    Map<String, dynamic> businessRegForm = new Map<String, String>();
    return Center(
        child: ListView(
      shrinkWrap: true,
      padding: EdgeInsets.all(10.0),
      children: <Widget>[
        Container(
            child: Container(
                child: Form(
          key: _formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                  Widget>[
            DropdownButtonFormField<String>(
              onSaved: (value) {
                companyTitle.text = value;
              },
              validator: (value) =>
                  value == null ? 'Please select your company title' : null,
              dropdownColor: CompanyStyle.primaryColor,
              elevation: 9,
              style: TextStyle(
                fontSize: 20,
              ),
              // value: selectedNameTitle,
              items: ["Proprietor", "Partnership", "LLP", "Pvt. Ltd.", "Ltd."]
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (String value) {
                debugPrint('state changed $value');
                // setState(() => selectedNameTitle = value);
                // debugPrint('state selectedNameTitle= $selectedNameTitle');
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.title, color: Colors.white),
                labelText: "Company Title *",
                labelStyle: getInputFieldStyle(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              controller: companyName,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter company name';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.apartment, color: Colors.white),
                labelText: "Company Name *",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            DropdownButtonFormField<String>(
              onSaved: (value) {
                ownerNameTitle.text = value;
              },
              validator: (value) =>
                  value == null ? 'Please select company owner title' : null,
              dropdownColor: CompanyStyle.primaryColor,
              elevation: 9,
              style: TextStyle(
                fontSize: 20,
              ),
              // value: selectedNameTitle,
              items: ["Dr.", "Mr.", "Mrs.", "Master", "Miss"]
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (String value) {
                debugPrint('state changed $value');
                // setState(() => selectedNameTitle = value);
                // debugPrint('state selectedNameTitle= $selectedNameTitle');
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.title, color: Colors.white),
                labelText: "Company Owner Title *",
                labelStyle: getInputFieldStyle(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              controller: companyOwnerName,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter company owner name';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.white),
                labelText: "Company Owner Name *",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            DropdownButtonFormField<String>(
              onSaved: (value) {
                ownerGender.text = "";
                if (value == 'Male') {
                  ownerGender.text = 'M';
                }
                if (value == 'Female') {
                  ownerGender.text = 'F';
                }
                if (value == 'Transgender') {
                  ownerGender.text = 'T';
                }
              },
              validator: (value) =>
                  value == null ? 'Please select owner gender' : null,
              style: TextStyle(
                fontSize: 20,
              ),
              dropdownColor: CompanyStyle.primaryColor,
              elevation: 9,

              // value: selected,
              items: ["Male", "Female", "Transgender"]
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => {});
              },

              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.supervisor_account_sharp, color: Colors.white),
                labelText: "Please Select Owner Gender *",
                labelStyle: getInputFieldStyle(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
              ),
            ),
            CompanyStyle.getInputElementGap(),
            DropdownButtonFormField<String>(
              onSaved: (value) {
                representativeNameTitle.text = value;
              },
              validator: (value) =>
                  value == null ? 'Please select representative title' : null,
              dropdownColor: CompanyStyle.primaryColor,
              elevation: 9,
              style: TextStyle(
                fontSize: 20,
              ),
              // value: selectedNameTitle,
              items: ["Dr.", "Mr.", "Mrs.", "Master", "Miss"]
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (String value) {
                debugPrint('state changed $value');
                // setState(() => selectedNameTitle = value);
                // debugPrint('state selectedNameTitle= $selectedNameTitle');
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.title, color: Colors.white),
                labelText: "Representative Title *",
                labelStyle: getInputFieldStyle(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              controller: representativeName,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter representative full name';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.white),
                labelText: "Representative Full Name *",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            DropdownButtonFormField<String>(
              onSaved: (value) {
                representativeGender.text = "";
                if (value == 'Male') {
                  representativeGender.text = 'M';
                }
                if (value == 'Female') {
                  representativeGender.text = 'F';
                }
                if (value == 'Transgender') {
                  representativeGender.text = 'T';
                }
              },
              validator: (value) =>
                  value == null ? 'Please select representative gender' : null,
              style: TextStyle(
                fontSize: 20,
              ),
              dropdownColor: CompanyStyle.primaryColor,
              elevation: 9,

              // value: selected,
              items: ["Male", "Female", "Transgender"]
                  .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() => {});
              },

              decoration: InputDecoration(
                prefixIcon:
                    Icon(Icons.supervisor_account_sharp, color: Colors.white),
                labelText: "Please Select Representative Gender *",
                labelStyle: getInputFieldStyle(),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              controller: ownerNationality,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter owner nationality';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.map, color: Colors.white),
                labelText: "Owner Nationality*",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              controller: ownerReligion,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter owner religion';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.home_work_sharp, color: Colors.white),
                labelText: "Owner Religion*",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              controller: ownerDetail,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter details';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.details, color: Colors.white),
                labelText: "Business/Practicing/profession (consultant)*",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
      Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white54,
            ),
            borderRadius:  BorderRadius.all(Radius.circular(10.0)),
          ),
                child:MultiSelectDialogField(

                  unselectedColor: Colors.white54,
                  checkColor: Colors.white,
                  itemsTextStyle: TextStyle(color: Colors.white54),
                  validator: (value)=>value==null?'Please select at least one sector':null,
                  selectedColor: CompanyStyle.primaryColor[300],
                  selectedItemsTextStyle:TextStyle(
                      color: Colors.white
                  ) ,
                  searchHint:'Select one or more',
                  buttonText: Text('Sector *'),
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
                  title: Text('Select Sector'),
                  // closeSearchIcon: Icon(Icons.medical_services),
                  backgroundColor: CompanyStyle.primaryColor,
                  searchable: true,
                  items: ampamtServiceModelList.map((e) => MultiSelectItem(e, e.serviceName)).toList(),
                  listType: MultiSelectListType.LIST,
                  onConfirm: (values) {

                    debugPrint('selectedServiceList length=${selectedServiceList.length}');
                    debugPrint('values=$values');

                    debugPrint('values=${values.length}');
                    selectedServiceList=values;
                    debugPrint('values=$values');
                    debugPrint('selectedServiceList length=${selectedServiceList.length}');
                  },
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white54,
                        width: 1
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                )),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              controller: experiencEstablishment,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Experience/Establishment (year.month)';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.calendar_today_outlined, color: Colors.white),
                labelText: "Experience/Establishment (year.month)*",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              controller: registOfficeAdd,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Registered Office Address';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.apartment, color: Colors.white),
                labelText: "Registered Office Address*",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              controller: landmark,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter Nearby/Landmark';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.apartment, color: Colors.white),
                labelText: "Nearby/Landmark*",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
                CompanyStyle.getInputElementGap(),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white54,
                        width: 1
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
                CompanyStyle.getInputElementGap(),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.white54,
                        width: 1
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: isLoadingCity?showLoading('Loading City List...'):buildCityList(cityModellList),
                ),


            CompanyStyle.getInputElementGap(),
            TextFormField(
              maxLength: 6,
              keyboardType: TextInputType.number,
              controller: zipCode,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter pin code';
                }
                if (value.toString().length<6 || !CommonUtil.isNumericOnly(value.toString())) {
                  return 'Please enter valid pin code';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.pin_drop, color: Colors.white),
                labelText: "Pin Code *",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.number,
              controller: contactNo,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter mobile number (Username)';
                }
                if (value.toString().length<10 || !CommonUtil.isNumericOnly(value.toString())) {
                  return 'Please enter valid mobile number';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.call, color: Colors.white),
                labelText: "Mobile Number (Username) *",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.number,
              controller: landlineNo,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter landline number';
                }
                if (value.toString().length<8 || !CommonUtil.isNumericOnly(value.toString())) {
                  return 'Please enter valid landline number';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.call, color: Colors.white),
                labelText: "Landline Number *",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.number,
              controller: otherContactNo,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter other contact number';
                }
                if (value.toString().length<10 || !CommonUtil.isNumericOnly(value.toString())) {
                  return 'Please enter valid contact number';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.call, color: Colors.white),
                labelText: " Other Contact Detail *",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              maxLength: 10,
              keyboardType: TextInputType.number,
              controller: whatsappNo,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter whatsapp number';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.call, color: Colors.white),
                labelText: "Whatsapp Number *",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailId,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter email-Id (Username)';
                }
                if (!CommonUtil.isValidEmail(value)) {
                  return 'Please enter valid email-Id';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail, color: Colors.white),
                labelText: "Email-Id (Username) *",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: companyEmailId,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter company email-Id';
                }
                if (!CommonUtil.isValidEmail(value)) {
                  return 'Please enter valid email-Id';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.mail, color: Colors.white),
                labelText: "Company Email-Id *",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              textCapitalization: TextCapitalization.characters,
              maxLength: 10,
              controller: panNo,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter pan number';
                }
                if (value.toString().length<10 || !CommonUtil.isAlphaNumericOnly(value.toString())) {
                  return 'Please enter valid pan number';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.credit_card, color: Colors.white),
                labelText: "Pan Number *",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              maxLength: 12,

              keyboardType: TextInputType.number,
              controller: aadharNo,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter aadhar number';
                }
                if (value.toString().length<12 || !CommonUtil.isNumericOnly(value.toString())) {
                  return 'Please enter valid aadhar number';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.credit_card, color: Colors.white),
                labelText: "Aadhar Number *",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              controller: passportNo,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person, color: Colors.white),
                labelText: "Passport (Foreigner)",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              maxLength: 12,
              obscureText: !_showPassword,
              controller: password,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
                labelText: "Password *",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() => this._showPassword = !this._showPassword);
                  },
                ),
                alignLabelWithHint: true,
              ),
            ),
            CompanyStyle.getInputElementGap(),
            TextFormField(
              maxLength: 12,
              obscureText: !_showConPassword,
              controller: conPassword,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please confirm your password';
                }
                if (!CommonUtil.isEqualBothString(value, password.text)) {
                  return "Please ensure both password must be same";
                }
                return null;
              },
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.vpn_key, color: Colors.white),
                labelText: "Confirm Password *",
                labelStyle: getInputFieldStyle(),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.white, width: 0.5),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    // Based on passwordVisible state choose the icon
                    _showConPassword ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(
                        () => this._showConPassword = !this._showConPassword);
                  },
                ),
                alignLabelWithHint: true,
              ),
            ),
            CheckboxListTile(
              value: isTncChecked,
              onChanged: (val) {
                if (val) {
                  tncAccepted.text = "Y";
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TermsAndConditions()));
                } else {
                  tncAccepted.text = "N";
                }
                setState(() => isTncChecked = val);
              },
              subtitle: (!isTncChecked && isSubmitClicked)
                  ? Text(
                      'Please Accept T&C.',
                      style: TextStyle(color: Colors.red),
                    )
                  : null,
              title: new Text(
                'I Accept Terms & Conditions *',
                style: TextStyle(fontSize: 14.0, color: Colors.blue),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              activeColor: Colors.green,
            ),
            ElevatedButton(
              style: CompanyStyle.getButtonStyle(),
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(2),
                child: Text(
                  'Create Account & Next',
                  style:
                      TextStyle(fontSize: screenWidth / 25, letterSpacing: 2),
                ),
                width: double.infinity,
              ),
              onPressed: isDataProcessed
                  ? null
                  : () {
                      setState(() {
                        isSubmitClicked = true;
                      });
                      finalSelectedServiceList.clear();
                      _formKey.currentState.save();
                      for(int i=0;i<selectedServiceList.length;i++){
                        finalSelectedServiceList.add(selectedServiceList[i].serviceName);

                      }
                      debugPrint('finalSelectedServiceList='+finalSelectedServiceList.toString());

                      businessRegForm = {
                        'companyTitle':companyTitle.text,
                        'companyName':companyName.text,
                        'ownerNameTitle':ownerNameTitle.text,
                        'companyOwnerName':companyOwnerName.text,
                        'ownerGender': ownerGender.text,
                        'representativeNameTitle': representativeNameTitle.text,
                        'representativeName':representativeName.text,
                        'representativeGender':representativeGender.text,
                        'ownerNationality':ownerNationality.text,
                        'ownerReligion':ownerReligion.text,
                        'ownerDetail':ownerDetail.text,
                        'sector':finalSelectedServiceList.join(","),
                        'experiencEstablishment':experiencEstablishment.text,

                        'registOfficeAdd':registOfficeAdd.text,
                        'city':selectedCityCode,
                        'state':selectedStateCode,
                        'zipCode': zipCode.text,

                        'contactNo': contactNo.text,
                        'otherContactNo':otherContactNo.text,
                        'whatsappNo':whatsappNo.text,
                        'emailId':emailId.text,
                        'otherEmailId': otherEmailId.text,

                        'passportNo': passportNo.text,
                        'password': password.text,
                        'aadharNo': aadharNo.text,
                        'tncAccepted': tncAccepted.text=="Y"?true:false,
                        'panNo': panNo.text.toUpperCase(),
                        'landmark': landmark.text,
                        'landlineNo': landlineNo.text,

                      };
                      debugPrint('businessRegForm=$businessRegForm');

                      if (_formKey.currentState.validate() && isTncChecked) {
                        debugPrint('form data=' + _formKey.currentState.toString());
                         createBusinessAccount(businessRegForm);
                      } else {
                        debugPrint('please fill all the required details');
                        // Navigator.of(context).pop(true);
                        // Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceLocationChooser()));
                        showSnackBar(context,'Please fill the required details marked as (*)',Colors.red,Colors.white);
                      }
                    },
            ),
          ]),
        )))
      ],
    ));
  }

  static getInputFieldStyle() {
    return TextStyle(color: Colors.grey[350], fontSize: screenWidth / 25);
  }

  Widget buildStateList(List<StateModel> stateModelList) {
    return DropdownButtonFormField<StateModel>(
      itemHeight: 100,
      onSaved: (value) {
        debugPrint('values=$value');
      },
      validator: (value) => value == null ? 'Please select state' : null,
      style: TextStyle(
      ),
      dropdownColor: CompanyStyle.primaryColor,
      elevation: 9,
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
          selectedStateCode = value.stateName,
          isLoadingCity=true
        });
        getCityList(context, value.stateCode);
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.apartment, color: Colors.white),
        labelText: "Select State*",
        labelStyle: getInputFieldStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0),),
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
      ),
    );
  }

  Widget buildCityList(List<CityModel> stateModelList) {
    return  DropdownButtonFormField<CityModel>(
      itemHeight: 100,
      onSaved: (value) {
        debugPrint('values=$value');
      },
      validator: (value) => value == null ? 'Please select city' : null,
      style: TextStyle(

      ),
      dropdownColor: CompanyStyle.primaryColor,
      elevation: 9,
      // value: selected,
      items:
      stateModelList.map<DropdownMenuItem<CityModel>>((CityModel value) {
        return DropdownMenuItem<CityModel>(
          value: value,
          child: Text(value.cityName),
        );
      }).toList(),
      onChanged: (CityModel value) {

        debugPrint('cityCode=${value.cityCode}');
        debugPrint('cityName=${value.cityName}');
        setState(() => {
          selectedCityCode = value.cityName,
          // isLoadingCity=true
        });

      },

      decoration: InputDecoration(
        prefixIcon: Icon(Icons.apartment, color: Colors.white),
        labelText: "Select City*",
        labelStyle: getInputFieldStyle(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0),),
          borderSide: BorderSide(color: Colors.white, width: 0.5),
        ),
      ),
    );
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

  void createBusinessAccount(Map<String, dynamic> businessRegForm) async{
    debugPrint('createBusinessAccount called=$businessRegForm');
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isDataProcessed = true;
    });
    showSnackBar(context, 'Processing Data Please Wait...', Colors.green, Colors.white);
    SuccessModel response2;
    try {
      final response = await _provider.post("/account/create-business-account", businessRegForm);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      // Scaffold.of(context).hideCurrentSnackBar();
      response2 = SuccessModel.fromJson(response);
    } catch (e) {
      setState(() {
        isDataProcessed = false;
      });
      showSnackBar(context, e.toString().toString(), Colors.red, Colors.white);
    }
    setState(() {
      isDataProcessed = false;
    });
    if (response2 != null) {
      if(response2.accountExists!=null && response2.accountExists==CommonConstant.FLAG_Y){
        showSnackBar(context, 'Mobile No. or Email-ID already exists, please login', Colors.red, Colors.white);
      }
      else if (response2.status == CommonConstant.STATUS_SUCCESS) {
        // showSnackBar(context, 'Success', Colors.green, Colors.white);
        _formKey.currentState.reset();
        Navigator.of(context).pop(true);
        Navigator.push(context, MaterialPageRoute(builder: (context) => ServiceLocationChooser(accountId: response2.id,)));
      } else if (response2.status == CommonConstant.STATUS_FAILED) {
        showSnackBar(
            context, 'Failed To Create Account, please try again.', Colors.red, Colors.white);
      } else {
        showSnackBar(
            context, 'Something went wrong please try again.', Colors.red, Colors.white);
      }
    }else{
      showSnackBar(
          context, 'Something went wrong please try again.', Colors.red, Colors.white);
    }
  }
}
