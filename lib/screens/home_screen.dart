// import 'package:flutter/material.dart';
// import 'package:hijri/hijri_calendar.dart';
// import 'package:ilmora/model/aya_of_the_day.dart';
// import 'package:ilmora/services/api_services.dart';
// import 'package:intl/intl.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   ApiServices _apiServices = ApiServices();

//   void setData() async{
//     final prefs= await SharedPreferences.getInstance();
//     prefs.setBool("alreadyUsed", true);
//   }

//   @override
//   Widget build(BuildContext context) {
//     var _size = MediaQuery.of(context).size;
//     HijriCalendar.setLocal('ar');

//     var _hijri = HijriCalendar.now();
//     var day = DateTime.now();
//     var format = DateFormat('EEE, d MMM yyyy');
//     var formatted = format.format(day);

//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             Container(
//               height: _size.height * 0.22,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage("assets/image/background_img.jpg"),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 15.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       formatted,
//                       style: TextStyle(color: Colors.white, fontSize: 30),
//                     ),

//                     RichText(
//                       text: TextSpan(
//                         children: <InlineSpan>[
//                           WidgetSpan(
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Text(
//                                 _hijri.hDay.toString(),
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           WidgetSpan(
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Text(
//                                 _hijri.longMonthName,
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 20.0,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           WidgetSpan(
//                             child: Padding(
//                               padding: const EdgeInsets.all(4.0),
//                               child: Text(
//                                 '${_hijri.hYear} AH',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 16.0,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsetsDirectional.only(top: 10, bottom: 20),
//                 child: Column(
//                   children: [
//                     FutureBuilder<AyaOfTheDay>(
//                       future: _apiServices.getAyaOfTheDay(),
//                       builder: (context, snapshot) {
//                         switch (snapshot.connectionState) {
//                           case ConnectionState.none:
//                             return Icon(Icons.sync_problem);
//                           case ConnectionState.waiting:
//                           case ConnectionState.active:
//                             return CircularProgressIndicator();
//                           case ConnectionState.done:
//                             return Container(
//                               margin: EdgeInsetsDirectional.all(16),
//                               padding: EdgeInsetsDirectional.all(20),
//                               decoration: BoxDecoration(
//                                 color: Colors.white,
//                                 borderRadius: BorderRadius.circular(15),
//                                 boxShadow: [
//                                   BoxShadow(
//                                     blurRadius: 1,
                                   
//                                     offset: Offset(0, 0.1),
//                                   ),
//                                 ],
//                               ),
//                               child: Column(
//                                 children: [
//                                   Text(
//                                     "Quran Aya of the Day",
//                                     style: TextStyle(
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   Divider(color: Colors.black, thickness: 0.5),
//                                   Text(
//                                     snapshot.data!.arText!,
//                                     style: TextStyle(
//                                       color: Colors.black54,
//                                       fontSize: 18,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
                                  
//                                   const SizedBox(height: 10,),
//                                   Text(
//                                     snapshot.data!.enTran!,
//                                     style: TextStyle(
//                                       color: Colors.black54,
//                                       fontSize: 18,
//                                     ),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                   RichText(
//                                     text: TextSpan(
//                                       children: <InlineSpan>[
//                                         WidgetSpan(
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(
//                                               snapshot.data!.surNumber!
//                                                   .toString(),
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                           ),
//                                         ),
//                                         WidgetSpan(
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Text(
//                                               snapshot.data!.surEnName!
//                                                   .toString(),
//                                               style: TextStyle(fontSize: 16),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:ilmora/constant/constants.dart';
import 'package:ilmora/model/aya_of_the_day.dart';
import 'package:ilmora/services/api_services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'qiblah_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiServices _apiServices = ApiServices();

  void setData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool("alreadyUsed", true);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    HijriCalendar.setLocal('ar');

    final hijri = HijriCalendar.now();
    final day = DateTime.now();
    final format = DateFormat('EEE, d MMM yyyy');
    final formatted = format.format(day);

    return SafeArea(
      child: Scaffold(
        drawer: _buildDrawer(context),
        body: Column(
          children: [
            Container(
              height: size.height * 0.22,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/background_img.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// ☰ MENU
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                    ),

                    const Spacer(),

                    Text(
                      formatted,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),

                    Row(
                      children: [
                        Text(
                          hijri.hDay.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 18),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          hijri.longMonthName,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          '${hijri.hYear} AH',
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder<AyaOfTheDay>(
                  future: _apiServices.getAyaOfTheDay(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Padding(
                        padding: EdgeInsets.all(40),
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    return Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(blurRadius: 2, offset: Offset(0, 1)),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            "Quran Aya of the Day",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const Divider(),
                          Text(
                            snapshot.data!.arText!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            snapshot.data!.enTran!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${snapshot.data!.surEnName} • ${snapshot.data!.surNumber}",
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// DRAWER
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Constants.kPrimary),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Ilmora",
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
            ),
          ),

          ListTile(
            leading: const Icon(Icons.explore, color: Constants.kPrimary,),
            title: const Text("Qiblah Compass"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const QiblahScreen(),
                ),
              );
            },
          ),

          const Divider(),

          ListTile(
            leading: const Icon(Icons.close),
            title: const Text("Close"),
            onTap: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }
}
