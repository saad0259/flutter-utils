// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

enum ImageType { network, file, asset, unknown }

extension ImageTypeExtension on ImageType {
  String get getName {
    switch (this) {
      case ImageType.network:
        return 'network';
      case ImageType.file:
        return 'file';
      case ImageType.asset:
        return 'asset';
      default:
        return 'unknown';
    }
  }
}

class CustomImageHelper {
  ImageType getImageType(String imagePath) {
    try {
      final String leftSubstring = imagePath.substring(0, 8).toLowerCase();

      if (leftSubstring.contains('http')) {
        return ImageType.network;
      } else if (leftSubstring.contains('/data')) {
        return ImageType.file;
      } else if (leftSubstring.contains('asset')) {
        return ImageType.asset;
      } else {
        return ImageType.unknown;
      }
    } catch (e) {
      print('Image extension error : $e');
      return ImageType.unknown;
    }
  }
}

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage(
    this.source, {
    Key? key,
    this.fit,
    this.errorWidget,
    this.width,
    this.height,
    this.alignment,
  }) : super(key: key);
  final String source;
  final BoxFit? fit;
  final Widget? errorWidget;
  final double? width;
  final double? height;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      source,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      alignment: alignment ?? Alignment.center,
      errorBuilder: (context, error, stackTrace) =>
          errorWidget ?? const Icon(Icons.error),
    );
  }
}

// Future<FunctionResponse> pickUserImage(BuildContext context) async {
//   FunctionResponse _fResponse = getIt<FunctionResponse>();
//   final ThemeData theme = Theme.of(context);
//   String _pickedImage = '';
//   final ImagePicker _picker = ImagePicker();
//   await showDialog(
//       context: context,
//       builder: (ctx) => AlertDialog(
//             title: Text(
//               'Select an Image',
//               style: theme.textTheme.headlineMedium,
//             ),
//             actions: [
//               TextButton(
//                   onPressed: () async {
//                     final XFile? image = await _picker.pickImage(
//                         source: ImageSource.gallery,
//                         imageQuality: 50,
//                         maxWidth: 150);
//                     if (image == null) {
//                       _pickedImage = '';

//                       _fResponse.message = 'Image not picked';

//                       Navigator.of(context).pop();
//                     } else {
//                       _pickedImage = image.path;

//                       _fResponse.passed();
//                       _fResponse.data = _pickedImage;
//                       _fResponse.message = 'Image picked From gallery';

//                       Navigator.of(context).pop();
//                     }
//                   },
//                   child: Text(
//                     'Open Gallery',
//                     style: theme.textTheme.headlineSmall,
//                   )),
//               TextButton(
//                   onPressed: () async {
//                     final XFile? photo =
//                         await _picker.pickImage(source: ImageSource.camera);
//                     if (photo == null) {
//                       _pickedImage = '';

//                       _fResponse.message = 'Image not captured';

//                       Navigator.of(context).pop();
//                       return;
//                     } else {
//                       _pickedImage = photo.path;

//                       _fResponse.passed();
//                       _fResponse.data = _pickedImage;
//                       _fResponse.message = 'Image captured with Camera';

//                       Navigator.of(context).pop();
//                     }
//                   },
//                   child: Text(
//                     'Capture',
//                     style: theme.textTheme.headlineSmall,
//                   )),
//             ],
//           ));

//   return _fResponse;
// }
