import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:savepy/app/Networking/url_provider.dart';
import 'package:savepy/app/UiElements/ColorSet.dart';
import 'package:savepy/app/UiElements/constColor.dart';
import 'package:savepy/app/UiElements/widget.dart';
import 'package:savepy/app/common/session_timeout.dart';
import 'package:savepy/app/modules/assign_member_to_group/model/search_member_model.dart';
import 'package:savepy/app/modules/group_detail/controller/group_detail_controller.dart';
import 'package:savepy/app/modules/group_detail/view/group_detail_view.dart';
import 'package:savepy/app/modules/member_list/model/member_list_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AssignMembers extends StatefulWidget {
  final String? groupId;

  const AssignMembers ({ Key? key, this.groupId }): super(key: key);
  @override
  _AssignMembersState createState() => _AssignMembersState();
}

class _AssignMembersState extends State<AssignMembers> {

  late List<Item> itemList;
  late List<Item> selectedList;
  late List<Item> searchItemList;
  late List<Item> searchSelectedList;
  late bool isSearched;
  late TextEditingController memberNameController;
  var memberList = <Userlist>[];
  var searchedMemberList = <SearchUserList>[];
  var members = <Members>[];
  var selectedMembers = <Members>[];
  var myList = <Userlist>[];
  var isMemberListLoading =false;
  bool isSelected =false;
  String groupArray='';
  String searchGroupArray='';
  late Dio _dio = Dio(BaseOptions(baseUrl:""));

  // Future<void> getMemberList(String groupId) async {
  //   itemList = [];
  //   selectedList = [];
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? token = prefs.getString('token');
  //   String? email = prefs.getString('email');
  //
  //   print(token);
  //
  //   try{
  //     isMemberListLoading=true;
  //     Map data = {
  //       "email": email,
  //       "group_id": groupId,
  //       // "deviceId": "",
  //       // "deviceType": Platform.isIOS ? '1' : '2'
  //     };
  //
  //     Options options = Options(
  //       headers: <String, String>{
  //         'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
  //         'Authorization': 'Bearer $token'
  //       },
  //     );
  //
  //     var response = await _dio.post(UrlProvider.memberListUrl(),options: options,data: data);
  //
  //     print("myprofile details>> ");
  //
  //     print(response);
  //     if (response.statusCode == 200) {
  //       if(response.data['message']=="Access denied")
  //       {
  //         Get.offAll(TimeOut());
  //       }
  //       if (response.data['flag'] == "true") {
  //
  //         MemberListModel memberListModel = MemberListModel.fromJson(response.data);
  //         memberList.assignAll(memberListModel.userlist!);
  //
  //         for(int i=0;i<memberList.length;i++)
  //         {
  //           if(memberList[i].belongToGroup==false) {
  //             itemList.add(Item('${memberList[i].id}',  '${memberList[i].email}', '${memberList[i].firstName} ${memberList[i].lastName}'));
  //           }
  //         }
  //
  //         print(itemList);
  //
  //         setState(() {
  //
  //         });
  //         isMemberListLoading=false;
  //       } else {
  //         // isMemberListLoading.value= 2;
  //       }
  //     } else if (response.statusCode != 200) {
  //       print("Status.ERROR");
  //       // isMemberListLoading.value=2;
  //       isMemberListLoading=false;
  //     }
  //   }catch(e){
  //     // log('Error while getting data is $e');
  //     print('Error while getting data is $e');
  //   }finally{
  //     // isDataLoading(false);
  //     isMemberListLoading=false;
  //   }
  //
  // }

