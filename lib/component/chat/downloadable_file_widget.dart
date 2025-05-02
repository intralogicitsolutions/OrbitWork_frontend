import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_filex/open_filex.dart';

import '../../controllers/file_download_controller.dart';

class DownloadableFileWidget extends StatefulWidget {
  final String fileUrl;
  final String fileName;
  final int? fileSize;
  final bool isSender;


  DownloadableFileWidget({
    Key? key,
    required this.fileUrl,
    required this.fileName,
    this.fileSize,
    required this.isSender
  }) : super(key: key);

  @override
  State<DownloadableFileWidget> createState() => _DownloadableFileWidgetState();
}

class _DownloadableFileWidgetState extends State<DownloadableFileWidget> {
  final FileDownloadController controller = Get.put(FileDownloadController());

  @override
  void initState() {
    super.initState();
    _checkFileExistence();
  }

  Future<void> _checkFileExistence() async {
    bool exists = await controller.fileAlreadyExists(widget.fileName);
    controller.isDownloaded.value = exists;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => GestureDetector(
      onTap: controller.isDownloaded.value
          ? () async {
        final path = await controller.getDownloadPath(widget.fileName);
        OpenFilex.open(path);
      }
          : null,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.file_copy_rounded,
                color: Colors.grey, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.fileName,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis),
                if (widget.fileSize != null)
                  Text('${(widget.fileSize! / 1024).toStringAsFixed(2)} KB',
                      style: const TextStyle(
                          fontSize: 12, color: Colors.grey)),
                if (controller.isDownloading.value)
                  LinearProgressIndicator(value: controller.progress.value),
              ],
            ),
          ),
          if (!widget.isSender &&
              !controller.isDownloaded.value &&
              !controller.isDownloading.value)
            IconButton(
              icon: const Icon(Icons.download, color: Colors.blue),
              onPressed: () async{
                final  granted = await controller.checkAndRequestStoragePermission();
                if (granted) {
                  // Proceed to download or save file
                  print("Permission granted. Start download...");
                  await controller.downloadFile(widget.fileUrl, widget.fileName);
                  final exists = await controller.fileAlreadyExists(widget.fileName);
                  controller.isDownloaded.value = exists;
                }
                // controller.downloadFile(widget.fileUrl, widget.fileName);
              },
            ),
          // if (controller.isDownloaded.value)
          //   const Icon(Icons.check_circle, color: Colors.green),
        ],
      ),
    ));
  }
}

