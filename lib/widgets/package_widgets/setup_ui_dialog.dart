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




/*actions: <Widget>[
        Center(
          child: Column(children: [
            TextButton(
              onPressed: () async {
                await model.scheduleMessage(5, '30 minutes from now');
                model.exit();
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: const Text(
                '30 minutes from now',
                style: TextStyle(color: AppColors.blackColor),
              ),
            ),
            TextButton(
              onPressed: () {
                model.exit();
                model.scheduleMessage(0.5, '1 hour from now');
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: const Text(
                '1 hour from now',
                style: TextStyle(color: AppColors.blackColor),
              ),
            ),
            TextButton(
              onPressed: () {
                model.exit();
                model.scheduleMessage(0.5, 'messageText');
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: const Text(
                '2 hours from now',
                style: TextStyle(color: AppColors.blackColor),
              ),
            ),
            TextButton(
              onPressed: () {
                model.exit();
                model.scheduleMessage(0.5, 'messageText');
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: const Text(
                '6 hours from now',
                style: TextStyle(color: AppColors.blackColor),
              ),
            ),
          ]),
        )
      ],*/