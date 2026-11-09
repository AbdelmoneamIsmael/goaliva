import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const _imageExtensions = <String>{
  'jpg',
  'jpeg',
  'png',
  'gif',
  'webp',
  'heic',
  'bmp',
};

class StagePhotoStrip extends StatelessWidget {
  const StagePhotoStrip({
    super.key,
    required this.paths,
    required this.onRemove,
  });

  final List<String> paths;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    if (paths.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: 72.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: paths.length,
        separatorBuilder: (_, _) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final path = paths[index];
          if (_isImagePath(path)) {
            return _PhotoThumbnail(
              path: path,
              onRemove: () => onRemove(path),
            );
          }
          return _FileChip(path: path, onRemove: () => onRemove(path));
        },
      ),
    );
  }
}

class _PhotoThumbnail extends StatelessWidget {
  const _PhotoThumbnail({required this.path, required this.onRemove});

  final String path;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12.r),
          child: Image.file(
            File(path),
            width: 72.w,
            height: 72.h,
            fit: BoxFit.cover,
          ),
        ),
        PositionedDirectional(
          top: 2.h,
          end: 2.w,
          child: Material(
            color: Colors.black.withValues(alpha: 0.55),
            shape: const CircleBorder(),
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: onRemove,
              child: Padding(
                padding: EdgeInsets.all(2.w),
                child: Semantics(
                  label: 'common.remove'.tr(),
                  child: Icon(
                    Icons.close,
                    size: 14.w,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _FileChip extends StatelessWidget {
  const _FileChip({required this.path, required this.onRemove});

  final String path;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: 180.w,
      height: 72.h,
      child: Material(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(8.w, 8.h, 4.w, 8.h),
          child: Row(
            children: [
              Icon(
                Icons.insert_drive_file_outlined,
                size: 22.w,
                color: colorScheme.primary,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  _fileName(path),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall,
                ),
              ),
              Material(
                color: Colors.black.withValues(alpha: 0.55),
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: onRemove,
                  child: Padding(
                    padding: EdgeInsets.all(2.w),
                    child: Semantics(
                      label: 'common.remove'.tr(),
                      child: Icon(
                        Icons.close,
                        size: 14.w,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool _isImagePath(String path) {
  final name = _fileName(path);
  final dot = name.lastIndexOf('.');
  if (dot == -1 || dot == name.length - 1) return false;
  return _imageExtensions.contains(name.substring(dot + 1).toLowerCase());
}

String _fileName(String path) {
  final normalized = path.replaceAll('\\', '/');
  final slash = normalized.lastIndexOf('/');
  return slash == -1 ? normalized : normalized.substring(slash + 1);
}
