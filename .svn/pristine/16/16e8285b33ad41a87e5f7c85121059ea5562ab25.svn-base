import 'package:ampamt/ApiProvider.dart';
import 'package:ampamt/CommonConstant.dart';
import 'package:ampamt/SuccessModel.dart';
import 'package:ampamt/model/ampamt-therapies-model.dart';
import 'package:ampamt/model/doctor/DoctorsAccountDetailsModel.dart';
import 'package:ampamt/other/apply-ramp-tnc.dart';
import 'package:ampamt/other/terms-and-conditions.dart';
import 'package:ampamt/style.dart';
import 'package:ampamt/util/common-util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

enum SingingCharacter { lafayette, jefferson }
class EditDoctorAccDetails extends StatefulWidget{

  EditDoctorAccDetails({this.accountId,this.doctorsAccDtlModel}) : super();
  final String accountId;
  final Future<List<DoctorsAccountDetailsModel>> doctorsAccDtlModel;

  @override
  _EditDoctorAccDetailsState createState()=>_EditDoctorAccDetailsState(accountId: accountId,doctorsAccDtlModel: doctorsAccDtlModel);

}
class _EditDoctorAccDetailsState extends State<EditDoctorAccDetails>{
  _EditDoctorAccDetailsState({this.accountId,this.doctorsAccDtlModel}) : super();
  final String accountId;
  final Future<List<DoctorsAccountDetailsModel>> doctorsAccDtlModel;
  @override
  Widget build(BuildContext context) {
    // _mediaQueryData = MediaQuery.of(context);
    // screenWidth = _mediaQueryData.size.width;
    // screenHeight = _mediaQueryData.size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CompanyStyle.primaryColor,
        title:  Row(
          children: [
            Image.asset('assets/images/home/doctor_login.png',width: 40,height: 40),
            Container(
                padding: const EdgeInsets.all(10.0), child: Text('Edit Account'))
          ],

        ),
      ),
      body:RegistrationForm(accountId: accountId,doctorsAccDtlModel: doctorsAccDtlModel,),
    );
  }

}
class RegistrationForm extends StatefulWidget {
  RegistrationForm({this.accountId,this.doctorsAccDtlModel}) : super();
  final String accountId;
  final Future<List<DoctorsAccountDetailsModel>> doctorsAccDtlModel;
  @override
  RegistrationFormState createState() {
    return RegistrationFormState(accountId: accountId,doctorsAccDtlModel: doctorsAccDtlModel);
  }
}

class RegistrationFormState extends State<RegistrationForm> {
  RegistrationFormState({this.accountId,this.doctorsAccDtlModel}) : super();
  final String accountId;
  final Future<List<DoctorsAccountDetailsModel>> doctorsAccDtlModel;
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  DateTime nowdate = DateTime.now();
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  String dobStr="";
  bool isDataProcessed=false;
  // static double screenHeight;
  final List<String> bloodGroupItems = ["O+", "O-", "A+","A-","B+","B-","AB+","AB-"];
  final List<String> maritalStatusItems = ["Single", "Married", "Divorce","Widow"];
  final List<String> practicingAsItems = ["Doctor", "Practitioner", "Therapist","Assistant","Internship","Scholarship","Thesis","Organic Farmer","Scientist","Promoter"];
  final _formKey = GlobalKey<FormState>();
  final nameTitle = TextEditingController();
  final firstName = TextEditingController();
  final middleName = TextEditingController();
  final lastName = TextEditingController();
  final gender = TextEditingController();
  final dob = TextEditingController();
  final bloodGroup = TextEditingController();
  final maritalStatus = TextEditingController();
  final practicingAs = TextEditingController();
  final practicing = TextEditingController();
  final username = TextEditingController();
  final state = TextEditingController();
  final city = TextEditingController();
  final nationality = TextEditingController();
  final religion = TextEditingController();
  final father = TextEditingController();
  final mother = TextEditingController();
  final wifeHusbandName = TextEditingController();
  final companyName = TextEditingController();
  final companyTitle = TextEditingController();
  final experiencEstablishment = TextEditingController();
  final registOfficeAdd = TextEditingController();
  final permanentAddress = TextEditingController();
  final contactNo = TextEditingController();
  final otherContactNo = TextEditingController();
  final whatsappNo = TextEditingController();
  final emergencyNo = TextEditingController();
  final emailId = TextEditingController();
  final aadharNo = TextEditingController();
  final panNo = TextEditingController();
  final passportNo = TextEditingController();
  final password = TextEditingController();
  final conPassword = TextEditingController();
  final tncAcceptedFlag = TextEditingController();
  final haveRamp = TextEditingController();
  final applyRampFlag = TextEditingController();
  final reference = TextEditingController();
  final country = TextEditingController();
  final zipCode = TextEditingController();
  int _groupValue = 1;
  String txtnameTitle;
  String txtGender;
  String txtBloodGroup;
  String txtMaritalStatus;
  String txtPracticingAs;
  String txtCompanyTitle;
  List<String> practicingList=[];

