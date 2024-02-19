
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

pickImage() async{
  final ImagePicker _imagesPicker=ImagePicker();
  XFile? file=await _imagesPicker.pickImage(source: ImageSource.gallery);
  if(file!= null){
    return  file;

  }else{print('no images selected');}

}