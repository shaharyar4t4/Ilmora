import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ilmora/constant/constants.dart';
import 'package:ilmora/controller/tafseer_controller.dart';
import 'package:ilmora/model/surahTranslationlist.dart';
import 'package:ilmora/model/tafseer.dart';
import 'package:ilmora/model/tafseer_auther.dart';
import 'package:ilmora/services/api_services.dart';

class TranslationTitle extends StatelessWidget {
  final int index;
  final SurahTranslation surahTranslation;

  TranslationTitle({required this.index, required this.surahTranslation});
  final _apiServices = ApiServices();
  final _tefseerController = Get.put(TafseerController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(8)),
          boxShadow: [BoxShadow(blurRadius: 1)],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Constants.kSwatchColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  padding: EdgeInsets.all(22),
                  width: double.infinity,
                ),
                Positioned(
                  top: 5,
                  bottom: 2,
                  left: 12,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Text(
                      surahTranslation.aya!,
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ),
                 Positioned(
                  top: 5,
                  left: 40,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: InkWell(
                      onTap: (){
                        showModalBottomSheet(context: context, builder: (context){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                              child: Text("Authors: ", style: TextStyle(fontSize: 20),),
                              ),
                              FutureBuilder<List<TafseerAuthor>>(
                                future: _apiServices.getTafseerAuthors(),
                                builder: (context, snapshot){
                                  if(snapshot.connectionState == ConnectionState.waiting){
                                    return const Center(
                                      child: CircularProgressIndicator(color: Constants.kPrimary,),
                                    );
                                  } if(snapshot.hasData){
                                    List<TafseerAuthor>? authors = snapshot.data;
                                    _tefseerController.name.value = authors?.first.name ?? '';
                                    Future.delayed(Duration.zero,(){
                                      _tefseerController.index.value = 1;
                                    });
                                    return SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                            Obx((){
                                              return DropdownButton<String>(items: authors?.map<DropdownMenuItem<String>>((TafseerAuthor item){
                                                return DropdownMenuItem<String>(
                                                  value: item.name,
                                                  child: Text(item.name!),
                                                );
                                              }).toList(), onChanged: (String? newValue){
                                                int? index = authors?.indexWhere((authors)=> authors.name == newValue );
                                                _tefseerController.updateName(newValue ?? '', (index!+1));
                                              });
                                            })
                                      ],),
                                    );
                                  }
                                  return const Center(child: CircularProgressIndicator(color: Constants.kPrimary,),);
                                },
                              ),
                              const SizedBox(height: 12,),
                              Expanded(child: Obx((){
                                return _tefseerController.index.value == 0 ? const SizedBox.shrink(): FutureBuilder<Tafseer>( 
                                  future: _apiServices.getTafseer(index, surahTranslation.aya!, _tefseerController.index.value),
                                  builder: (context, snapshot){
                                    if(snapshot.hasData){
                                        return Padding(padding: const EdgeInsets.all(8.0),
                                        child: SingleChildScrollView(
                                          child: Text(snapshot.data?.text?? 'Not available'),
                                        ),
                                        );
                                    }
                                    if(snapshot.connectionState == ConnectionState.waiting){
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    return const Text("Please try again Later");
                                  },
                                );
                              }) )
                            ],
                          );
                        });
                      },
                    )
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    surahTranslation.arabic_text!,
                    textAlign: TextAlign.end,

                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    surahTranslation.translation!,
                    textAlign: TextAlign.end,
                    style: TextStyle(color: Colors.black, fontSize: 15),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
