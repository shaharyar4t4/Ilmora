import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:ilmora/model/aya_of_the_day.dart';
import 'package:ilmora/services/api_services.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  ApiServices _apiServices = ApiServices();
  AyaOfTheDay? data;


  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    HijriCalendar.setLocal('ar');

    var _hijri = HijriCalendar.now();
    var day = DateTime.now();
    var format = DateFormat('EEE, d MMM yyyy');
    var formatted = format.format(day);

    _apiServices.getAyaOfTheDay().then((value) => data = value);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: _size.height * 0.22,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/background_img.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formatted,
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                
                    RichText(
                      text: TextSpan(
                        children: <InlineSpan>[
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                _hijri.hDay.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                _hijri.longMonthName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                '${_hijri.hYear} AH',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(child: SingleChildScrollView(
              padding: EdgeInsetsDirectional.only(top: 10, bottom: 20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),

                    ),
                    child: Column(
                      children: [
                        Text("Quran Aya of the Day",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 0.5,
                        ),
                        Text(data!.arText!,
                        style: TextStyle(color: Colors.black54),
                        ),
                        Text(data!.enTran!,
                        style: TextStyle(color: Colors.black54),
                        ),
                        RichText(text: TextSpan(
                          children: <InlineSpan>[
                            //15:11
                          ]
                        ))
                      ],
                    )
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
