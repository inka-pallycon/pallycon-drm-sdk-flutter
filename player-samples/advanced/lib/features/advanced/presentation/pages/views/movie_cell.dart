import 'package:advanced/features/advanced/domain/entities/download_status.dart';
import 'package:advanced/features/advanced/domain/entities/drm_movie.dart';
import 'package:advanced/features/advanced/presentation/controllers/drm_movie_controller.dart';
import 'package:advanced/features/advanced/presentation/pages/views/movie_container.dart';
import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:io' show Platform;

class MovieCell extends StatefulWidget {
  final DrmMovie drmMovie;
  final VoidCallback? onPlayPressed;
  DrmMovieController controller = Get.find();

  MovieCell({Key? key, required this.drmMovie, this.onPlayPressed}) : super(key: key);

  @override
  _MovieCellState createState() => _MovieCellState();
}

class _MovieCellState extends State<MovieCell> {
  bool isPlayerVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: MovieContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isPlayerVisible)
              createBetterPlayer()
            else
              SizedBox(
                height: 80,
                child:
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPlayerVisible = true;
                    });
                  },
                  child: const Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.play_circle_fill, size: 45, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          "Streaming Play",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.drmMovie.title,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        movieInformation(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).colorScheme.onPrimaryContainer),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 80,
                  height: 60,
                  child: downloadButton(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget createBetterPlayer() {
    const betterPlayerConfiguration = BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
    );

    final betterPlayerController =
        BetterPlayerController(betterPlayerConfiguration);

    final config = Get.find<DrmMovieController>().getContentConfig(widget.drmMovie);

    var drmType = BetterPlayerDrmType.widevine;
    if (Platform.isIOS) {
      drmType = BetterPlayerDrmType.fairplay;
    }

    final drmConfig = BetterPlayerDrmConfiguration(
        drmType: drmType,
        certificateUrl: config.certificateUrl,
        licenseUrl: config.licenseUrl,
        headers: {"pallycon-customdata-v2": config.token ?? ""});

    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        config.contentUrl,
        drmConfiguration: drmConfig);

    betterPlayerController.setupDataSource(betterPlayerDataSource);
    return BetterPlayer(controller: betterPlayerController);
  }

  String movieInformation() {
    return "${widget.drmMovie.contentType} / ${widget.drmMovie.streamFormat} / ${widget.drmMovie.frameRate} / ${widget.drmMovie.maximumResolution}";
  }

  Widget playButton(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onPlayPressed?.call(),
      child: const Icon(
        Icons.play_arrow,
        color: Colors.white,
        size: 30,
      ),
    );
  }

  Widget downloadButton(BuildContext context) {
    Widget icon = GestureDetector(
      onTap: () {
        setState(() {
          isPlayerVisible = false;
        });
        widget.controller.downloadContent(widget.drmMovie);
      },
      child: const Icon(
          Icons.download_for_offline, color: Colors.white, size: 60),
    );

    if (widget.drmMovie.downloadStatus == DownloadStatus.success) {
      icon = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              widget.controller.removeContent(widget.drmMovie);
            },
            child: const Icon(
                Icons.file_download_off, color: Colors.white, size: 35),
          ),
          const SizedBox(width: 10), // 아이콘 간격
          GestureDetector(
            onTap: () {
              widget.onPlayPressed?.call();
            },
            child: const Icon(Icons.play_arrow, color: Colors.white, size: 35),
          ),
        ],
      );
    } else if (widget.drmMovie.downloadStatus == DownloadStatus.running) {
      icon = GestureDetector(
        onTap: () => widget.controller.pauseContent(widget.drmMovie),
        child: Container(
          width: 60,
          height: 60,
          alignment: Alignment.center,
          child: Text(
            "${widget.controller.getDownloadPercent(widget.drmMovie).ceil()}%",
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      );
    }

    return icon;
  }
}


// class MovieCell extends StatelessWidget {
//   final DrmMovie drmMovie;
//   final VoidCallback? onPlayPressed;
//   DrmMovieController controller = Get.find();
//
//   MovieCell({Key? key, required this.drmMovie, this.onPlayPressed}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8),
//       child: MovieContainer(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             SizedBox(
//               height: 200,
//               child: createBetterPlayer(),
//             ),
//             const SizedBox(height: 16,),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         drmMovie.title,
//                         style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                             color: Theme.of(context).colorScheme.onPrimaryContainer),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         movieInformation(),
//                         style: Theme.of(context).textTheme.bodyMedium!.copyWith(
//                             color: Theme.of(context).colorScheme.onPrimaryContainer),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: 80,
//                   height: 60,
//                   child: downloadButton(context),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget createBetterPlayer() {
//     const betterPlayerConfiguration = BetterPlayerConfiguration(
//       aspectRatio: 16 / 9,
//       fit: BoxFit.contain,
//     );
//
//     final betterPlayerController =
//         BetterPlayerController(betterPlayerConfiguration);
//
//     final config = controller.getContentConfig(drmMovie);
//
//     var drmType = BetterPlayerDrmType.widevine;
//     if (Platform.isIOS) {
//       drmType = BetterPlayerDrmType.fairplay;
//     }
//
//     final drmConfig = BetterPlayerDrmConfiguration(
//         drmType: drmType,
//         certificateUrl: config.certificateUrl,
//         licenseUrl: config.licenseUrl,
//         headers: {"pallycon-customdata-v2": config.token ?? ""});
//
//     BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
//         BetterPlayerDataSourceType.network,
//         config.contentUrl,
//         drmConfiguration: drmConfig);
//
//     betterPlayerController.setupDataSource(betterPlayerDataSource);
//     return BetterPlayer(controller: betterPlayerController);
//   }
//
//   String movieInformation() {
//     return "${drmMovie.contentType} / ${drmMovie.streamFormat} / ${drmMovie.frameRate} / ${drmMovie.maximumResolution}";
//   }
//
//   Widget playButton(BuildContext context) {
//     return GestureDetector(
//       onTap: () => onPlayPressed?.call(),
//       child: const Icon(
//         Icons.play_arrow,
//         color: Colors.white,
//         size: 30,
//       ),
//     );
//   }
//
//   Widget downloadButton(BuildContext context) {
//     Widget icon = GestureDetector(
//       onTap: () => controller.downloadContent(drmMovie),
//       child: const Icon(
//           Icons.download_for_offline, color: Colors.white, size: 60),
//     );
//
//     if (drmMovie.downloadStatus == DownloadStatus.success) {
//       icon = Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           GestureDetector(
//             onTap: () {
//               controller.removeContent(drmMovie);
//             },
//             child: const Icon(
//                 Icons.file_download_off, color: Colors.white, size: 35),
//           ),
//           const SizedBox(width: 10), // 아이콘 간격
//           GestureDetector(
//             onTap: () {
//               onPlayPressed?.call();
//             },
//             child: const Icon(Icons.play_arrow, color: Colors.white, size: 35),
//           ),
//         ],
//       );
//     } else if (drmMovie.downloadStatus == DownloadStatus.running) {
//       icon = GestureDetector(
//         onTap: () => controller.pauseContent(drmMovie),
//         child: Container(
//           width: 60,
//           height: 60,
//           alignment: Alignment.center,
//           child: Text(
//             "${controller.getDownloadPercent(drmMovie).ceil()}%",
//             style: const TextStyle(color: Colors.white, fontSize: 20),
//           ),
//         ),
//       );
//     }
//
//     return icon;
//   }
// }
