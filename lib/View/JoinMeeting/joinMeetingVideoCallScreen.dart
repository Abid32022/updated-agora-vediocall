import 'package:agora_uikit/agora_uikit.dart';

import 'package:flutter/material.dart';
import 'package:my_new_project/Utils/appcontant.dart';

class JoinMeetingVideoCallScreen extends StatefulWidget {
  String? meetingID;
  JoinMeetingVideoCallScreen({required this.meetingID,super.key});

  @override
  State<JoinMeetingVideoCallScreen> createState() => _JoinMeetingVideoCallScreenState();
}

class _JoinMeetingVideoCallScreenState extends State<JoinMeetingVideoCallScreen> {

  bool loading = true ;
  late final AgoraClient client;


  Future<void> videoCall()async{
    client = AgoraClient(
        agoraConnectionData: AgoraConnectionData(
          appId: AppConstant.appID,
          // tempToken: token,
          channelName: widget.meetingID.toString(),
        ),enabledPermission: [Permission.camera,Permission.audio,Permission.microphone]);

  }
  @override
  void initState() {
    super.initState();
      setState(() {
        loading =false;
        videoCall().then((value){
          initAgora();
        });
      });
  }

  void initAgora() async {
    if(loading == false){
      await client.initialize();
    }
  }
  @override
  Widget build(BuildContext context) {
    print("this is token ${widget.meetingID}");
    // print("this is token ${token}");
    return Scaffold(
      body: SafeArea(
        child: loading == true? Center(child: Text("this is loading ${loading}"),):Stack(
          children: [
            AgoraVideoViewer(client: client),
            AgoraVideoButtons(client: client),
          ],
        ),
      ),
    );
  }
}
