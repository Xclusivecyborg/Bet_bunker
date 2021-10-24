
import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/widgets/alertDialog.dart';
import 'package:stacked_services/stacked_services.dart';


void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
      DialogType.signOut: (context, request, completer) =>  SignOutDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}




enum DialogType {
  signOut
}