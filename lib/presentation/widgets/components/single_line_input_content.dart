import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:to_do_app/core/consts/strings.dart';
import 'package:to_do_app/core/utils/palette.dart';
import 'package:to_do_app/core/utils/string_extension.dart';
import 'package:to_do_app/presentation/widgets/components/text_view_medium.dart';

class SingleLineInputContent extends StatefulWidget {
  static const keyPrefix = 'SingleLineInput';

  final String? title;
  final String? editTextType;
  final int? characterLimit;
  final TextInputAction? textInputAction;
  final ValueChanged<String> onChanged;
  final VoidCallback? onRemove;
  final ValueChanged<String> onSubmitted;
  final String? hintText;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final String? errorString;
  final bool? enabledField;
  final String? userResponse;
  final bool isMultiLine;

  const SingleLineInputContent({
    super.key,
    required this.title,
    this.editTextType,
    this.characterLimit,
    required this.onChanged,
    this.onRemove,
    required this.onSubmitted,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.errorString,
    this.enabledField,
    this.userResponse,
    this.textInputAction,
    this.isMultiLine = false,
  });

  @override
  SingleLineInputContentState createState() => SingleLineInputContentState();
}

class SingleLineInputContentState extends State<SingleLineInputContent> {
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController.fromValue(
      TextEditingValue(text: widget.userResponse ?? ''),
    );
    widget.onChanged.call(widget.userResponse ?? '');
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SingleLineInputContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.userResponse != oldWidget.userResponse) {
      textEditingController.value = textEditingController.value.copyWith(
          text: widget.userResponse,
          selection: textEditingController.value.selection);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: widget.isMultiLine == true
          ? MainAxisAlignment.start
          : MainAxisAlignment.center,
      spacing: 8,
      children: [
        if (!widget.isMultiLine) // Show title only if single-line input
          TextViewMedium(name: widget.title),
        TextFormField(
          key: const ValueKey('${SingleLineInputContent.keyPrefix}-TextField'),
          style: Theme.of(context).textTheme.bodyMedium,
          textAlignVertical: widget.isMultiLine == true
              ? TextAlignVertical.top
              : null, // Align text to top
          decoration: widget.isMultiLine
              ? InputDecoration(
                  hintText: Strings.typeHere,
                  hintStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Palette.placeHolderColor,
                      ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  isCollapsed: true,
                  contentPadding: widget.isMultiLine == true
                      ? EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 8,
                        )
                      : null, // Adjust padding for multiline
                )
              : (() {
                  if (widget.onRemove != null) {
                    return InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () {
                          widget.onRemove!();
                        },
                        icon: const Icon(Icons.delete_outline),
                      ),
                    );
                  } else {
                    return InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.5, color: Colors.grey)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.red)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.red)),
                      errorStyle: const TextStyle(
                        color: Colors.red,
                      ),
                      prefixIcon: widget.prefixIcon,
                      suffixIcon: widget.suffixIcon,
                    );
                  }
                }()),
          minLines: widget.isMultiLine ? null : 1,
          maxLines: widget.isMultiLine ? null : 1,
          obscureText: widget.obscureText ?? false,
          controller: textEditingController,
          onChanged: (value) {
            widget.onChanged(value);
          },
          maxLength: widget.characterLimit,
          maxLengthEnforcement: widget.characterLimit != null
              ? MaxLengthEnforcement.enforced
              : MaxLengthEnforcement.none,
          textInputAction: widget.isMultiLine
              ? TextInputAction.newline
              : widget.textInputAction,
          onFieldSubmitted: widget.onSubmitted,
          keyboardType: widget.isMultiLine
              ? TextInputType.multiline
              : widget.editTextType?.getTextInput,
          validator: (value) {
            return widget.editTextType!.getValidation(value);
          },
          enabled: widget.enabledField,
        ),
      ],
    );
  }
}
