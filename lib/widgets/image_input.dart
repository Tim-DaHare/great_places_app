import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  final Function onImageSelected;

  const ImageInput({
    Key key,
    this.onImageSelected,
  }) : super(key: key);

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _selectedImage;
  final _imagePicker = ImagePicker();

  Future<void> _onPressTakePicture() async {
    final pickedImage = await _imagePicker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (pickedImage == null) return;

    final imageFile = File(pickedImage.path);
    setState(() => _selectedImage = imageFile);

    final imageDir = await syspaths.getApplicationDocumentsDirectory();
    final imgfileName = path.basename(imageFile.path);

    final savedImage = await imageFile.copy("${imageDir.path}/$imgfileName");
    widget.onImageSelected(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 100,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _selectedImage != null
              ? Image.file(
                  _selectedImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text(
                  "No image selected",
                  textAlign: TextAlign.center,
                ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: FlatButton.icon(
            label: Text("Take picture"),
            icon: Icon(Icons.camera),
            textColor: theme.primaryColor,
            onPressed: _onPressTakePicture,
          ),
        ),
      ],
    );
  }
}