  bool isTncChecked=true;
  bool isApplyRampChecked=false;
  bool isSubmitClicked=false;
  int minYear=1951;
  int maxYear=new DateTime.now().year-17;

  int selYear=new DateTime.now().year-17;
  int selMonth=12;
  int selDay=30;

  getDate() async{

    await DatePicker.showDatePicker(context,
      showTitleActions: true,
      minTime: DateTime(minYear, 1, 1),
      maxTime: DateTime(maxYear, 12, 30),
      onChanged: (date) {
        debugPrint('change $date');
        nowdate=date;
      },
      onConfirm: (date) {
        debugPrint('confirm $date');
        nowdate=date;
        setState(() {
          nowdate = date;
          dob.text=dateFormat.format(nowdate);
        });

      },
      currentTime: DateTime(selYear, selMonth, selDay, 0, 0), locale: LocaleType.en,
      theme: DatePickerTheme(
          backgroundColor: CompanyStyle.primaryColor,
          headerColor:CompanyStyle.primaryColor,
          cancelStyle:TextStyle(
              color: Colors.white,
              fontSize: 20
          ),
          doneStyle: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
          itemStyle: TextStyle(
              color: Colors.white,
              fontSize: 20
          )
      ),
    );
  }
  // SingingCharacter _character = SingingCharacter.lafayette;
  Future<List<AmpamtTherapiesModel>>  ampamtTherapiesModelFutureList;
  List<AmpamtTherapiesModel> ampamtTherapiesModelList=[];
  List<AmpamtTherapiesModel> selectedAmpamtThpyMdlList=[];
  List<AmpamtTherapiesModel> selectedAmpamtTherapiesModel=[];
  List<dynamic> selectedPracticing=[];
  DoctorsAccountDetailsModel doctorsAccountDetailsModel;
  List<String> _selectedFinalPracticing=[];
  // final _scaffoldKey = GlobalKey<ScaffoldState>();
  // List<int> selectedItems = [];

  @override
  void initState() {
    debugPrint('getting doctors list');
    debugPrint('maxYear= $maxYear minYear=$minYear');
    super.initState();
    ampamtTherapiesModelFutureList= getTherapiesList(context);
    doctorsAccDtlModel.then((value) => getReadyAccDetails(value));

  }

