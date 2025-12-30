import 'package:flutter/material.dart';
import 'package:ilmora/constant/constants.dart';
import 'package:ilmora/model/qari.dart';
import 'package:ilmora/services/api_services.dart';
import 'package:ilmora/widget/qari_list_title.dart';

class QariListScreen extends StatefulWidget {
  const QariListScreen({super.key});

  @override
  State<QariListScreen> createState() => _QariListScreenState();
}

class _QariListScreenState extends State<QariListScreen> {

  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.kSwatchColor,
        title: Text('Qari\'s', style: TextStyle(color: Colors.white),), 
        centerTitle: true),
      body: Padding(padding:const EdgeInsets.only(top: 20, left: 12, right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 1,
                  spreadRadius: 0.0,
                  offset: Offset(0,1),
                )
              ]
            ),
            child: Padding(padding: const EdgeInsets.all(10.0),
            child: Row(children: [
              Text('Search'),
              Spacer(),
              Icon(Icons.search),
            ],),
            ),
          ),
          SizedBox(height: 15,),
          Expanded(child: FutureBuilder(
          future: apiServices.getQariList(), 
          builder: (BuildContext context, AsyncSnapshot<List<Qari>> snapshot){
            if(snapshot.hasError){
              return Center(child: Text('Qari\'s data not found'),);
            }if( snapshot.connectionState == ConnectionState.waiting){
              return Center( child: CircularProgressIndicator(),);
            } return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index){
                return QariListTitle(qari: snapshot.data![index], ontap:(){});
              });
          })),
          
        ],
      ),
    ),      
    ));
  }
}