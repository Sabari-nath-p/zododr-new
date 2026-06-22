import 'package:flutter/material.dart';
import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';

final JitsiMeet jitsiMeet = JitsiMeet();

Future<void> videoCallScreen({
  required String bookingId,
  required String userName,
}) async {
  try {
    final options = JitsiMeetConferenceOptions(
      serverURL: "https://meet.palqar.cloud",
      room: bookingId,

      configOverrides: {
        "startWithAudioMuted": false,
        "startWithVideoMuted": false,
        "prejoinPageEnabled": false,
        "disableInviteFunctions": true,
      },

      featureFlags: {
        "invite.enabled": false,
        "add-people.enabled": false,
        "meeting-name.enabled": false,
        "chat.enabled": true,
        "recording.enabled": false,
        "live-streaming.enabled": false,
        "tile-view.enabled": false,
        "pip.enabled": true,
        "call-integration.enabled": false,
        "unsaferoomwarning.enabled": false,
        "welcomepage.enabled": false,
        "help.enabled": false,
        "settings.enabled": false,
        "toolbox.alwaysVisible": false,
        "breakout-rooms.enabled": false,
        "participants-pane.enabled": false,
      },

      userInfo: JitsiMeetUserInfo(
        displayName: userName,
      ),
    );

    await jitsiMeet.join(options);
  } catch (e) {
    debugPrint("Jitsi Error: $e");
  }
}