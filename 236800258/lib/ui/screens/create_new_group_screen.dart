import 'package:flutter/material.dart';

import '../../entities/group.dart';
import '../widgets/create_new_group_screen_widgets/input_text_field.dart';
import '../widgets/create_new_group_screen_widgets/new_group_app_bar.dart';

class CreateNewGroupScreen extends StatelessWidget {
  final Group? editingGroup;

  CreateNewGroupScreen({
    Key? key,
    required this.editingGroup,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isEditing = false;
    if (editingGroup != null) {
      isEditing = true;
    }
    return Scaffold(
      appBar: NewGroupAppBar(isEditing: isEditing),
      body: InputTitleTextField(editingGroup: editingGroup),
    );
  }
}
