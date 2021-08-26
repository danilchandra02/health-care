part of 'shared.dart';

Future getImage() async {
  final image = await ImagePicker()
      .getImage(source: ImageSource.gallery, maxHeight: 1920, maxWidth: 1080);

  return image;
}

Future uploadImage(File image) async {
  String fileName = basename(image.path);
  Reference ref = FirebaseStorage.instance.ref().child(fileName);
  UploadTask task = ref.putFile(image);
  TaskSnapshot snapshot = await task;

  return await snapshot.ref.getDownloadURL();
}

Future replaceImage(File image, String oldImage) async {
  //print(oldImage);
  String fileName = basename(image.path);
  Reference refOldImage = FirebaseStorage.instance.refFromURL(oldImage);
  refOldImage.delete();

  Reference ref = FirebaseStorage.instance.ref().child(fileName);
  UploadTask task = ref.putFile(image);
  TaskSnapshot snapshot = await task;

  return await snapshot.ref.getDownloadURL();
}
