import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:project/utils/colors.dart';

class Problems extends StatefulWidget {
  final String category;
  const Problems({Key? key, required this.category}) : super(key: key);

  @override
  State<Problems> createState() => _ProblemsState();
}

class _ProblemsState extends State<Problems> {
  List<Map<String, dynamic>> problemDataList = [
    {
      'name': 'Largest element in an array',
      'isCompleted': true,
      'isBookmarked': false,
    },
    {
      'name': 'Smallest element in an array',
      'isCompleted': false,
      'isBookmarked': true,
    },
    {
      'name': 'Merge two sorted arrays',
      'isCompleted': true,
      'isBookmarked': true,
    },
    {
      'name': 'Reverse an array',
      'isCompleted': true,
      'isBookmarked': false,
    },
    {
      'name': 'Find the missing number in an array',
      'isCompleted': false,
      'isBookmarked': false,
    },
    {
      'name': 'Remove duplicates from a sorted array',
      'isCompleted': true,
      'isBookmarked': true,
    },
    {
      'name': 'Count frequency of elements in an array',
      'isCompleted': false,
      'isBookmarked': false,
    },
    {
      'name': 'Rotate an array',
      'isCompleted': false,
      'isBookmarked': true,
    },
    {
      'name': 'Find maximum sum subarray',
      'isCompleted': true,
      'isBookmarked': false,
    },
    {
      'name': 'Search in a rotated sorted array',
      'isCompleted': false,
      'isBookmarked': true,
    },
    {
      'name': 'Find common elements in multiple arrays',
      'isCompleted': true,
      'isBookmarked': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          widget.category,
          style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w,),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 4.w),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: problemDataList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    color: const Color(0xFFECF7FD),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              problemDataList[index]['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 22.sp,
                                fontFamily: 'PragatiNarrow',
                                color: AppColors.primary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                problemDataList[index]['isCompleted']
                                    ? Icons.check_circle
                                    : Icons.circle,
                                color: problemDataList[index]['isCompleted']
                                    ? Colors.green
                                    : Colors.transparent,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    problemDataList[index]['isBookmarked'] =
                                        !problemDataList[index]['isBookmarked'];
                                  });
                                },
                                child: Icon(
                                  problemDataList[index]['isBookmarked']
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: problemDataList[index]['isBookmarked']
                                      ? Colors.black87
                                      : Colors.black87,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 50.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
