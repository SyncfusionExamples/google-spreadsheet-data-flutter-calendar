# How to get the data from Google sheet and load it to the Flutter Calendar (SfCalendar)?

This example demonstrates how to get the data from Google sheet and load it to the Flutter Calendar.

Using Google AppScript, you can import data into the [Flutter Calendar](https://www.syncfusion.com/flutter-widgets/flutter-calendar) from a Google sheet and then load that data into the events.

## creating google spread sheet
Create a new google spreadsheet using this [link](https://www.google.com/sheets/about/) and then add the required data in the Google spreadsheet.

## Obtaining information from Appscript

Create the async method getDataFromGoogleSheet() and use the http.get() method to retrieve the data from the URL in the AppScript API connection

```
 Future<List<Meeting>> getDataFromGoogleSheet() async {
    Response data = await http.get(
      Uri.parse(
          "https://script.google.com/macros/s/AKfycbwG-W8x3ojt3-h5F-2IsmfdfTTdGo-bJiYF9gtBfC80KWNc7Qfv3DlApShRwYanHZia4A/exec"),
    );
    dynamic jsonAppData = convert.jsonDecode(data.body);
    final List<Meeting> appointmentData = [];
    final Random random = Random();
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

```

## Calendar data loading

Display the online data with the help of the FutureBuilder widget.

```
    child: FutureBuilder(
        future: getDataFromGoogleSheet(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.data != null) {
            return SafeArea(
                child: Container(
                child: SfCalendar(
                    view: CalendarView.month,
                    monthViewSettings: const MonthViewSettings(showAgenda: true),
                    dataSource: MeetingDataSource(snapshot.data),
                    initialDisplayDate: snapshot.data[0].from,
                ),
                ));
        } else {
            return Container(
            child: const Center(
                child: Text('Loading.....'),
            ),
            );
        }
        },
    ),

```

## Requirements to run the demo
* [VS Code](https://code.visualstudio.com/download)
* [Flutter SDK v1.22+](https://flutter.dev/docs/development/tools/sdk/overview)
* [For more development tools](https://flutter.dev/docs/development/tools/devtools/overview)

## How to run this application
To run this application, you need to first clone or download the ‘create a flutter maps widget in 10 minutes’ repository and open it in your preferred IDE. Then, build and run your project to view the output.

## Further help
For more help, check the [Syncfusion Flutter documentation](https://help.syncfusion.com/flutter/introduction/overview),
 [Flutter documentation](https://flutter.dev/docs/get-started/install).