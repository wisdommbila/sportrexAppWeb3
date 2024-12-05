

import 'package:intl/intl.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';

import '../../../../../core/util/app_text_field.dart';

class FilterTransactionDialog extends StatefulWidget {


   const FilterTransactionDialog({
    Key? key,
    required this.onSubmit,
  }) : super(key: key);

  final VoidCallback onSubmit;

  @override
  State<FilterTransactionDialog> createState() => _FilterTransactionDialogState();
}

class _FilterTransactionDialogState extends State<FilterTransactionDialog> {
  TextEditingController fromController = TextEditingController();

  TextEditingController toController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF002B81),
              Color(0xFF011846),
            ],
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.02),
                spreadRadius: pageHeight(context),
                blurRadius: 1)
          ],
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30))),
      child: Padding(
        padding: horizontalPadding(size: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(20 * $styles.scale),
              Container(
                width: 80.w,
                height: 5.h,
                decoration: BoxDecoration(
                    color: $styles.colors.primary.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(10)),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text("",
                    style: $styles.text.title2.copyWith(
                        fontWeight: FontWeight.w600,
                        color: $styles.colors.white,
                        fontSize: 18.sp)),
              ),
              Gap(20 * $styles.scale),
              Row(
                children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("From",
                          style: $styles.text.body.copyWith(
                              color: $styles.colors.tertiary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400)),
                      Gap(10 * $styles.scale),
                      AppTextField(
                        hintText: "",
                        controller: fromController,
                        // enabled: false,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101)
                          );

                          if(pickedDate != null ){
                            // print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                            // print(formattedDate); //formatted date output using intl package =>  2022-07-04
                            //You can format date as per your need

                            setState(() {
                              fromController.text = formattedDate; //set foratted date to TextField value.
                            });
                          }else{
                            // log("Date is not selected");
                          }
                        },
                        filledColor: $styles.colors.primary,
                      ),
                    ],

                  )),
                  Gap(20 * $styles.scale),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("To",
                              style: $styles.text.body.copyWith(
                                  color: $styles.colors.tertiary,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400)),
                          Gap(10 * $styles.scale),
                          AppTextField(
                    hintText: "",
                    controller: toController,
                    enabled: false,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(), //get today's date
                          firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                          lastDate: DateTime(2101)
                      );

                      if(pickedDate != null ){
                        print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                        print(formattedDate); //formatted date output using intl package =>  2022-07-04
                        //You can format date as per your need

                        setState(() {
                          toController.text = formattedDate; //set foratted date to TextField value.
                        });
                      }else{
                        // log("Date is not selected");
                      }
                    },
                    filledColor: $styles.colors.primary,
                  ),
                        ],
                      )),
                ],
              ),
              Gap(40 * $styles.scale),
              AppBtn.from(
                onPressed: widget.onSubmit,
                expand: true,
                bgColor: $styles.colors.secondary,
                textColor: $styles.colors.white,
                text: $strings.setNow,
              ),
              Gap(30 * $styles.scale),
            ],
          ),
        ),
      ),
    );
  }
}
