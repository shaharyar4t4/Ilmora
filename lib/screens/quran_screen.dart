import 'package:flutter/material.dart';
import 'package:ilmora/constant/constants.dart';
import 'package:ilmora/model/surah.dart';
import 'package:ilmora/services/api_services.dart';
import 'package:ilmora/widget/surah_custom_title.dart';

class QuranScreen extends StatefulWidget {
  const QuranScreen({super.key});

  @override
  State<QuranScreen> createState() => _QuranScreenState();
}

class _QuranScreenState extends State<QuranScreen> {
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Constants.kPrimary,
          title: Text("Quran", style: TextStyle(color: Colors.white),),
          centerTitle: true,
          bottom: TabBar(
            
            tabs: [
              Text(
                "Surah",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              Text(
                "Sajda",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              Text(
                "Jaz",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          
          children: <Widget>[
            FutureBuilder(
              future: apiServices.getSurah(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Surah>> snapshot) {
                    if(snapshot.hasData){
                      List<Surah>? surah = snapshot.data; 
                      return ListView.builder(
                        itemCount: surah!.length,
                        itemBuilder: (context, index) => SurahCustomListTitle(
                          context: context,
                          ontap: () {},
                          surah: surah[index],
                        ),
                      );
                    }return Center(child: CircularProgressIndicator());
                  } 
            ),
            Center(child: Text(" It's a rainy here")),
            Center(child: Text("It's sunny here")),
          ],
        ),
      ),
    );
  }
}
