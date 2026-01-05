import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loader_overlay/loader_overlay.dart';
class ModalHelper with ModalMixin {}

mixin ModalMixin {
  showToast({required String message}) async {
    await Fluttertoast.cancel();
    await Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black.withValues(alpha: 0.65),
      textColor: Colors.white,
      fontSize: 16,
    );
  }

  showLoading({String? text, required BuildContext context}) {
    context.loaderOverlay.show();
  }

  hideLoading({required BuildContext context}) {
    context.loaderOverlay.hide();
  }
}
