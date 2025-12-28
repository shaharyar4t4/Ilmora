import 'package:flutter/material.dart';
import 'package:ilmora/constant/constants.dart';
import 'package:ilmora/model/juz.dart';
import 'package:ilmora/services/api_services.dart';
import 'package:ilmora/widget/juz_custom_title.dart';

class JuzScreen extends StatelessWidget {

   static const String id = 'juz_screen';

   ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: FutureBuilder(future: apiServices.getJuzz(Constants.juzIndex!), builder: (context, AsyncSnapshot<JuzModel>snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(),);
        }else if(snapshot.hasData){
          print('${snapshot.data!.juzAyahs.length} length');
          return ListView.builder(
            itemCount: snapshot.data!.juzAyahs.length,
            itemBuilder: (context, index){
              return JuzCustomTitle(list: snapshot.data!.juzAyahs, index: index);
            });
        }else{
          return Center(child: Text('Error loading data'));
        }
      }),
    ));
  }
}