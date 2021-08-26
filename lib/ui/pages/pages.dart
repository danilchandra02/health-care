import 'dart:async';
import 'dart:ui';
import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:health_care/bloc/blocs.dart';
import 'package:health_care/models/models.dart';
import 'package:health_care/services/services.dart';
import 'package:health_care/shared/shared.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
part 'home.dart';
part 'get_started.dart';
part 'login.dart';
part 'register.dart';
part 'splash_screen.dart';
part 'wrapper.dart';
part 'home_page.dart';
part 'messages_page.dart';
part 'live_chat.dart';
part 'doctor_detail.dart';
part 'live_doctor.dart';
part 'my_profile.dart';

extension ColorExtension on String {
  toColors() {
    var hexColor = this.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
  }
}
