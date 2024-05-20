import 'dart:io';

class ContainerInfo {
  final File image;
  final String remarks;
  final bool accepted;

  ContainerInfo({
    required this.image,
    required this.remarks,
    required this.accepted,
  });
}
