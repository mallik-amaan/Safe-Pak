import 'package:telephony/telephony.dart';

final Telephony telephony = Telephony.instance;

Future<void> sendSmsAutomatically(
  String phoneNumber,
  String locationMessage,
) async {
  bool? permissionsGranted = await telephony.requestSmsPermissions;
  if (permissionsGranted ?? false) {
    telephony.sendSms(
      to: phoneNumber,
      message: "Emergency! Please help! My location is: $locationMessage",
    );
  }
}