  Future<void> searchMemberList(String groupId,String searchString) async {
    searchItemList = [];
    searchSelectedList = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');

    print(token);

    try{
      isMemberListLoading=true;
      Map data = {
        "search_usr": searchString,
        "group_id": groupId,
        // "deviceId": "",
        // "deviceType": Platform.isIOS ? '1' : '2'
      };

      Options options = Options(
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      var response = await _dio.post(UrlProvider.searchMemberUrl(),options: options,data: data);

      print("search details>> ");

      print(response);
      if (response.statusCode == 200) {
        if(response.data['message']=="Access denied")
        {
          Get.offAll(TimeOut());
        }
        if (response.data['flag'] == "true") {
          print(response.data);
          SearchMemberModel searchMemberModel = SearchMemberModel.fromJson(response.data);
          searchedMemberList.assignAll(searchMemberModel.userlist!);

          for(int i=0;i<searchedMemberList.length;i++)
          {
            if(searchedMemberList[i].assignGroupData==false) {
              searchItemList.add(Item('${searchedMemberList[i].id}',  '${searchedMemberList[i].email}', '${searchedMemberList[i].firstName} ${searchedMemberList[i].lastName}'));
            }
          }
          // searchSelectedList = [];
          // print("searchItemList");
          // print(searchItemList);


          setState(() {

          });
          isMemberListLoading=false;
        } else {
          // isMemberListLoading.value= 2;
        }
      } else if (response.statusCode != 200) {
        print("Status.ERROR");
        // isMemberListLoading.value=2;
        isMemberListLoading=false;
      }
    }catch(e){
      // log('Error while getting data is $e');
      print('Error while getting data is $e');
    }finally{
      // isDataLoading(false);
      isMemberListLoading=false;
    }

  }

  Future<void> assignGroup(String groupId,String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    String? email = prefs.getString('email');

    try{

      Options options = Options(
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
      );

      Map data = {
        "group_id": groupId,
        "user_id": userId,
      };
      final response = await http.post(
        Uri.parse(UrlProvider.assignGroupUrl()),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: data,
      );
      print(response.statusCode);
      // var response = await _dio.post(UrlProvider.assignGroupUrl(),options: options,data: data);
      // print(response.data);
      if(response.statusCode == 200){
        ///data successfully
        // var result = jsonDecode(response.data.toString());
        // print(response.data);

        // ;
        GroupDetailController _groupDetailController = Get.put(GroupDetailController(groupId));
        _groupDetailController.getMemberList(groupId);
        _groupDetailController.getGroupPaymentHistoryList(groupId);
        _groupDetailController.getPlanList(groupId).whenComplete(() => Navigator.pop(context));
        // user_model =  User_Model.fromJson(result);
        Fluttertoast.showToast(
            msg: "Member(s) assigned to the group",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black54,
            textColor: Colors.white,
            timeInSecForIosWeb: 1);

      }else{
        ///error
      }
    }catch(e){
      // log('Error while getting data is $e');
      print('Error while getting data is $e');
    }finally{

    }
  }

  @override
  void initState() {
    // getMemberList("${widget.groupId}");
    searchMemberList("${widget.groupId}","");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: Stack(
        children: [
          ListView.builder(
            // physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(10, 60, 10, 0),
              shrinkWrap: true,
              itemCount: searchItemList.length,
              itemBuilder: (context, index) {
                return GridItem(
                    item: searchItemList[index],
                    isSelected: (bool value) {
                      setState(() {
                        if (value) {
                          searchSelectedList.add(searchItemList[index]);
                        } else {
                          searchSelectedList.remove(searchItemList[index]);
                        }
                      });
                      print("$index : $value");
                    },
                    key: Key(searchItemList[index].name.toString()));
              }),
          Container(
            margin: EdgeInsets.fromLTRB(20,10,20,10),
            // width: width * 0.7,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15)),
            child:TextFormField(

              onFieldSubmitted: (r) {},
              onChanged: (r) {
                searchMemberList("${widget.groupId}",r.toString());
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20,10,20,10),
                  alignLabelWithHint: true,
                  hintText: 'Search members',
                  hintStyle: TextStyle(fontSize: 14),
                  border: OutlineInputBorder(
                    borderSide:  BorderSide(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:  BorderSide(width: 1, color: HexColor(blue_color)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:  BorderSide(width: 1, color: HexColor(blue_color)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:  BorderSide(width: 1, color: HexColor(blue_color)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide:  BorderSide(width: 1, color: HexColor(blue_color)),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      // focus.requestFocus();
                      // searchtextedit.clear();
                    },
                    child: Transform.scale(
                      scale: 0.5,
                      child: SvgPicture.asset(
                        'assets/images/search.svg',
                        // color: Colors.black,
                      ),
                    ),
                  )),
            ),
          ),
        ],
      )
    );
  }

  getAppBar() {
    return AppBar(
      backgroundColor: HexColor(blue_color),
      title: Text(searchSelectedList.length < 1
          ? "Members"
          : "${searchSelectedList.length} member(s) selected"),
      actions: <Widget>[
        searchSelectedList.length < 1
            ? Container()
            : InkWell(
            onTap: () {
              setState(() {
                Get.defaultDialog(
                    title: "Assign new members",
                    textCancel: "Cancel",
                    textConfirm: "Confirm",
                    onCancel: (){
                      // navigator.pop();
                    },
                    content: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipOval(
                          child:Image.asset("assets/images/logo.png",
                            height: 80,
                            width: 80,
                            fit:BoxFit.fitWidth,),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          'Are you sure you wants to add these member(s) to this group?',
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    buttonColor: Color(0xff004C88),
                    confirmTextColor: Colors.white,
                    cancelTextColor: Color(0xff004C88),
                    onConfirm: (){
                      groupArray="";

                      for (int i = 0; i < searchSelectedList.length; i++) {
                        // itemList.remove(selectedList[i]);
                        print(searchSelectedList[i].id);
                        // if(selectedList.length==1)
                        //   {
                        //     groupArray=selectedList[i].id;
                        //   }
                        // if(selectedList.length==2)
                        //   {
                        //     groupArray='${selectedList[0].id},${selectedList[1].id}';
                        //   }
                        if(searchSelectedList.isNotEmpty)
                        {
                          groupArray="$groupArray${searchSelectedList[i].id},";
                        }
                      }

                      String result = groupArray.substring(0, groupArray.length - 1);
                      groupArray= result;
                      searchSelectedList = [];
                      assignGroup("${widget.groupId}", groupArray).whenComplete(() => null);
                      print(groupArray);
                      Get.back();
                    },
                    // middleText: "Are you sure you want to logout?"

                );
              });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8,8,18,8),
              child: Icon(Icons.add_circle),
            ))
      ],
    );
  }
}

class Item {
  String id;
  String email;
  String name;

  Item(this.id,this.email,this.name);
}

class Members {
  String? id;
  String? email;
  String? name;
  bool? isSelected;

  Members({
    required this.id,
    required this.email,
    required this.name,
    required this.isSelected,
  });
}

class GridItem extends StatefulWidget {
  final Key key;
  final Item item;
  final ValueChanged<bool> isSelected;

  GridItem({required this.item, required this.isSelected, required this.key});

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
          widget.isSelected(isSelected);
        });
      },
      // child: Stack(
      //   children: <Widget>[
      //     Image.asset(
      //       widget.item.imageUrl,
      //       color: Colors.black.withOpacity(isSelected ? 0.9 : 0),
      //       colorBlendMode: BlendMode.color,
      //     ),
      //     isSelected
      //         ? Align(
      //       alignment: Alignment.bottomRight,
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Icon(
      //           Icons.check_circle,
      //           color: Colors.blue,
      //         ),
      //       ),
      //     )
      //         : Container()
      //   ],
      // ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0,5,0,5),
        child: InkWell(
          onTap: (){
            setState(() {
              isSelected = !isSelected;
              widget.isSelected(isSelected);
            });
             },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10,),
              isSelected? Icon(Icons.check_circle,color: HexColor(blue_color)):Icon(Icons.check_circle,color: Colors.grey,),
              SizedBox(width: 10,),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    textWidget(
                        widget.item.name,
                        16,
                        FontWeight.normal,
                        'Lato',
                        0xff000000,
                        '',
                        false),
                    textWidget(
                        widget.item.email,
                        14,
                        FontWeight.normal,
                        'Lato',
                        0xff000000,
                        '',
                        false),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}