import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    this.onTap,
    super.key,
    required this.url,
    this.elevation = 0,
    this.radius = 0,
    this.borderRadius,
    this.errorWidget,
    this.placeholder,
    this.fit,
    this.height,
    this.width,
    this.memCacheWidth,
    this.memCacheHeight,
    this.isBlur = false,
    this.showImageOnTap = false,
    this.useCompactPlaceholder = false,
    this.onError,
  });

  final String url;
  final Widget? errorWidget;
  final Widget? placeholder;
  final BoxFit? fit;
  final double? height, width;
  final int? memCacheWidth;
  final int? memCacheHeight;
  final bool isBlur;
  final double radius, elevation;
  final BorderRadius? borderRadius;
  final bool showImageOnTap;
  final bool useCompactPlaceholder;
  final VoidCallback? onTap;
  final VoidCallback? onError;

  bool get isUrl => !url.contains('assets/images/');

  BorderRadius get _effectiveBorderRadius =>
      borderRadius ?? BorderRadius.circular(radius.r);

  void _openViewer(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return Dialog.fullscreen(
          backgroundColor: Colors.black,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.white),
                ),
                Expanded(
                  child: InteractiveViewer(
                    child: Center(
                      child: isUrl
                          ? Image.network(url, fit: BoxFit.contain)
                          : Image.asset(url, fit: BoxFit.contain),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: showImageOnTap ? () => _openViewer(context) : onTap,
      child: Material(
        borderRadius: _effectiveBorderRadius,
        elevation: elevation,
        child: ClipRRect(
          borderRadius: _effectiveBorderRadius,
          child: isUrl
              ? Image.network(
                  url,
                  fit: fit ?? BoxFit.cover,
                  height: height,
                  width: width,
                  cacheWidth: memCacheWidth,
                  cacheHeight: memCacheHeight,
                  colorBlendMode: isBlur ? BlendMode.colorBurn : null,
                  color: isBlur ? Colors.black.withValues(alpha: 0.4) : null,
                  filterQuality: FilterQuality.medium,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    if (placeholder != null) return placeholder!;
                    if (useCompactPlaceholder) {
                      return ColoredBox(
                        color: colorScheme.surfaceContainerHighest,
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: colorScheme.primary,
                        strokeWidth: 2,
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    onError?.call();
                    return errorWidget ??
                        Icon(
                          Icons.broken_image_rounded,
                          color: colorScheme.onSurfaceVariant,
                        );
                  },
                )
              : Image.asset(
                  url,
                  fit: fit ?? BoxFit.cover,
                  height: height,
                  width: width,
                  cacheWidth: memCacheWidth,
                  cacheHeight: memCacheHeight,
                  colorBlendMode: isBlur ? BlendMode.colorBurn : null,
                  color: isBlur ? Colors.black.withValues(alpha: 0.4) : null,
                  filterQuality: FilterQuality.medium,
                ),
        ),
      ),
    );
  }
}
