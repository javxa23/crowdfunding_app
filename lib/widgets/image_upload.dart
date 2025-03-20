import 'package:crowdfunding_app/styles/style.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

class ImageUploadWidget extends StatefulWidget {
  const ImageUploadWidget({Key? key}) : super(key: key);

  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  List<PlatformFile> _uploadedImages = [];

  Future<void> _pickImages() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.image,
        withData: true,
      );

      if (result != null) {
        setState(() {
          _uploadedImages.addAll(result.files);
        });
      }
    } catch (e) {
      debugPrint('Зураг сонгахад алдаа гарлаа: $e');
    }
  }

  void _removeImage(int index) {
    setState(() {
      _uploadedImages.removeAt(index);
    });
  }

  void _showImagePreview(PlatformFile file) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true, // Дэлгэц дарвал хаагдана
      barrierLabel: "Зураг харах",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.black.withOpacity(0.9), // Хар фон
          body: GestureDetector(
            onTap: () => Navigator.pop(context), // Дэлгэц дарвал хаагдана
            child: Center(
              child: InteractiveViewer(
                panEnabled: true, // Зураг чөлөөтэй хөдөлнө
                boundaryMargin: const EdgeInsets.all(100), // Томрох зайг нэмнэ
                minScale: 0.5,
                maxScale: 5.0, // Томруулах дээд хэмжээ
                child:
                    file.bytes != null
                        ? Image.memory(file.bytes!, fit: BoxFit.contain)
                        : file.path != null
                        ? Image.file(File(file.path!), fit: BoxFit.contain)
                        : const Icon(
                          Icons.image_not_supported,
                          size: 100,
                          color: Colors.white,
                        ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildImageWidget(PlatformFile file, int index) {
    return GestureDetector(
      onTap: () => _showImagePreview(file), // Зураг дээр дарахад томруулна
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child:
            file.bytes != null
                ? Image.memory(file.bytes!, fit: BoxFit.cover)
                : file.path != null
                ? Image.file(File(file.path!), fit: BoxFit.cover)
                : _buildPlaceholder(),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      color: Colors.grey[200],
      child: const Center(
        child: Icon(Icons.image_not_supported, color: Colors.grey, size: 48),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _pickImages,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFBDBAE5), width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: MyColors.background,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.image_outlined,
                    color: MyColors.textPrimary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Зураг оруулах',
                  style: TextStyle(
                    color: MyColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 16),

        _uploadedImages.isEmpty
            ? Container()
            : GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.0,
              ),
              itemCount: _uploadedImages.length,
              itemBuilder: (context, index) {
                final image = _uploadedImages[index];
                return Stack(
                  children: [
                    _buildImageWidget(image, index),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          color: MyColors.primary.withOpacity(0.5),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                image.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _removeImage(index),
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
      ],
    );
  }
}
