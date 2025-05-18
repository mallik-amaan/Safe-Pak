// import 'dart:io';

// import 'package:appwrite/appwrite.dart';

// class UploadFile {
//   static Future uploadFile(File fileToUpload) async {
//     Client client = Client();
//     client
//         .setEndpoint('https://fra.cloud.appwrite.io/v1')
//         .setProject('6829b3210000977e27cd')
//         .setSelfSigned(status: true);

//     Storage storage = Storage(client);

//     late InputFile file;
//     file = InputFile.fromPath(path: fileToUpload.path);

//     // Upload the file
//     File? uploadedFile = await storage.createFile(
//       bucketId: '6829b47c0004dd9cc58a',
//       fileId:
//           'unique()',
//       file: file,
//       permissions: [
//         Permission.read(Role.any()),
//       ],
//     ).then((response) {
//       print(response); // File uploaded!
//     }).catchError((error) {
//       print(error.response);
//     });
//   }
// }
