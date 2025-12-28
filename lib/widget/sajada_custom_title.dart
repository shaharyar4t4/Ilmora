import 'package:flutter/material.dart';
import 'package:ilmora/constant/constants.dart';
import 'package:ilmora/model/sajada.dart';


Widget SajadaCustomListTitle({

  required Sajada sajada,
  required BuildContext context,
  required VoidCallback ontap
}){
  return GestureDetector(
    onTap: ontap,
    child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3.0
          )
        ]
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.center,
                height: 30,
                width: 30,
            
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Constants.kPrimary,
                ),
                child: Text((sajada.number).toString(),
                style: TextStyle(color: Colors.white, fontSize: 12 ),
                ),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(sajada.englishName!, style: TextStyle(fontWeight: FontWeight.bold),),
                  Text(sajada.englishNameTranslation!, style: TextStyle(fontSize: 12),),
                ],
              ),
              Spacer(),
              Text(sajada.name!, style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 14),)
            ],
          )
        ],
      ),
    ),
  );
}