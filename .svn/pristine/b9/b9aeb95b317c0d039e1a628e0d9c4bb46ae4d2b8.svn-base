class EventModel{
  final String eventId;
  final String accountId;
  final String eventImg;
  final String eventTitle;
  final String eventDescription;
  final String eventState;
  final String eventCity;
  final String activeFlag;
  final String eventDate;
  final String createDate;
  final String eventImgBase64;

  EventModel(this.eventId, this.accountId, this.eventImg, this.eventTitle, this.eventDescription, this.eventState, this.eventCity, this.activeFlag, this.eventDate, this.createDate, this.eventImgBase64);
  factory EventModel.fromJson(Map<String, dynamic> data) {
    return EventModel(
      data['eventId'],
      data['accountId'],
      data['eventImg'],
      data['eventTitle'],
      data['eventDescription'],
      data['eventState'],
      data['eventCity'],
      data['activeFlag'],
      data['eventDate'],
      data['createDate'],
      data['eventImgBase64'],

    );
  }



}