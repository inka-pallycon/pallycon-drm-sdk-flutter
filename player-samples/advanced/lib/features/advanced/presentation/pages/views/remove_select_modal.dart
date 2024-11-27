import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../domain/entities/drm_movie.dart';
import '../../controllers/drm_movie_controller.dart';

class RemoveSelectModal extends StatelessWidget {
  final DrmMovie drmMovie;
  final DrmMovieController controller = Get.find();

  RemoveSelectModal({super.key, required this.drmMovie});

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
      top: false,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            title: const Text('Remove License'),
            leading: const Icon(Icons.highlight_remove),
            onTap: () {
              controller.removeLicense(drmMovie);
              Navigator.of(context).pop();
            },
          ),
          ListTile(
            title: const Text('Remove Content'),
            leading: const Icon(Icons.file_download_off),
            onTap: () {
              controller.removeContent(drmMovie);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    ));
  }
}
