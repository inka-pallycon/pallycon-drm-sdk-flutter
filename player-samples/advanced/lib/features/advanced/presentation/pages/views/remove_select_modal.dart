import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../domain/entities/drm_movie.dart';
import '../../controllers/drm_movie_controller.dart';

class RemoveSelectModal extends StatelessWidget {
  final DrmMovie drmMovie;
  DrmMovieController controller = Get.find();

  RemoveSelectModal({Key? key, required this.drmMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Remove License'),
                leading: Icon(Icons.highlight_remove),
                onTap: () {
                  controller.removeLicense(drmMovie);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Remove Content'),
                leading: Icon(Icons.file_download_off),
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
