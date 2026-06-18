import 'package:flutter/material.dart';
//import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class VideoCallScreen extends StatefulWidget {
  VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  @override
  void initState() {
    super.initState();
    // initAgora();
  }

  void initAgora() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Expanded(
          //   child: ZegoUIKitPrebuiltCall(
          //     appID: 396540246, // your AppID,
          //     appSign:
          //         "87dcda660c75384f1da157755edd56a02434db236dd25d2fec434f7441e48488",
          //     userID: "sabarinath-P",
          //     userName: "Sabarinath P",
          //     callID: "3111",

          //     config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall(),
          //   ),
          // )
        ],
      ),
    );
  }
}
