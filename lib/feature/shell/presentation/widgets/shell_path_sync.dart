import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:goaliva/feature/shell/presentation/cubit/shell_cubit.dart';

/// Syncs [ShellCubit] bottom-nav index when the shell path changes.
class ShellPathSync extends StatefulWidget {
  const ShellPathSync({
    super.key,
    required this.path,
    required this.child,
  });

  final String path;
  final Widget child;

  @override
  State<ShellPathSync> createState() => _ShellPathSyncState();
}

class _ShellPathSyncState extends State<ShellPathSync> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _sync());
  }

  @override
  void didUpdateWidget(covariant ShellPathSync oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      _sync();
    }
  }

  void _sync() {
    if (!mounted) return;
    context.read<ShellCubit>().syncFromPath(widget.path);
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
