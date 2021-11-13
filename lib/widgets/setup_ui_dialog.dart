
import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/widgets/alert_dialog.dart';
import 'package:stacked_services/stacked_services.dart';


void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final builders = {
      DialogType.login: (context, request, completer) =>  SignOutDialog(request: request, completer: completer, title: 'Logging In',),
     DialogType.register: (context, request, completer) =>  SignOutDialog(request: request, completer: completer, title: 'Signing Up',),  
  };

  dialogService.registerCustomDialogBuilders(builders);
}




enum DialogType {
  login,
  register,
  signOut
}