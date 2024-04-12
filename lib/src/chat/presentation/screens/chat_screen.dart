
import 'package:flutter/material.dart';
import '../../../authentication/data/models/user_model.dart';



class ChatScreen  extends StatelessWidget {

  // UserModel model;
  var messageController= TextEditingController();
  // ChatScreen({required this.model});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon:const Icon(Icons.arrow_back_outlined),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 22.0,
              // backgroundImage:model.image==''? NetworkImage('https://img.freepik.com/premium-photo/astronaut-escape-from-void_146508-24.jpg?size=626&ext=jpg') : NetworkImage('${model.image}'),
            ),
            const SizedBox(width: 10.0,),
            Text(
              'model.name',
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(child: ListView.separated(
              itemBuilder: (context, index){
                // var message = cubit.messages[index];
                // if(cubit.userModel!.uId==message.senderId)
                 if(index%2==0) return myMessage(context);
                else return receivedMessage();
              },
              separatorBuilder:(context, index)=>const SizedBox(height: 8.0,),
              itemCount:10 ,
            ),),
            Container(
              height: 45.0,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: messageController,
                      decoration:const InputDecoration(
                        hintText: 'type your message here ...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: (){
                        if(messageController.text!=''&&messageController.text!=null){

                          messageController.text='';
                        }
                      },
                      icon: Icon(Icons.send_rounded,color: Theme.of(context).primaryColor,)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget receivedMessage()=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      padding:const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius:const BorderRadius.only(
          bottomRight: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
      ),
      child: Text(
        'reseived message',
      ),
    ),
  );

  Widget myMessage(context)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      padding:const EdgeInsets.symmetric(horizontal: 10.0,vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.2),
        borderRadius:const BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
          topLeft: Radius.circular(10.0),
        ),
      ),
      child: Text(
        'my message',
      ),
    ),
  );
}