  void getReadyAccDetails(List<DoctorsAccountDetailsModel> doctorsAccountDetailsModelList){
    debugPrint("completed");
    setState(() {
      doctorsAccountDetailsModel=doctorsAccountDetailsModelList[0];

      txtnameTitle=doctorsAccountDetailsModel.nameTitle;
      firstName.text=doctorsAccountDetailsModel.firstName;
      middleName.text=doctorsAccountDetailsModel.middleName;
      lastName.text=doctorsAccountDetailsModel.lastName;
      lastName.text=doctorsAccountDetailsModel.lastName;

      if(doctorsAccountDetailsModel.gender=='M'){
        txtGender='Male';
      }
      if(doctorsAccountDetailsModel.gender=='F'){
        txtGender='Female';
      }
      if(doctorsAccountDetailsModel.gender=='T'){
        txtGender='Transgender';
      }

      txtBloodGroup=doctorsAccountDetailsModel.bloodGroup;
      debugPrint("txtBloodGroup=$txtBloodGroup");
      txtMaritalStatus=CommonUtil.convertToTitleCase(doctorsAccountDetailsModel.maritalStatus);
      debugPrint("maritalStatus=$txtMaritalStatus");
      txtPracticingAs=CommonUtil.convertToTitleCase(doctorsAccountDetailsModel.practicingAs);
      debugPrint("txtPracticingAs=$txtPracticingAs");

      debugPrint("practicingList=$practicingList");
      ampamtTherapiesModelFutureList.then((value) => {
        selectedAmpamtTherapiesModel=getPracticingList(value,doctorsAccountDetailsModel.practicing.split(",")),
        selectedPracticing=selectedAmpamtTherapiesModel,
      });

      country.text=doctorsAccountDetailsModel.country;
      state.text=doctorsAccountDetailsModel.state;
      city.text=doctorsAccountDetailsModel.city;
      zipCode.text=doctorsAccountDetailsModel.zipCode;
      nationality.text=doctorsAccountDetailsModel.nationality;
      religion.text=doctorsAccountDetailsModel.religion;
      father.text=doctorsAccountDetailsModel.fatherName;
      mother.text=doctorsAccountDetailsModel.motherName;
      wifeHusbandName.text=doctorsAccountDetailsModel.wifeHusbandName;
      txtCompanyTitle=doctorsAccountDetailsModel.companyTitle;
      companyName.text=doctorsAccountDetailsModel.companyName;

      experiencEstablishment.text=doctorsAccountDetailsModel.experiencEstablishment;
      registOfficeAdd.text=doctorsAccountDetailsModel.registOfficeAdd;
      permanentAddress.text=doctorsAccountDetailsModel.permanentAddress;
      contactNo.text=doctorsAccountDetailsModel.contactNo;
      otherContactNo.text=doctorsAccountDetailsModel.otherContactNo;
      whatsappNo.text=doctorsAccountDetailsModel.whatsappNo;
      emergencyNo.text=doctorsAccountDetailsModel.emergencyNo;
      emailId.text=doctorsAccountDetailsModel.emailId;
      aadharNo.text=doctorsAccountDetailsModel.aadharNo;
      panNo.text=doctorsAccountDetailsModel.panNo;
      passportNo.text=doctorsAccountDetailsModel.passportNo;
      reference.text=doctorsAccountDetailsModel.reference;
      if(doctorsAccountDetailsModel.tncAccepted==CommonConstant.FLAG_Y){
        isTncChecked=true;
      }else{
        isTncChecked=false;
      }
      if(doctorsAccountDetailsModel.haveRamp==CommonConstant.FLAG_Y){
        isApplyRampChecked=true;
      }
      else{
        isApplyRampChecked=false;
      }

      debugPrint("dob.text original=${doctorsAccountDetailsModel.dob}");
      DateTime dobDateTime=CommonUtil.stringToDate(doctorsAccountDetailsModel.dob);
      selYear=dobDateTime.year;
      selMonth=dobDateTime.month;
      selDay=dobDateTime.day;
      dob.text=CommonUtil.getYYYYMMDDStringDate(doctorsAccountDetailsModel.dob);
      debugPrint("dob.text=${dob.text}");
    });

  }

