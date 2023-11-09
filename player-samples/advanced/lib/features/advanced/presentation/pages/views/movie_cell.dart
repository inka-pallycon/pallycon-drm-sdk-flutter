import 'package:advanced/features/advanced/domain/entities/download_status.dart';
import 'package:advanced/features/advanced/domain/entities/drm_movie.dart';
import 'package:advanced/features/advanced/presentation/controllers/drm_movie_controller.dart';
import 'package:advanced/features/advanced/presentation/pages/views/movie_container.dart';
import 'package:advanced/features/advanced/presentation/pages/views/remove_select_modal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MovieCell extends StatelessWidget {
  final DrmMovie drmMovie;
  DrmMovieController controller = Get.find();

  MovieCell({Key? key, required this.drmMovie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: MovieContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 17,
                  child: Text(
                    drmMovie.title,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: SizedBox(
                      width: 30,
                      height: 30,
                      child: downloadButton(context),
                    )),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              movieInformation(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
          ],
        ),
      ),
    );
  }

  String movieInformation() {
    return "${drmMovie.contentType} / ${drmMovie.streamFormat} / ${drmMovie.frameRate} / ${drmMovie.maximumResolution}";
  }

  Widget downloadButton(BuildContext context) {
    switch (drmMovie.downloadStatus) {
      case DownloadStatus.success:
        return GestureDetector(
          onTap: () => showMaterialModalBottomSheet(
            expand: false,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => SingleChildScrollView(
              controller: ModalScrollController.of(context),
              child: RemoveSelectModal(drmMovie: drmMovie),
            ),
          ),
          child: const Icon(
            Icons.file_download_off,
            color: Colors.white,
            size: 30,
          ),
        );
      case DownloadStatus.running:
        return GestureDetector(
          onTap: () => controller.pauseContent(drmMovie),
          child: Text(
              "${controller.getDownloadPercent(drmMovie).ceil()}%"
                  .padLeft(4, "  "),
              maxLines: 1,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              )),
        );
      default:
        return GestureDetector(
          onTap: () => controller.downloadContent(drmMovie),
          child: const Icon(
            Icons.download_for_offline,
            color: Colors.white,
            size: 30,
          ),
        );
    }
  }
}

// class _TopCard extends StatelessWidget {
//   const _TopCard({
//     Key? key,
//
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//   }
// }
