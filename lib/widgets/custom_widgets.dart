import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../theme/app_theme.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final bool elevated;
  final bool primary;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.elevated = false,
    this.primary = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration:
          primary
              ? AppTheme.cardDecorationPrimary
              : elevated
              ? AppTheme.cardDecorationElevated
              : AppTheme.cardDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.radiusL),
          onTap: onTap,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppTheme.spacingL),
            child: child,
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isPrimary;
  final bool isOutlined;
  final IconData? icon;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isPrimary = true,
    this.isOutlined = false,
    this.icon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height ?? 56,
      decoration:
          isOutlined
              ? AppTheme.buttonOutlineDecoration
              : isPrimary
              ? AppTheme.buttonPrimaryDecoration
              : AppTheme.buttonSecondaryDecoration,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.radiusM),
          onTap: isLoading ? null : onPressed,
          child: Center(
            child:
                isLoading
                    ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                    : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (icon != null) ...[
                          Icon(
                            icon,
                            color:
                                isOutlined
                                    ? AppTheme.primaryColor
                                    : Colors.white,
                            size: 20,
                          ),
                          const SizedBox(width: AppTheme.spacingS),
                        ],
                        Text(
                          text,
                          style:
                              isOutlined
                                  ? AppTheme.button.copyWith(
                                    color: AppTheme.primaryColor,
                                  )
                                  : AppTheme.button,
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool enabled;
  final int? maxLines;

  const CustomTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.enabled = true,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: AppTheme.spacingS),
        ],
        Container(
          decoration: AppTheme.inputDecoration,
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            validator: validator,
            onChanged: onChanged,
            enabled: enabled,
            maxLines: maxLines,
            style: AppTheme.bodyLarge,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTheme.bodyLarge.copyWith(
                color: AppTheme.textTertiary,
              ),
              prefixIcon:
                  prefixIcon != null
                      ? Icon(
                        prefixIcon,
                        color: AppTheme.textSecondary,
                        size: 20,
                      )
                      : null,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: AppTheme.spacingL,
                vertical: AppTheme.spacingM,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CustomChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? color;

  const CustomChip({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onTap,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spacingM,
          vertical: AppTheme.spacingS,
        ),
        decoration: BoxDecoration(
          gradient:
              isSelected
                  ? (color != null
                      ? LinearGradient(
                        colors: [color!, color!.withOpacity(0.8)],
                      )
                      : AppTheme.primaryGradient)
                  : null,
          color: isSelected ? null : AppTheme.backgroundCard,
          borderRadius: BorderRadius.circular(AppTheme.radiusRound),
          border: Border.all(
            color: isSelected ? Colors.transparent : AppTheme.borderLight,
            width: 1,
          ),
          boxShadow: isSelected ? AppTheme.shadowSmall : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: isSelected ? Colors.white : AppTheme.textSecondary,
                size: 16,
              ),
              const SizedBox(width: AppTheme.spacingS),
            ],
            Text(
              label,
              style: AppTheme.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomProgressIndicator extends StatelessWidget {
  final double progress;
  final double height;
  final Color? color;
  final Color? backgroundColor;

  const CustomProgressIndicator({
    super.key,
    required this.progress,
    this.height = 8,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor ?? AppTheme.backgroundCard,
        borderRadius: BorderRadius.circular(AppTheme.radiusS),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            gradient:
                color != null
                    ? LinearGradient(colors: [color!, color!])
                    : AppTheme.primaryGradient,
            borderRadius: BorderRadius.circular(AppTheme.radiusS),
          ),
        ),
      ),
    );
  }
}

class CustomStatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;
  final String? subtitle;
  final VoidCallback? onTap;

  const CustomStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.color,
    this.subtitle,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                decoration: BoxDecoration(
                  color: (color ?? AppTheme.primaryColor).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusM),
                ),
                child: Icon(
                  icon,
                  color: color ?? AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              const Spacer(),
              if (onTap != null)
                Icon(
                  FontAwesomeIcons.chevronRight,
                  color: AppTheme.textTertiary,
                  size: 16,
                ),
            ],
          ),
          const SizedBox(height: AppTheme.spacingL),
          Text(
            value,
            style: AppTheme.heading3.copyWith(color: AppTheme.textPrimary),
          ),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            title,
            style: AppTheme.bodyMedium.copyWith(color: AppTheme.textSecondary),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: AppTheme.spacingXS),
            Text(
              subtitle!,
              style: AppTheme.bodySmall.copyWith(color: AppTheme.textTertiary),
            ),
          ],
        ],
      ),
    );
  }
}

class CustomSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? action;

  const CustomSectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacingL),
      child: Row(
        children: [
          if (icon != null) ...[
            Container(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusM),
              ),
              child: Icon(icon, color: AppTheme.primaryColor, size: 20),
            ),
            const SizedBox(width: AppTheme.spacingM),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTheme.heading4),
                if (subtitle != null) ...[
                  const SizedBox(height: AppTheme.spacingXS),
                  Text(
                    subtitle!,
                    style: AppTheme.bodyMedium.copyWith(
                      color: AppTheme.textSecondary,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (action != null) action!,
        ],
      ),
    );
  }
}

class CustomDivider extends StatelessWidget {
  final double? height;
  final Color? color;
  final EdgeInsets? margin;

  const CustomDivider({super.key, this.height, this.color, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(vertical: AppTheme.spacingM),
      height: height ?? 1,
      color: color ?? AppTheme.borderLight,
    );
  }
}

class CustomLoadingIndicator extends StatelessWidget {
  final String? message;
  final double size;

  const CustomLoadingIndicator({super.key, this.message, this.size = 24});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: const CircularProgressIndicator(
              color: AppTheme.primaryColor,
              strokeWidth: 3,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: AppTheme.spacingM),
            Text(
              message!,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
