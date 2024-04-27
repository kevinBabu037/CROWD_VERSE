// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import 'package:socket_io_client/socket_io_client.dart' as io;


// class ChatScreen extends StatefulWidget {
//   final String conversationId;
//   final String recieverid;
//   final String name;
//   final String profilepic;
//   const ChatScreen(
//       {super.key,
//       required this.recieverid,
//       required this.name,
//       required this.profilepic,
//       required this.conversationId});

//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   List<MessageModel> conversation = [];
//   late io.Socket socket;

//   final _formkey = GlobalKey<FormState>();
//   final TextEditingController _messageController = TextEditingController();
//   final scrollController = ScrollController();

//   _connectSocket() {
//     socket = io.io(
//         'http://10.0.2.2:7002',
//         io.OptionBuilder()
//             .setTransports(['websocket'])
//             .disableAutoConnect()
//             .build());
//     socket.connect();
//     socket.onConnect((data) {
//       debugPrint('Connection established');
//       socket.on("getMessage", (data) {
//         setMessages(
//             message: data['text'],
//             senderId: data['senderId'],
//             recieverId: data['recieverId']);
//       });
//     });
//     socket.onConnectError((data) => debugPrint('connect error:$data'));
//     socket.onDisconnect((data) => debugPrint('Socket.IO server disconnected'));
//     socket.emit("addUser", logginedUserId);
//   }

//   @override
//   void initState() {
//     context.read<ConversationBloc>().add(
//           GetAllMessagesInitialFetchEvent(
//             conversationId: widget.conversationId,
//           ),
//         );
//     super.initState();
//     _connectSocket();
//   }

//   void setMessages(
//       {required String message,
//       required String senderId,
//       required String recieverId}) {
//     MessageModel messages = MessageModel(
//         message: message,
//         senderId: senderId,
//         recieverId: recieverId,
//         creartedAt: DateTime.now(),
//         updatedAt: DateTime.now());
//     setState(() {
//       conversation.add(messages);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leadingWidth: 70,
//         leading: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             GestureDetector(
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Icon(Icons.arrow_back_ios_new_rounded)),
//             CircleAvatar(
//               radius: 21,
//               backgroundImage: NetworkImage(widget.profilepic),
//             )
//           ],
//         ),
//         title: Text(widget.name,
//             style:
//                 const TextStyle(fontSize: 18.5, fontWeight: FontWeight.bold)),
//       ),
//       body: Form(
//         key: _formkey,
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height,
//           width: MediaQuery.of(context).size.width,
//           child: Column(
//             children: [
//               Expanded(
//                 child: BlocConsumer<ConversationBloc, ConversationState>(
//                   listener: (context, state) {
//                     if (state is GetAllMessagesSuccesfulState) {
//                       conversation = state.messagesList
//                           .map(
//                             (message) => MessageModel(
//                               message: message.text,
//                               senderId: message.senderId,
//                               recieverId: message.recieverId,
//                               creartedAt: message.createdAt,
//                               updatedAt: message.updatedAt,
//                             ),
//                           )
//                           .toList();
//                     }
//                   },
//                   builder: (context, state) {
//                     if (state is GetAllMessagesLoadingState) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     } else if (state is GetAllMessagesSuccesfulState) {
//                       return ListView.builder(
//                           controller: scrollController,
//                           itemCount: conversation.length + 1,
//                           itemBuilder: (context, index) {
//                             if (index == conversation.length) {
//                               return const SizedBox(
//                                 height: 70,
//                               );
//                             }
//                             if (conversation[index].senderId ==
//                                 logginedUserId) {
//                               return OwnMessageCard(
//                                 message: conversation[index].message,
//                                 time: conversation[index].creartedAt,
//                               );
//                             } else {
//                               return ReplayCard(
//                                 message: conversation[index].message,
//                                 time: conversation[index].creartedAt,
//                               );
//                             }
//                           });
//                     } else {
//                       return const SizedBox();
//                     }
//                   },
//                 ),
//               ),
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: SizedBox(
//                   height: 60,
//                   child: Row(
//                     children: [
//                       SizedBox(
//                         width: MediaQuery.of(context).size.width - 55,
//                         child: Card(
//                           margin: const EdgeInsets.only(
//                               left: 2, right: 2, bottom: 8),
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(25)),
//                           child: TextFormField(
//                             controller: _messageController,
//                             keyboardType: TextInputType.multiline,
//                             maxLines: 5,
//                             minLines: 1,
//                             decoration: const InputDecoration(
//                                 prefix: SizedBox(
//                                   width: 10,
//                                 ),
//                                 border: UnderlineInputBorder(
//                                     borderSide: BorderSide.none),
//                                 hintText: 'Type a message...',
//                                 contentPadding: EdgeInsets.all(5)),
//                           ),
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           if (_messageController.text.isNotEmpty) {
//                             scrollController.animateTo(
//                                 scrollController.position.maxScrollExtent,
//                                 duration: const Duration(microseconds: 100),
//                                 curve: Curves.easeOut);
//                             socket.emit('sendMessage', {
//                               "senderId": logginedUserId,
//                               "recieverId": widget.recieverid,
//                               "text": _messageController.text
//                             });
//                             setMessages(
//                                 message: _messageController.text,
//                                 senderId: logginedUserId,
//                                 recieverId: widget.recieverid);
//                             context.read<AddMessageBloc>().add(
//                                 AddMessageButtonClickEvent(
//                                     message: _messageController.text,
//                                     senderId: logginedUserId,
//                                     recieverId: widget.recieverid,
//                                     conversationId: widget.conversationId));
//                             _messageController.clear();
//                           }
//                         },
//                         child: const Padding(
//                           padding: EdgeInsets.only(bottom: 8, right: 2),
//                           child: CircleAvatar(
//                             backgroundColor: Colors.blue,
//                             radius: 25,
//                             child: Icon(
//                               Icons.send,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


//   final myChanal = IOWebSocketChannel.connect( 
//     Uri.parse("ws://hyperhive.vajid.tech/websocket"),
//     headers: {
//       "AccessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE3NTAxMTc4NTgsImlkIjoiNjIifQ.1Najf-bN7C0-FSUNUtJPlNpKRyjtt-YsW-42a7d-ejY"
//     }
    
//     );

//  streamListener(){
//   myChanal.stream.listen((event) {
//     print("🤢🤢🤢🤢🤢$event}");
//   }); 
//  }

