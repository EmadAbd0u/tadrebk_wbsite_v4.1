import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tadrebk/home_screen/home_page.dart';
import 'package:tadrebk/profile/profile.dart';
import 'package:tadrebk/shared/cach_helper.dart';
import 'package:tadrebk/shared/colors.dart';
import 'package:tadrebk/sign_up_screen/sign_up.dart';
import '../add_training/cubit.dart';
import '../login_screen/login.dart';
import '../profile/cubit.dart';
import '../profile/states.dart';
import '../shared/fonts.dart';
import '../training_categories/training_categories.dart';

class HeaderWidget extends StatefulWidget {
  final int index;

  HeaderWidget({
    required this.index,

  });


  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {

  bool isLoggedIn=false;



  @override
  void initState() {

    isLoggedIn = cachHelper.getData(key: 'type')!=null;
    ProfileCubit.get(context).getUserData();
    ProfileCubit.get(context).getCompanyData();

    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ProfileCubit,ProfileStatus>(
      listener: (context,state){},
      builder: (context,state){


        final userModel = ProfileCubit.get(context).userModel;
        var userFirstName = userModel?.firstName;
        var userLastName = userModel?.lastName;
        var userEmail = userModel?.email;
        var userPhoneNumber = userModel?.phoneNumber;
        var userImage = userModel?.image;
        var userCity = userModel?.city;
        var userStreet = userModel?.street;
        var isUser = userModel?.isPerson;

        final companyModel = ProfileCubit.get(context).companyModel;
        var companyName = companyModel?.name;
        var companySpecialization = companyModel?.specialization;
        var companyEmail = companyModel?.email;
        var companyPhoneNumber = companyModel?.phoneNumber;
        var companyImage = companyModel?.image;
        var companyCity = companyModel?.city;
        var companyStreet = companyModel?.street;
        var isCompany = companyModel?.isPerson;



        return  Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.12,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: Offset(0, 4),
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                Image.asset('assets/images/img.png'),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.2,
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap:(){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => HomePage()),
                                     );
                            },
                            child: Text(
                              'Home',
                              style: TextStyle(
                                fontSize: widget.index == 0 ? 24: 16,
                                color:widget.index == 0 ? mainColor : mainColor.withOpacity(0.5),
                                fontFamily: "Poppins",
                                fontWeight: widget.index == 0 ?FontWeight.bold : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: ()  async {
                              int  Programming = 0 ;
                              int  Contracting = 0 ;
                              int  Marketing = 0 ;
                              int  Accounting = 0 ;
                              int  communications = 0 ;
                                 PostCubit.get(context).countCoursesByCategory().then(
                                         (courseCounts) {
                                courseCounts.forEach((category, count) {
                                  print('عدد الكورسات في فئة $category: $count');

                                  if (category == 'Programming') {
                                    Programming = count;
                                  }else if (category == 'Contracting'){
                                    Contracting = count;
                                  }  else if (category == 'Marketing'){
                                    Marketing = count;
                                  } else if (category == 'Accounting'){
                                    Accounting = count;
                                  } else if (category == 'communications'){
                                    communications = count;
                                  }




                                });

                              }).then((value) {
                                   Navigator.push(
                                     context,
                                     MaterialPageRoute(builder: (context) => TrainingCategories(
                                       Programming: Programming,
                                       Contracting: Contracting,
                                       Marketing: Marketing,
                                       Accounting: Accounting,
                                       communications: communications,
                                     )),
                                   );
                                 });







                            },
                            child: Text(
                              'Courses',
                              style: TextStyle(
                                fontSize: widget.index == 1 ? 24 : 16,
                                color: widget.index == 1 ? mainColor : mainColor.withOpacity(0.5),
                                fontFamily: "Poppins",
                                fontWeight: widget.index == 1 ?FontWeight.bold : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              //
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => contactUs()),
                              //        );
                            },
                            child: Text(
                              'Contact Us',
                              style: TextStyle(
                                fontSize: widget.index == 2 ? 24 : 16,
                                color:widget.index == 2 ? mainColor : mainColor.withOpacity(0.5),
                                fontFamily: "Poppins",
                                fontWeight: widget.index == 2 ?FontWeight.bold : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => aboutUs()),
                              //        );
                            },
                            child: Text(
                              'About Us',
                              style: TextStyle(
                                fontSize: widget.index == 3 ? 24 : 16,
                                color: widget.index == 3 ? mainColor : mainColor.withOpacity(0.5),
                                fontFamily: "Poppins",
                                fontWeight: widget.index == 3 ?FontWeight.bold : FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isLoggedIn == false ? Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                        );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.06,
                        height: MediaQuery.of(context).size.width * 0.03,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: mainColor, // Outline color
                            width: 1, // Outline width
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: mainColor,
                                fontFamily: 'Poppins',
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUp()),
                                );
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.03,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              HexColor('#1B3358'),
                              mainColor
                            ],
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ): InkWell(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context){
                        return Profile();
                      }),
                    );
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.black12,
                          backgroundImage:isUser == 'true' ? userImage == null ?
                          AssetImage('assets/images/img_23.png') as ImageProvider :
                          NetworkImage('$userImage') : companyImage == null ?
                          AssetImage('assets/images/img_23.png') as ImageProvider :
                          NetworkImage('$companyImage')
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        isUser == 'true' ? userFirstName??'Loading..' : companyName??'Loading..',
                        style: TextStyle(
                            fontSize: 16 ,
                            color: mainColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: mainFont),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Icon(Icons.arrow_drop_down_sharp),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}