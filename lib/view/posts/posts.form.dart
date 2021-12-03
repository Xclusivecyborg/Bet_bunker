// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedFormGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

const String postsValueKey = 'posts';

mixin $Posts on StatelessWidget {
  final TextEditingController postsController = TextEditingController();
  final FocusNode postsFocusNode = FocusNode();

  /// Registers a listener on every generated controller that calls [model.setData()]
  /// with the latest textController values
  void listenToFormUpdated(FormViewModel model) {
    postsController.addListener(() => _updateFormData(model));
  }

  /// Updates the formData on the FormViewModel
  void _updateFormData(FormViewModel model) => model.setData(
        model.formValueMap
          ..addAll({
            postsValueKey: postsController.text,
          }),
      );

  /// Calls dispose on all the generated controllers and focus nodes
  void disposeForm() {
    // The dispose function for a TextEditingController sets all listeners to null

    postsController.dispose();
    postsFocusNode.dispose();
  }
}

extension ValueProperties on FormViewModel {
  String? get postsValue => formValueMap[postsValueKey];

  bool get hasPosts => formValueMap.containsKey(postsValueKey);
}

extension Methods on FormViewModel {}