  List<AmpamtTherapiesModel> getPracticingList(List<AmpamtTherapiesModel> ampamtTherapiesModelList,List<String> selectedPracticing){
    AmpamtTherapiesModel ampamtTherapiesModel;
    for(int i=0;i<selectedPracticing.length;i++){
      for(int j=0;j<ampamtTherapiesModelList.length;j++){
        ampamtTherapiesModel=ampamtTherapiesModelList[j];
        debugPrint('comparing =${selectedPracticing[i]} and ${ampamtTherapiesModel.therapyName}');
        if(CommonUtil.isEqualBothString(ampamtTherapiesModel.therapyName,selectedPracticing[i])){
          ampamtTherapiesModel=ampamtTherapiesModelList[j];
          debugPrint('therapyId=${ampamtTherapiesModel.therapyId}');
          debugPrint('activeFlag=${ampamtTherapiesModel.activeFlag}');
          debugPrint('therapyName=${ampamtTherapiesModel.therapyName}');

          selectedAmpamtTherapiesModel.add(ampamtTherapiesModel);
          break;
        }else{
          debugPrint('not found>>=${selectedPracticing[i]}');
        }
      }

    }
  return selectedAmpamtTherapiesModel;

  }
  @override
  Widget build(BuildContext context) {

    // Build a Form widget using the _formKey created above.
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    Map<String, dynamic> docRegForm = new Map<String, String>();
    // screenHeight = _mediaQueryData.size.height;
    // String selected;
    // String selectedNameTitle;
    // String nameTit="";
    // void getDropDownItem(){
    //
    //
    // }
    return Center(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(10.0),

        children: <Widget>[
          Container(
            child:Container(
              child:Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    DropdownButtonFormField<String>(
                      onSaved: (value) {
                        nameTitle.text = value;
                      },
                      value: txtnameTitle,
                      validator: (value)=>value==null?'Please select your name title':null,
                      dropdownColor: CompanyStyle.primaryColor,
                      elevation :9,
                      style: TextStyle(
                        fontSize: 20,

                      ),
                      // value: selectedNameTitle,
                      items: ["Dr.", "Mr.", "Mrs.","Master","Miss"]
                          .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      )).toList(),
                      onChanged: (String value) {
                        debugPrint('state changed $value');
                        // setState(() => selectedNameTitle = value);
                        // debugPrint('state selectedNameTitle= $selectedNameTitle');
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,color: Colors.white),
                        labelText: "Select Title *",
                        labelStyle: getInputFieldStyle(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),

                    ),
                    CompanyStyle.getInputElementGap(),
                    TextFormField(

                      controller: firstName,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter first name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,color: Colors.white),
                        labelText: "First Name *",
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
                      controller: middleName,

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,color: Colors.white),
                        labelText: "Middle Name",
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
                      controller: lastName,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter last name(surename)';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,color: Colors.white),
                        labelText: "Last Name (Surname) *",
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
                      value: txtGender,
                      onSaved: (value) {
                        gender.text = "";
                        if(value=='Male'){
                          gender.text='M';
                        }
                        if(value=='Female'){
                          gender.text='F';
                        }
                        if(value=='Transgender'){
                          gender.text='T';
                        }
                      },
                      validator: (value)=>value==null?'Please select your gender':null,
                      style: TextStyle(
                        fontSize: 20,

                      ),
                      dropdownColor: CompanyStyle.primaryColor,
                      elevation :9,

                      // value: selected,
                      items: ["Male", "Female", "Transgender"]
                          .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      )).toList(),
                      onChanged: (value) {
                        setState(() => {

                        });
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.supervisor_account_sharp,color: Colors.white),
                        labelText: "Please Select Gender *",
                        labelStyle: getInputFieldStyle(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),
                    ),
                    CompanyStyle.getInputElementGap(),
                    TextFormField(
                      controller: dob,
                      validator: (value) {
                        debugPrint('DOB='+value);
                        if (value.isEmpty) {
                          return 'Please select your date of birth';
                        }
                        return null;
                      },
                      cursorColor: CompanyStyle.primaryColor[400],
                      readOnly: true,
                      onTap: () {
                        setState(() {
                          getDate();
                        });
                      },
                      decoration: InputDecoration(
                        labelStyle: getInputFieldStyle(),
                        prefixIcon: Icon(Icons.calendar_today_rounded,color: Colors.white),
                        labelText: 'Select Date Of Birth *',
                        hintText: dateFormat.format(nowdate),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),
                    ),
                    CompanyStyle.getInputElementGap(),
                    DropdownButtonFormField<String>(
                      value: txtBloodGroup,
                      onSaved: (value) {
                        bloodGroup.text = value;
                      },
                      selectedItemBuilder: (context) {
                        return bloodGroupItems.map<Widget>((String item) {
                          return Text(item);
                        }).toList();
                      },
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      validator: (value)=>value==null?'Please select your blood group':null,
                      dropdownColor: CompanyStyle.primaryColor,
                      elevation :9,

                      // value: selected,
                      items: bloodGroupItems
                          .map((label) => DropdownMenuItem(

                        child: Text(label),
                        value: label,

                      )).toList(),
                      onChanged: (value) {
                        // setState(() => selected = value);
                      },

                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.local_hospital,color: Colors.white),
                        labelText: "Blood group *",
                        labelStyle: getInputFieldStyle(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),

                    ),
                    CompanyStyle.getInputElementGap(),

                    DropdownButtonFormField<String>(
                      value: txtMaritalStatus,
                      onSaved: (value) {
                        maritalStatus.text = value;
                      },
                      selectedItemBuilder: (context) {
                        return maritalStatusItems.map<Widget>((String item) {
                          return Text(item);
                        }).toList();
                      },
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      validator: (value)=>value==null?'Please select your marital status':null,
                      dropdownColor: CompanyStyle.primaryColor,
                      elevation :9,
                      // value: selected,
                      items: maritalStatusItems.map((label) => DropdownMenuItem(
                        child: Text(label,style:TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        )),
                        value: label,
                      )).toList(),
                      onChanged: (value) {
                        // setState(() => selected = value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.supervisor_account_sharp,color: Colors.white),
                        labelText: "Marital Status *",
                        labelStyle: getInputFieldStyle(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
                      ),

                    ),
                    CompanyStyle.getInputElementGap(),

                    DropdownButtonFormField<String>(
                      value: txtPracticingAs,
                      onSaved: (value) {
                        practicingAs.text = value;
                      },
                      selectedItemBuilder: (context) {
                        return practicingAsItems.map<Widget>((String item) {
                          return Text(item);
                        }).toList();
                      },
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      validator: (value)=>value==null?'Please select practicing as':null,
                      dropdownColor: CompanyStyle.primaryColor,
                      elevation :9,
                      // value: selected,
                      items: practicingAsItems.map((label) => DropdownMenuItem(
                        child: Text(label,style:TextStyle(
                            color: Colors.white,
                            fontSize: 20
                        )),
                        value: label,
                      )).toList(),
                      onChanged: (value) {
                        // setState(() => selected = value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.supervisor_account_sharp,color: Colors.white),
                        labelText: "Practicing As *",
                        labelStyle: getInputFieldStyle(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.white, width: 0.5),
                        ),
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
                      child: FutureBuilder(
                          future: ampamtTherapiesModelFutureList,
                          builder: (context,AsyncSnapshot snapshot){
                            if(snapshot.data==null){
                              return showLoading();
                            }else if(snapshot.hasError){
                              print('error at haserror');
                              return Text('Error');
                            }
                            else{
                              return buildTherapyField(snapshot.data);
                            }
                          }
                      ),

                    ),
                    CompanyStyle.getInputElementGap(),

                    TextFormField(
                      enableSuggestions: true,

                      controller: country,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter country name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.map,color: Colors.white),
                        labelText: "Country *",
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
                      controller: state,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter state name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.apartment,color: Colors.white),
                        labelText: "State Name *",
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
                      controller: city,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter city name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.home_work,color: Colors.white),
                        labelText: "City Name *",
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
                        prefixIcon: Icon(Icons.pin_drop,color: Colors.white),
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
                      controller: nationality,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your nationality';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.map,color: Colors.white),
                        labelText: "Nationality *",
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
                      controller: religion,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter your religion';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.home_work_sharp,color: Colors.white),
                        labelText: "Religion *",
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
                      controller: father,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter father name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,color: Colors.white),
                        labelText: "Father Full Name *",
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
                      controller: mother,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter mother name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,color: Colors.white),
                        labelText: "Mother Full Name *",
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
                      controller: wifeHusbandName,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.people_alt_rounded,color: Colors.white),
                        labelText: "Wife/Husband Full Name",
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
                      value: txtCompanyTitle,
                      onSaved: (value) {
                        companyTitle.text = value;
                      },
                      validator: (value)=>value==null?'Please select your company title':null,
                      dropdownColor: CompanyStyle.primaryColor,
                      elevation :9,
                      style: TextStyle(
                        fontSize: 20,

                      ),
                      // value: selected,
                      items: ["Proprietor", "Partnership", "LLP","Pvt. Ltd.","Pvt.","Ltd."]
                          .map((label) => DropdownMenuItem(
                        child: Text(label),
                        value: label,
                      )).toList(),
                      onChanged: (value) {
                        // setState(() => selected = value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.title,color: Colors.white),
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
                          return 'Please enter your company name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.map,color: Colors.white),
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

                    TextFormField(
                      maxLength: 5,
                      controller: experiencEstablishment,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter company experience/establishment (year.month)';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.map,color: Colors.white),
                        labelText: "Experience/Establishment (year.month) *",
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
                          return 'Please enter clinic address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.map,color: Colors.white),
                        labelText: "Clinic Address *",
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
                      controller: permanentAddress,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter residence/permanent address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.map,color: Colors.white),
                        labelText: "Residence/Permanent Address *",
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
                        prefixIcon: Icon(Icons.call,color: Colors.white),
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
                        prefixIcon: Icon(Icons.call,color: Colors.white),
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
                        if (value.toString().length<10 || !CommonUtil.isNumericOnly(value.toString())) {
                          return 'Please enter valid contact number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.call,color: Colors.white),
                        labelText: "Whatsaap Number *",
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
                      controller: emergencyNo,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter emergency Number';
                        }
                        if (value.toString().length<10 || !CommonUtil.isNumericOnly(value.toString())) {
                          return 'Please enter valid contact number';
                        }
                        if(contactNo.text!=null && contactNo.text.trim()==value){
                          return 'Mobile & emergency contact no. should be different';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.call,color: Colors.white),
                        labelText: "Emergency Number *",
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
                        if(!CommonUtil.isValidEmail(value)){
                          return 'Please enter valid email-Id';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.mail,color: Colors.white),
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
                        prefixIcon: Icon(Icons.person,color: Colors.white),
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
                        prefixIcon: Icon(Icons.person,color: Colors.white),
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
                      controller: passportNo,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,color: Colors.white),
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
                      controller: reference,
                      enabled: false,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person,color: Colors.white),
                        labelText: "Reference (Unique Account ID)",
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
                    CheckboxListTile(
                      value: isTncChecked,
                      onChanged:isTncChecked?null: (val) {
                        if(val){
                          tncAcceptedFlag.text="Y";
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsAndConditions()));
                        }else{
                          tncAcceptedFlag.text="N";
                        }
                        setState(() => isTncChecked = val);
                      },
                      subtitle: (!isTncChecked && isSubmitClicked) ? Text('Please Accept T&C.', style: TextStyle(color: Colors.red),) : null,
                      title: Text('I Accept Terms & Conditions *', style: TextStyle(fontSize: 14.0,color: Colors.blue),),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.green,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text('Do you have RAMP?', style: TextStyle(fontSize: 18)),
                          Container(
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: RadioListTile(

                                        value: 0,
                                        groupValue: _groupValue,
                                        title: Text("Yes"),
                                        onChanged: (newValue) =>

                                            setState(() =>
                                            _groupValue = newValue,

                                            ),

                                        selected: false,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: RadioListTile(

                                        value: 1,
                                        groupValue: _groupValue,
                                        title: Text("No"),
                                        onChanged: (newValue) =>
                                            setState(() => _groupValue = newValue),

                                        selected: false,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // CheckboxListTileFormField(
                    //   // autovalidate: true,
                    //   title: Text('Apply For RAMP'),
                    //   onSaved: (bool value) {
                    //     if(value){
                    //       applyRampFlag.text="Y";
                    //     }else{
                    //       applyRampFlag.text="N";
                    //     }
                    //   },
                    //
                    // ),
                    CheckboxListTile(
                      value: isApplyRampChecked,
                      onChanged: (val) {
                        if(val){
                          applyRampFlag.text="Y";
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ApplyRampTnc()));
                        }else{
                          applyRampFlag.text="N";
                        }
                        setState(() => isApplyRampChecked = val);
                      },

                      title: new Text('Apply for RAMP *', style: TextStyle(fontSize: 14.0,color: Colors.blue),),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: Colors.green,
                    ),
                    // CompanyStyle.getInputElementGap(),
                    ElevatedButton(
                      style: CompanyStyle.getButtonStyle(),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(2),
                        child: Text('Update Details', style: TextStyle(fontSize: screenWidth/25,letterSpacing: 2),),
                        width: double.infinity,
                      ),
                      onPressed: isDataProcessed?null:() {
                        setState(() {
                          isSubmitClicked=true;
                        });

                        _formKey.currentState.save();
                        debugPrint('_groupValue=$_groupValue');
                        _selectedFinalPracticing.clear();
                        for(int i=0;i<selectedPracticing.length;i++){
                          _selectedFinalPracticing.add(selectedPracticing[i].therapyName);

                        }
                        debugPrint('_selectedFinalPracticing='+_selectedFinalPracticing.toString());

                        docRegForm={
                          'id':accountId,
                          'nameTitle':nameTitle.text,
                          'firstName':firstName.text,
                          'middleName':middleName.text,
                          'lastName':lastName.text,
                          'gender':gender.text,
                          'dob':dob.text,
                          'bloodGroup':bloodGroup.text,
                          'maritalStatus':maritalStatus.text,
                          'practicingAs':practicingAs.text,
                          'practicing':_selectedFinalPracticing.join(","),
                          'state':state.text,
                          'city':city.text,
                          'nationality':nationality.text,
                          'religion':religion.text,
                          'father':father.text,
                          'mother':mother.text,
                          'wifeHusbandName':wifeHusbandName.text,
                          'companyName':companyName.text,
                          'companyTitle':companyTitle.text,
                          'experiencEstablishment':experiencEstablishment.text,
                          'registOfficeAdd':registOfficeAdd.text,
                          'permanentAddress':permanentAddress.text,
                          'contactNo':contactNo.text,
                          'otherContactNo':otherContactNo.text,
                          'whatsappNo':whatsappNo.text,
                          'emergencyNo':emergencyNo.text,
                          'emailId':emailId.text,
                          'aadharNo':aadharNo.text,
                          'panNo':panNo.text.toUpperCase(),
                          'passportNo':passportNo.text,

                          'haveRamp':_groupValue==0?"Y":"N",
                          'applyRampFlag':applyRampFlag.text,
                          'reference':reference.text,
                          'country':country.text,
                          'zipCode':zipCode.text,
                        };
                        // debugPrint(isTncChecked);
                        // debugPrint('docRegForm data toString='+docRegForm.toString());
                        debugPrint('debugdebugPrint docRegForm=$docRegForm');


                        if (_formKey.currentState.validate() && isTncChecked) {
                          // showSnackBar(context,'Processing Data Please Wait...',Colors.green,Colors.white);
                          // _formKey.currentState.reset();

                          debugPrint('form data='+_formKey.currentState.toString());
                          updateDocotrAccount(docRegForm);
                        }else{
                          debugPrint('please fill all the required details');
                          // Navigator.pop(context);
                          showSnackBar(context,'Please fill the required details marked as (*)',Colors.red,Colors.white);
                          // Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(accountId: "AC20200911115146819",)));

                        }
                      },
                    ),

                    // ),
                  ],
                ),
              ),
            ),

          ),
        ],
      ),
    );
  }
  Widget showLoading(){
    return Container(
      padding:EdgeInsets.only(top: 15,bottom: 15),
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            child: LinearProgressIndicator(
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(CompanyStyle.primaryColor[900]),
            ),
            height:1,
            width: screenWidth/ 2,
          ),
          SizedBox(height: 10,),
          Text('Loading Therapy List...',style: TextStyle(fontSize: screenWidth/20),),
        ],
      ),
    );
  }
  Widget buildTherapyField(List<AmpamtTherapiesModel> ampamtTherapiesModelList){
    return MultiSelectDialogField(
      initialValue: selectedAmpamtTherapiesModel,
      unselectedColor: Colors.white54,
      checkColor: Colors.white,
      itemsTextStyle: TextStyle(color: Colors.white54),
      validator: (value){
        // if(selectedPracticing==null || selectedPracticing.length<1){
        //   return 'Please select at least one practicing';
        // }
        if(value==null || value.isEmpty){
          return 'Please select at least one practicing';
        }
        return null;
      },
      selectedColor: CompanyStyle.primaryColor[300],
      selectedItemsTextStyle:TextStyle(
          color: Colors.white
      ) ,
      searchHint:'Select one or more',
      buttonText: Text('Practicing *'),
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
      title: Text('Select Therapy'),
      // closeSearchIcon: Icon(Icons.medical_services),
      backgroundColor: CompanyStyle.primaryColor,
      searchable: true,
      items: ampamtTherapiesModelList.map((e) => MultiSelectItem(e, e.therapyName)).toList(),
      listType: MultiSelectListType.LIST,
      onConfirm: (values) {
        debugPrint('values');
        selectedPracticing = values;
        // selectedAmpamtTherapiesModel=selectedPracticing;

      },
    );
  }
  Widget getTncModel(){
    return Container(
        child: Row(
          children: [
            ElevatedButton(
                style: CompanyStyle.getButtonStyleNoBorder(),
                child: Text('I Accept Terms & Conditions *',style: TextStyle(color: Colors.blue,),),
                onPressed: () {
                  debugPrint('opening model');
                  setState(() => isTncChecked=true);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>TermsAndConditions()));
                }
            )
          ],
        ));
  }
  static getInputLabelSize(){
    return screenWidth/25;
  }
  static getInputFieldStyle(){
    return TextStyle(
        color: Colors.grey[350],
        fontSize: screenWidth/25
    );
  }
  updateDocotrAccount(Map<String, dynamic> docRegForm) async{
    debugPrint('submit called=$docRegForm');
    ApiProvider _provider = new ApiProvider();
    setState(() {
      isDataProcessed = true;
    });
    showSnackBar(context, 'Processing Data Please Wait...', Colors.green, Colors.white);
    SuccessModel response2;
    try {
      final response = await _provider.post("/account/update-doctors-acc-details", docRegForm);
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
      if (response2.status == CommonConstant.STATUS_SUCCESS) {
        showSnackBar(context, 'Details Updated Successfully', Colors.green, Colors.white);
        _formKey.currentState.reset();
        Navigator.of(context).pop(true);
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>PaymentPage(accountId: response2.id,allDocUploaded: CommonConstant.FLAG_N,)));
      } else if (response2.status == CommonConstant.STATUS_FAILED) {
        showSnackBar(
            context, 'Failed To Update Details, please try again.', Colors.red, Colors.white);
      } else {
        showSnackBar(
            context, 'Something went wrong please try again.', Colors.red, Colors.white);
      }
    }else{
      showSnackBar(
          context, 'Something went wrong please try again.', Colors.red, Colors.white);
    }
  }

  Future<List<AmpamtTherapiesModel>> getTherapiesList(BuildContext context) async{
    ApiProvider _provider = new ApiProvider();
    try {
      final response = await _provider.post("/account/get-therapy-list",{});
      ampamtTherapiesModelList = (response as List).map((data) => AmpamtTherapiesModel.fromJson(data)).toList();
      // items.addAll(DropdownMenuItem(ampamtTherapiesModelList));
    } catch (e) {
      print('error at getAdvertisementsList page='+e.toString().toString());
      normalSnackBar(e.toString().toString(), Colors.red,  Colors.white);
      // _scaffoldKey.currentState.ScaffoldMessenger.showSnackBar(snackBar);
    }
    return ampamtTherapiesModelList;

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
  SnackBar normalSnackBar(String msg, Color bgcolor, Color txtColor){
    return SnackBar(
        content: Text(msg,
          style: TextStyle(color:txtColor),
        ),
        backgroundColor: bgcolor
    );
  }
}