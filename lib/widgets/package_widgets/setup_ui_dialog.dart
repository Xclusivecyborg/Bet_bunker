import 'package:spinchat/app/app.locator.dart';
import 'package:spinchat/view/posts/posts_viewmodel.dart';
import 'package:spinchat/widgets/app_wide_widgets/alert_dialog.dart';
import 'package:spinchat/widgets/app_wide_widgets/dialog_actions.dart';
import 'package:stacked_services/stacked_services.dart';

void setupDialogUi() {
  final dialogService = locator<DialogService>();
  final model = PostsViewModel();

  final builders = {
    DialogType.login: (context, request, completer) => const SignOutDialog(
      
          title: 'Logging In',
        ),
    DialogType.signOut: (context, request, completer) => const SignOutDialog(
        
          title: 'Signing Out',
        ),
    DialogType.register: (context, request, completer) => const SignOutDialog(
       
          title: 'Signing Up',
        ),
    DialogType.schedulePost: (context, request, completer) =>  ScheduleDialog(
        title: 'Schedule Post',
        action: getPostSchedule(context: context, model: model)),
   
  };

  dialogService.registerCustomDialogBuilders(builders);
}

enum DialogType { login, register, signOut, schedulePost, scheduleMessage }
