import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;

void main() {
  return runApp(GoogleSheetData());
}

class GoogleSheetData extends StatefulWidget {
  @override
  LoadDataFromGoogleSheetState createState() => LoadDataFromGoogleSheetState();
}

class LoadDataFromGoogleSheetState extends State<GoogleSheetData> {
  MeetingDataSource? events;
  List<Color> _colorCollection = <Color>[];

  @override
  void initState() {
    _initializeEventColor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: SafeArea(
              child: Container(
        child: FutureBuilder(
          future: getDataFromGoogleSheet(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data != null) {
              return SafeArea(
                  child: Container(
                child: SfCalendar(
                  view: CalendarView.month,
                  monthViewSettings: MonthViewSettings(showAgenda: true),
                  dataSource: MeetingDataSource(snapshot.data),
                  initialDisplayDate: snapshot.data[0].from,
                ),
              ));
            } else {
              return Container(
                child: Center(
                  child: Text('Loading.....'),
                ),
              );
            }
          },
        ),
      ))),
    );
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }

  Future<List<Meeting>> getDataFromGoogleSheet() async {
    Response data = await http.get(
      Uri.parse(
          "https://script.google.com/macros/s/AKfycbwG-W8x3ojt3-h5F-2IsmfdfTTdGo-bJiYF9gtBfC80KWNc7Qfv3DlApShRwYanHZia4A/exec"),
    );
    dynamic jsonAppData = convert.jsonDecode(data.body);
    final List<Meeting> appointmentData = [];
    final Random random = new Random();
    for (dynamic data in jsonAppData) {
      Meeting meetingData = Meeting(
        eventName: data['subject'],
        from: _convertDateFromString(data['starttime']),
        to: _convertDateFromString(data['endtime']),
        background: _colorCollection[random.nextInt(9)],
      );
      appointmentData.add(meetingData);
    }
    return appointmentData;
  }

  DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }
}

class Meeting {
  Meeting(
      {this.eventName = '',
      required this.from,
      required this.to,
      this.background,
      this.isAllDay = false});

  String? eventName;
  DateTime? from;
  DateTime? to;
  Color? background;
  bool? isAllDay;
}
