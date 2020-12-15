import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:topper/my_drawer.dart';
import 'models/feature_model.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:intl/intl.dart' show DateFormat;

class TotalDays extends StatelessWidget {
  Widget cards(BuildContext context, FeatureModel object) {
    return Material(
      elevation: 8,
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: GridTile(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  object.imgPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  object.label,
                  maxLines: 2,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  var _currentDate = DateTime.now();
  String formatDate(DateTime date) => DateFormat("MMMM").format(date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(34),
        child: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Dashboard',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Name(place)',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/background3.png'), fit: BoxFit.fill)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height / 16,
                ),
                GridView.count(
                  crossAxisCount: 1,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 32,
                  childAspectRatio: 5,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 32),
                  children: <Widget>[
                    cards(context,
                        FeatureModel('images/average.png', 'Average-')),
                    cards(
                        context,
                        FeatureModel(
                            'images/totalAverage.png', 'Daily Average-')),
                    cards(context,
                        FeatureModel('images/totalHour.png', 'Total Hours-')),
                  ],
                ),
                Text(
                  'Calendar Details',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Theme.of(context).primaryColor,
                            Colors.transparent
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter),
                      borderRadius: BorderRadius.circular(16)),
                  margin: EdgeInsets.symmetric(horizontal: 32.0),
                  child: CalendarCarousel<Event>(
//                    onDayPressed: (DateTime date, List<Event> events) {
//                      this.setState(() => selectedDate = date);
//                      print(selectedDate);
//                      print(_currentDate.month.toString());
//                      Navigator.pushReplacement(context,
//                          MaterialPageRoute(builder: (_) {
//                        return BookPage2(
//                            setDate: selectedDate.day,
//                            setMonth: formatDate(selectedDate));
//                      }));
//                    },
                    dayPadding: 0,
                    weekDayPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                    weekDayMargin: EdgeInsets.only(bottom: 0),
                    childAspectRatio: 1.5,
                    showWeekDays: true,
                    headerText: formatDate(_currentDate),
                    headerTitleTouchable: true,
                    daysTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    weekendTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    weekdayTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      letterSpacing: -1,
                    ),
                    weekDayBackgroundColor: Colors.white,
                    firstDayOfWeek: 1,
                    dayButtonColor: Colors.white,
                    headerMargin: EdgeInsets.all(0),
                    selectedDayBorderColor: Colors.white,
                    markedDateIconMaxShown: 1,
                    markedDateShowIcon: true,
                    selectedDayButtonColor: Colors.white,
                    todayTextStyle: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    todayButtonColor: Colors.white,
                    todayBorderColor: Colors.white,
                    headerTextStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        backgroundColor: Theme.of(context).primaryColor),
                    customGridViewPhysics: NeverScrollableScrollPhysics(),
                    customDayBuilder: (
                      /// you can provide your own build function to make custom day containers
                      bool isSelectable,
                      int index,
                      bool isSelectedDay,
                      bool isToday,
                      bool isPrevMonthDay,
                      TextStyle textStyle,
                      bool isNextMonthDay,
                      bool isThisMonthDay,
                      DateTime day,
                    ) {
                      /// If you return null, [CalendarCarousel] will build container for current [day] with default function.
                      /// This way you can build custom containers for specific days only, leaving rest as default.

                      // Example: every 15th of month, we have a flight, we can place an icon in the container like that:
//          if (day.day == 15) {
//            return Center(
//              child: Icon(Icons.local_airport),
//            );
//          } else {
//            return null;
//          }

                      return null;
                    },
                    weekFormat: false,

//        markedDatesMap: _markedDateMap,
                    height: MediaQuery.of(context).size.width / 1.5,
//                    selectedDateTime: selectedDate,
                    iconColor: Colors.white,
                    daysHaveCircularBorder: false,

                    /// null for not rendering any border, true for circular border, false for rectangular border
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
