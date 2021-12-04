import 'package:fluttertoast/fluttertoast.dart';

void customtoast({required String toastmessage}) {
  Fluttertoast.showToast(
    msg: toastmessage,
  );
}
