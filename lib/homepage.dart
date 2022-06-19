import 'package:flutter/material.dart';

import 'package:http/http.dart' as http; 

import 'dart:convert';
import 'dart:async';

import 'messageModel.dart';

import 'package:http/http.dart';

import 'package:http/http.dart';
import 'dart:convert';

Future<String> getCompletionOpenAi(String userInput) async {
  final client = Client();
  
  final String apiKey = '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';
  
  final String url = 'http://127.0.0.1:5000';
  
  Map decodedResponse = {};
  String displayText = '';
  
  final String bodyRequest = jsonEncode({'user_input' : userInput});
  
    Response response = 
      await client.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
        body: bodyRequest,
      );
    
    decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
    
    displayText = decodedResponse['choices'][0]['text'];
    
    return displayText;
}

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String user_input = ""; 
  String final_response = ""; 

  ScrollController _scrollController = ScrollController();
  List<ChatMessage> messages = [];
  final myController = TextEditingController();
  void clearText() {
    myController.clear();
  }

  @override
  void initState() {
    _scrollController = ScrollController();

    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            toolbarHeight: 100,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Color.fromARGB(255, 62, 238, 176),
            flexibleSpace: SafeArea(
              child: Container(
                padding: EdgeInsets.only(right: 16),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQtutzqepv7vSde5mQLzT00fWEbynYBq70VaQ&usqp=CAU"),
                      maxRadius: 40,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Carl Rogers",
                            style: TextStyle(
                                fontSize: 32, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )),
        body: Stack(
          children: <Widget>[
            Container(
              height: 600,
              child: SingleChildScrollView(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: messages.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(
                          left: 14, right: 14, top: 10, bottom: 10),
                      child: Align(
                        alignment: (messages[index].messageType == "receiver"
                            ? Alignment.topLeft
                            : Alignment.topRight),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: (messages[index].messageType == "receiver"
                                ? Colors.grey.shade200
                                : Color.fromARGB(255, 93, 232, 183)),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Text(
                            messages[index].messageContent,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: myController,
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () async {
                        _scrollController.animateTo(
                            _scrollController.position.maxScrollExtent,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut);
                        messages.add(ChatMessage(
                            messageContent: myController.text,
                            messageType: "sender"
                          ));

                        String rogers_response = await getCompletionOpenAi(myController.text);

                        messages.add(ChatMessage(
                          messageContent: rogers_response,
                          messageType: "sender",
                        ));
                        clearText();
                        setState(() {});
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: Color.fromARGB(255, 62, 238, 176),
                      elevation: 0,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
