import 'package:flutter/material.dart';
import 'package:ilmora/model/qari.dart';

class QariListTitle extends StatefulWidget {
  const QariListTitle({super.key, required this.qari, required this.ontap});

  final Qari qari;
  final VoidCallback ontap;

  @override
  State<QariListTitle> createState() => _QariListTitleState();
}

class _QariListTitleState extends State<QariListTitle> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.ontap,
      child: Padding(
        padding: EdgeInsets.all(4.0),
        child: Container(
          margin: EdgeInsets.only(bottom: 6),
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                blurRadius: 3,
                spreadRadius: 0,
                color: Colors.black12,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.qari.name!,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 16, ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
