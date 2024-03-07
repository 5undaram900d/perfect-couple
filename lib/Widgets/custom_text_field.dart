
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {

  final TextEditingController? editingController;
  final IconData? iconData;
  final String? assetRef;
  final String? labelText;
  final bool? isObscure;

  const CustomTextField({super.key, this.editingController, this.iconData, this.assetRef, this.labelText, this.isObscure});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      width: MediaQuery.of(context).size.width - 36,
      child: TextField(
        controller: editingController,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: iconData != null
            ? Icon(iconData)
            : Padding(
                padding: const EdgeInsets.all(8),
                child: Image.asset(assetRef.toString(),),
              ),
          labelStyle: const TextStyle(fontSize: 18),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Colors.grey,),),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(6), borderSide: const BorderSide(color: Colors.grey,),),
        ),
        obscureText: isObscure!,
      ),
    );
  }
}
