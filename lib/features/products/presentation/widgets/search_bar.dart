import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import 'package:medi_care/core/theme/app_theme.dart';
import 'package:medi_care/core/theme/app_dimensions.dart';

class SearchField extends StatefulWidget {
  const SearchField({super.key});

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final FocusNode _focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _onClear() {
    _controller.clear();
    context.read<ProductBloc>().add(const ProductEvent.searchQueryChanged(''));
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: TextField(
        controller: _controller,
        focusNode: _focusNode,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: 'Search medicines...',
          hintStyle: TextStyle(
            color: AppTheme.textSecondary,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppTheme.textSecondary,
          ),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
            valueListenable: _controller,
            builder: (context, value, child) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return IconButton(
                icon: Icon(
                  Icons.close,
                  color: AppTheme.textSecondary,
                  size: AppDimensions.iconSize20,
                ),
                onPressed: _onClear,
              );
            },
          ),
          filled: true,
          fillColor: AppTheme.surfaceGrey,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: AppDimensions.borderRadiusCircular8,
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: AppDimensions.borderRadiusCircular8,
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: AppDimensions.borderRadiusCircular8,
            borderSide: BorderSide(
              color: AppTheme.primary.withValues(alpha: 0.5),
              width: 1.5,
            ),
          ),
        ),
        onChanged: (value) => context
            .read<ProductBloc>()
            .add(ProductEvent.searchQueryChanged(value)),
        onTapOutside: (_) => _focusNode.unfocus(),
      ),
    );
  }
}
