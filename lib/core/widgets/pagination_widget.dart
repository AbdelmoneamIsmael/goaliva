import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum _PaginationItemType { page, ellipsis, previous, next }

class _PaginationItem {
  const _PaginationItem._(this.type, this.page);

  const _PaginationItem.page(int page) : this._(_PaginationItemType.page, page);

  const _PaginationItem.ellipsis() : this._(_PaginationItemType.ellipsis, null);

  const _PaginationItem.previous() : this._(_PaginationItemType.previous, null);

  const _PaginationItem.next() : this._(_PaginationItemType.next, null);

  final _PaginationItemType type;
  final int? page;
}

class PaginationWidget extends StatelessWidget {
  const PaginationWidget({
    super.key,
    required this.totalPages,
    required this.onPageChanged,
    this.currentPage = 1,
    this.maxVisiblePages = 5,
  })  : assert(totalPages >= 1, 'totalPages must be at least 1'),
        assert(currentPage >= 1, 'currentPage must be at least 1'),
        assert(maxVisiblePages >= 1, 'maxVisiblePages must be at least 1');

  final int totalPages;
  final int currentPage;
  final ValueChanged<int> onPageChanged;
  final int maxVisiblePages;

  List<_PaginationItem> _buildVisibleItems() {
    final page = currentPage.clamp(1, totalPages);

    if (totalPages <= maxVisiblePages) {
      return [for (var i = 1; i <= totalPages; i++) _PaginationItem.page(i)];
    }

    final items = <_PaginationItem>[];

    if (page > 1) {
      items.add(const _PaginationItem.previous());
    }

    if (page <= 4) {
      items.addAll([
        const _PaginationItem.page(1),
        const _PaginationItem.page(2),
        const _PaginationItem.page(3),
        const _PaginationItem.page(4),
        const _PaginationItem.ellipsis(),
        _PaginationItem.page(totalPages),
      ]);
    } else if (page >= totalPages - 3) {
      items.addAll([
        const _PaginationItem.page(1),
        const _PaginationItem.ellipsis(),
        _PaginationItem.page(totalPages - 3),
        _PaginationItem.page(totalPages - 2),
        _PaginationItem.page(totalPages - 1),
        _PaginationItem.page(totalPages),
      ]);
    } else {
      items.addAll([
        const _PaginationItem.page(1),
        const _PaginationItem.ellipsis(),
        _PaginationItem.page(page - 1),
        _PaginationItem.page(page),
        _PaginationItem.page(page + 1),
        const _PaginationItem.ellipsis(),
        _PaginationItem.page(totalPages),
      ]);
    }

    if (page < totalPages) {
      items.add(const _PaginationItem.next());
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    final page = currentPage.clamp(1, totalPages);
    final items = _buildVisibleItems();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) _gapBetween(items[i - 1], items[i]),
          _buildItem(context, items[i], page),
        ],
      ],
    );
  }

  Widget _gapBetween(_PaginationItem previous, _PaginationItem current) {
    final isArrowGap = previous.type == _PaginationItemType.next ||
        current.type == _PaginationItemType.previous ||
        previous.type == _PaginationItemType.previous ||
        current.type == _PaginationItemType.next;

    return SizedBox(width: isArrowGap ? 2.w : 4.w);
  }

  Widget _buildItem(BuildContext context, _PaginationItem item, int page) {
    switch (item.type) {
      case _PaginationItemType.page:
        return _PaginationPageButton(
          pageNumber: item.page!,
          isSelected: item.page == page,
          onTap: () {
            if (item.page != page) {
              onPageChanged(item.page!);
            }
          },
        );
      case _PaginationItemType.ellipsis:
        return const _PaginationEllipsis();
      case _PaginationItemType.previous:
        return _PaginationNavButton(
          icon: Icons.chevron_left,
          onTap: () => onPageChanged(page - 1),
        );
      case _PaginationItemType.next:
        return _PaginationNavButton(
          icon: Icons.chevron_right,
          onTap: () => onPageChanged(page + 1),
        );
    }
  }
}

class _PaginationPageButton extends StatelessWidget {
  const _PaginationPageButton({
    required this.pageNumber,
    required this.isSelected,
    required this.onTap,
  });

  final int pageNumber;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? colorScheme.primary : colorScheme.surface,
          borderRadius: BorderRadius.circular(8.r),
          border: isSelected
              ? null
              : Border.all(
                  color: colorScheme.outline.withValues(alpha: 0.4),
                  width: 0.5,
                ),
        ),
        child: Text(
          '$pageNumber',
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 14.sp,
            height: 1,
            color: isSelected
                ? colorScheme.onPrimary
                : colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _PaginationEllipsis extends StatelessWidget {
  const _PaginationEllipsis();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 18.w,
      height: 18.h,
      child: Center(
        child: Text(
          '...',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14.sp,
                height: 1,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
        ),
      ),
    );
  }
}

class _PaginationNavButton extends StatelessWidget {
  const _PaginationNavButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 23.w,
        height: 18.h,
        child: Icon(
          icon,
          size: 18.sp,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
