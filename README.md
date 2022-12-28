# How to get the data from Google sheet and load it to the Flutter Calendar (SfCalendar)?

This example demonstrates how to get the data from Google sheet and load it to the Flutter Calendar.

Using Google AppScript, you can import data into the [Flutter Calendar](https://www.syncfusion.com/flutter-widgets/flutter-calendar) from a Google sheet and then load that data into the events.

## creating google spread sheet
Create a new google spreadsheet using this [link](https://www.google.com/sheets/about/) and then add the required data in the Google spreadsheet.

## Obtaining information from Appscript

Create the async method getDataFromGoogleSheet() and use the http.get() method to retrieve the data from the URL in the AppScript API connection

## Calendar data loading

Display the online data with the help of the FutureBuilder widget.

## Requirements to run the demo
* [VS Code](https://code.visualstudio.com/download)
* [Flutter SDK v1.22+](https://flutter.dev/docs/development/tools/sdk/overview)
* [For more development tools](https://flutter.dev/docs/development/tools/devtools/overview)

## How to run this application
To run this application, you need to first clone or download the ‘create a flutter maps widget in 10 minutes’ repository and open it in your preferred IDE. Then, build and run your project to view the output.

## Further help
For more help, check the [Syncfusion Flutter documentation](https://help.syncfusion.com/flutter/introduction/overview),
 [Flutter documentation](https://flutter.dev/docs/get-started/install).