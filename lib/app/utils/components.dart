import 'package:flutter/material.dart';
import 'package:get/get.dart';

// For Snackbar
void showSnackbar(String title, String message) {
  Get.snackbar(
    title, message,
    titleText: Text(
      title,
      textDirection: TextDirection.rtl,
      style: TextStyle(fontSize: 16.0, color: Colors.white),
    ),
    messageText: Text(
      message,
      textDirection: TextDirection.rtl,
      style: TextStyle(fontSize: 16.0, color: Colors.white),
    ),
    borderRadius: 0,
    margin: EdgeInsets.all(0),
    backgroundColor: Colors.grey[900],
    colorText: Colors.white,
    snackPosition: SnackPosition.BOTTOM,
  );
}

// For AlertDialog
void showAlertDialog(String title, String content) {
  Get.dialog(
    Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Text(title),
        content: Text(content),
        contentPadding: EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 0.0),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text('حسناً')
          )
        ],
      ),
    )
  );
}

// For ProgressIndicator
Widget showProgressIndicator() {
  return Center(child: const CircularProgressIndicator(color: Color(0xFF57bf72)));
}

// For MaterialButton
Widget buildMaterialButton({
  required Function onPressed,
  required String text,
}) {
  return Container(
    width: double.infinity,
    height: 60.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
    ),
    child: MaterialButton(
      onPressed: () => onPressed(),
      child: buildText(
        text: text,
        size: 22.0,
        color: Colors.white,
        weight: FontWeight.bold
      ),
      color: Get.theme.colorScheme.secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    ),
  );
}

// For TextFormField
Widget buildFormField({
  required TextEditingController controller,
  required TextInputType type,
  required Function validate,
  required String? hint,
  Function? onChange,
  bool isPassword = false,
  IconData? prefix,
  Widget? suffix,
  int? lines
}) {
  return TextFormField(
    controller: controller,
    keyboardType: type,
    obscureText: isPassword,
    style: TextStyle(fontSize: 20.0, height: 1.1),
    validator: (value) => validate(value),
    onChanged: (value) => onChange != null ? onChange(value) : (change){},
    maxLines: lines,
    decoration: InputDecoration(
      hintText: hint,
      fillColor: Colors.grey[200],
      filled: true,
      isDense: true,
      //prefix: Icon(prefix),
      //suffix: suffix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide.none
      ),
    ),    
  );
}

// For DropdownButtonFormField
Widget buildDropdownButton({
  required String? value,
  required String hint,
  required Function validate,
  required Function onChanged,
  required List<String> items
}) {
  return Container(
    width: double.infinity,
    child: DropdownButtonFormField<String>(
      style: TextStyle(fontSize: 20.0, height: 1.1, color: Colors.grey[700]),
      validator: (value) => validate(value),
      value: value,
      hint: Text(hint),
      isExpanded: true,
      items: items.map((category) => DropdownMenuItem<String>(
        child: buildText(text: category, color: Colors.black),
        value: category
      )).toList(),
      onChanged: (value) => onChanged(value),
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        filled: true,
        isDense: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none
        ),
      )
    ),
  );
}

// For Text
Widget buildText({
  required String text,
  double? size,
  FontWeight? weight,
  String? family,
  Color? color,
  TextOverflow? overflow,
  bool isUpperCase = false,
  double? letterSpacing,
}) {
  return Text(
    isUpperCase ? text.toUpperCase() : text,
    style: TextStyle(
      fontSize: size,
      fontWeight: weight,
      fontFamily: family,
      color: color,
      letterSpacing: letterSpacing,
    ),
    overflow: overflow,
  );
}

// For Image Picker
void buildImagePickerBottomSheet({
  required Function onCameraPressed,
  required Function onGalleryPressed,
}) {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
        children: [
          buildText(
            text: 'Continue using',
            size: 20.0,
            color: Colors.black,
          ),
          buildListTile(
            title: 'Camera',
            icon: Icons.camera_alt,
            onTap: () => onCameraPressed(),
          ),
          buildListTile(
            title: 'Gallery',
            icon: Icons.image,
            onTap: () => onGalleryPressed(),
          ),
        ],
      ),
    ),
    backgroundColor: Colors.white,
  );
}

// For ListTile
Widget buildListTile({
  required String title,
  required IconData icon,
  required Function() onTap,
}) {
  return ListTile(
    onTap: onTap,
    contentPadding: const EdgeInsets.all(10.0),
    dense: true,
    title: buildText(
      text: title,
      size: 18.0,
      color: Colors.black,
      weight: FontWeight.bold,
    ),
    leading: Icon(
      icon,
      size: 25,
      color: Get.theme.colorScheme.secondary,
    ),
  );
}

// For FloatingActionButton
Widget buildFloatingActionButton({
  required String title,
  required IconData icon,
  required double width,
  required Function() onPressed,
}) {
  return Align(
    alignment: Alignment.bottomCenter,
    child: Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Get.theme.colorScheme.secondary,
      ),
      child: TextButton.icon(
        label: buildText(
          text: title,
          size: 19.0,
          color: Colors.white,
          weight: FontWeight.bold,
        ),
        icon: Icon(icon, color: Colors.white),
        onPressed: onPressed,
      ),
    ),
  );
}
