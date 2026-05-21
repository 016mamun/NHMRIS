import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/module_model.dart';
import '../../../core/localization/app_translations.dart';

class ModuleCardWidget extends StatefulWidget {
  final ModuleModel module;
  final VoidCallback onTap;

  const ModuleCardWidget({
    super.key,
    required this.module,
    required this.onTap,
  });

  @override
  State<ModuleCardWidget> createState() => _ModuleCardWidgetState();
}

class _ModuleCardWidgetState extends State<ModuleCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      lowerBound: 0.0,
      upperBound: 0.04,
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Icon Container (Centered)
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: widget.module.bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    widget.module.icon,
                    color: widget.module.iconColor,
                    size: 22,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Title (Centered)
              Text(
                widget.module.title.tr(context),
                textAlign: TextAlign.center,
                style: AppTextStyles.moduleTitle.copyWith(
                  color: widget.module.arrowColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 6),

              // Description (Centered)
              Text(
                widget.module.description.tr(context),
                textAlign: TextAlign.center,
                style: AppTextStyles.moduleBody.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),

              // Arrow (Centered)
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: widget.module.arrowColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: widget.module.arrowColor,
                    size: 14,
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
