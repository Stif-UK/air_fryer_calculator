import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField({
    Key? key,
    required this.fieldTitle,
    required this.hintText,
    this.inputFormatters,
    this.validator
  }) : super(key: key);

  final String fieldTitle;
  final String hintText;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fieldTitle,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.bodyLarge,),
          TextFormField(
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Theme.of(context).focusColor),
                    borderRadius: BorderRadius.circular(50.0)
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 3, color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(50.0)
                )

            ),

          ),
        ],
      ),
    );
  }
}
