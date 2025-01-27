class AttachmentModel {
  String fileName;
  String filePath;
  double fileSize;

  AttachmentModel({
    required this.fileName,
    required this.filePath,
    required this.fileSize,
  });
}

class ProfileHighlightModel {
  String id;
  String title;
  String description;

  ProfileHighlightModel({
    required this.id,
    required this.title,
    required this.description,
  });
}