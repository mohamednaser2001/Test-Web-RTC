
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_now/core/network/crud.dart';

import '../../../../core/utils/color_manger.dart';

class MessagesScreen  extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: [
          // Card(
          //   elevation: 0.0,
          //   child: SizedBox(
          //     height: 140.0,
          //     width: double.infinity,
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Padding(
          //           padding: EdgeInsets.only(left: 16.0, top: 8, bottom: 16),
          //           child: Text(
          //             'Stories',
          //             style: TextStyle(
          //               fontWeight: FontWeight.w900,
          //               fontSize: 15,
          //               color: AppColors.primaryColor,
          //             ),
          //           ),
          //         ),
          //         Expanded(
          //           child: ListView.builder(
          //             scrollDirection: Axis.horizontal,
          //             itemBuilder:(context, index)=> StoryCard(),
          //             itemCount: 10,
          //           ),
          //         ),
          //
          //
          //       ],
          //     ),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.separated(
              physics:const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder:(context, index)=> MessageTile(),
              separatorBuilder: (context, index)=>Container(
                height: 1.0,
                color: Colors.grey.withOpacity(0.14),
              ),
              itemCount: 10,
            ),
          ),

        ],
      ),
    );
  }


}

class MessageTile extends StatelessWidget {
  const MessageTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){

      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 14.0),
        child: Row(
          children: [

            ClipOval(
              child: FadeInImage(
                width: 40.r,
                height: 40.r,
                fit: BoxFit.cover,

                fadeInCurve: Curves.easeIn,
                fadeOutCurve: Curves.easeOut,
                fadeInDuration: Duration(milliseconds: 500),
                fadeOutDuration: Duration(milliseconds: 200),
                  placeholder: AssetImage('assets/images/placeholder.png'),
                  image: NetworkImage(
                    'https://thumbs.dreamstime.com/b/lonely-elephant-against-sunset-beautiful-sun-clouds-savannah-serengeti-national-park-africa-tanzania-artistic-imag-image-106950644.jpg',
                  ),
              ),
            ),
            // Container(
            //   width: 40.r,
            //   height: 40.r,
            //   decoration: const BoxDecoration(
            //     shape: BoxShape.circle
            //   ),
            //   clipBehavior: Clip.antiAliasWithSaveLayer,
            //   child: Image.network(
            //     'https://thumbs.dreamstime.com/b/lonely-elephant-against-sunset-beautiful-sun-clouds-savannah-serengeti-national-park-africa-tanzania-artistic-imag-image-106950644.jpg',
            //   fit: BoxFit.cover,
            //   ),
            // ),
            const SizedBox(width: 10.0,),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Mohamed nasser',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        letterSpacing: 0.2,
                        wordSpacing: 1.5,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(
                      overflow: TextOverflow.ellipsis,
                      'mohamed send you a new message',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 6.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    '5:11 Am',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Icon(
                    Icons.access_time_filled,
                    color: AppColors.greyBorderColor,
                    size: 18,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class StoryCard extends StatelessWidget {
  const StoryCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 82.0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Avatar.medium(
          //     url: 'https://thumbs.dreamstime.com/b/lonely-elephant-against-sunset-beautiful-sun-clouds-savannah-serengeti-national-park-africa-tanzania-artistic-imag-image-106950644.jpg'),

         CircleAvatar(radius: 20,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 8.0),
              child: Text(
                'Mohamed nasser',
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 11,
                  letterSpacing: 0.3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
