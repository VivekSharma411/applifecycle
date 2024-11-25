import 'dart:async';

import 'package:flutter/material.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {

  List<String> list = [];
  StreamSocket streamSocket= StreamSocket();
  TextEditingController messageController = TextEditingController();

  Stream<int> generateNumber() async* {
    yield 0;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      body: Column(
        children: [
          StreamBuilder(
              stream: streamSocket.getResponse,
              builder: (context,AsyncSnapshot<List<String>> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting ){
                  return const CircularProgressIndicator();
                }else if (snapshot.connectionState == ConnectionState.active){
                  snapshot.connectionState == ConnectionState.done;

                  if(snapshot.hasError){
                    return Text(snapshot.error.toString());
                  }else if(snapshot.hasData){
                    return Text(snapshot.data.toString());
                  }else {
                    return const Text("Something went wrong");
                  }
                }else{
                  return const Text("Something went wrong");
                }
              }
          ),

          Row(
            children: [
              TextFormField(
                controller:  messageController,
                decoration: const InputDecoration(
                    hintText: 'Enter message'
                ),
              ),
              IconButton(onPressed: (){}, icon: const Icon(Icons.send)),
            ],
          )

        ],
      ),
    );
  }

}

class StreamSocket{

  final stream = StreamController<List<String>>();
  //In Dart, a sink in the context of streams is a way to send data into a stream.
  void Function(List<String>) get addResponse=> stream.sink.add;
  Stream<List<String>> get getResponse => stream.stream.asBroadcastStream();

}
