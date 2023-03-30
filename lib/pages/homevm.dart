import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj/pages/mnvd.dart';
import 'package:proj/pages/homevd.dart';
import 'package:proj/pages/mnvm.dart';
import 'package:proj/pages/returnvd.dart';

class HomevmPage extends StatefulWidget {
  const HomevmPage({super.key});

  @override
  State<HomevmPage> createState() => _HomevmPageState();
}

class _HomevmPageState extends State<HomevmPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _vrcarController = TextEditingController();
  final _dateCotroller = TextEditingController();
  final _telCotroller = TextEditingController();
  final _brandCotroller = TextEditingController();
  final _colorCotroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      drawer: Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
           child: Text('ฝากรถรายเดือน'),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('ฝากรถรายวัน'),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(
                    builder: (context) => const HomevdPage(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.train,
            ),
            title: const Text('ฝากรถรายเดือน'),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(
                    builder: (context) => const HomevmPage(),
                  ));
            },
          ),
           ListTile(
            leading: Icon(
              Icons.train,
            ),
            title: const Text('รายการฝากรถรายวัน'),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(
                    builder: (context) => const mnvdPage(),
                  ));
            },
          ),
           ListTile(
            leading: Icon(
              Icons.train,
            ),
            title: const Text('รายการฝากรถรายเดือน'),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(
                    builder: (context) => const mnvmPage(),
                  ));
            },
          ),
         ListTile(
            leading: Icon(
              Icons.train,
            ),
            title: const Text('คืนรถ(รายวัน)'),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(
                    builder: (context) => const returnvdPage(),
                  ));
            },
          ),





          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('ออกจากระบบ'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              addDataSection(),
              // showOnetimeRead(),
              // showRealtimeChange(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget showRealtimeChange() {
  //   return Column(
  //     children: [
  //       const Text("Real Time Change"),
  //       createRealTimeData(),
  //       const Divider(),
  //     ],
  //   );
  // }

  // Widget createRealTimeData() {
  //   return StreamBuilder(
  //     stream: FirebaseFirestore.instance.collection("Product").snapshots(),
  //     builder: (context, snapshot) {
  //       print("Realtime Change");
  //       print(snapshot.connectionState);
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return const CircularProgressIndicator();
  //       } else {
  //         print(snapshot.data!.docs);
  //         return Column(
  //           children: createDataList(snapshot.data),
  //         );
  //       }
  //     },
  //   );
  // }

  // // Widget showOnetimeRead() {
  // //   return Column(
  // //     children: [
  // //       Row(
  // //         children: [
  // //           const Expanded(child: Text("One Time Read")),
  // //           IconButton(
  // //               onPressed: () {
  // //                 setState(() {});
  // //               },
  // //               icon: const Icon(Icons.refresh))
  // //         ],
  // //       ),
  // //       createOnetimeReadData(),
  // //       const Divider(),
  // //     ],
  // //   );
  // // }

  // Widget createOnetimeReadData() {
  //   return FutureBuilder(
  //     future: FirebaseFirestore.instance.collection("Product").get(),
  //     builder: (context, snapshot) {
  //       print("Onetime");
  //       print(snapshot.connectionState);
  //       if (snapshot.connectionState == ConnectionState.done) {
  //         print(snapshot.data!.docs);
  //         return Column(
  //           children: createDataList(snapshot.data),
  //         );
  //       } else {
  //         return const Text("Waiting Data");
  //       }
  //     },
  //   );
  // }

  List<Widget> createDataList(QuerySnapshot<Map<String, dynamic>>? data) {
    List<Widget> widgets = [];
    widgets = data!.docs.map((doc) {
      var data = doc.data();
      print(data['username']);
      return ListTile(
        onTap: () {
          print(doc.id);
          // ดึงข้อมูล มาแสดง เพื่อแก้ไข
        },
        title: Text(
            data['username'] + ", " + data['cars'].toString() + ","),
        subtitle: Text(data['type']),
        trailing: IconButton(
            onPressed: () {
              print("Delete");
              showConfirmDialog(doc.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            )),
      );
    }).toList();

    return widgets;
  }

  void showConfirmDialog(String id) {
    var dialog = AlertDialog(
      title: const Text("ลบข้อมูล"),
      content: Text("ต้องการลบข้อมูลเอกสารรหัส $id"),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Back")),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.red[300]),
                foregroundColor: const MaterialStatePropertyAll(Colors.white)),
            onPressed: () {
              FirebaseFirestore.instance.collection("Uname").doc(id).delete();
            },
            child: Text("Delete")),
      ],
    );
    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }



//  child: Container(
//               padding: const EdgeInsets.only(top: 170),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     margin: const EdgeInsets.only(left: 35, right: 35),
//                     child: Column(
//                       children: [


  Widget addDataSection() {
    return Form(
      key: _formKey,
      
      child: Container(
        padding: const EdgeInsets.only(top: 57),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
               margin: const EdgeInsets.only(left: 35, right: 35),
               child: Column(
                children: [
                   Text("ฝากรถรายเดือน\n",style: TextStyle(fontSize: 30.0,

                   fontStyle: FontStyle.normal),),

                     const Divider(),

          TextFormField
          (
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: "ชื่อ-นามสกุล",
            ),
           
           
          ),

         TextFormField(
            controller: _telCotroller,
            decoration: const InputDecoration(
              labelText: "เบอร์โทรศัพท์",
             
              ),
          ),

  

          TextFormField(
            controller: _vrcarController,
            decoration: const InputDecoration(
              labelText: "เลขทะเบียน",
              ),
          ),

           TextFormField(
            controller: _brandCotroller,
            decoration: const InputDecoration(
              labelText: "ยี่ห้อรถ",
              ),
          ),

           TextFormField(
            controller: _colorCotroller,
            decoration: const InputDecoration(
              labelText: "สีรถ",
              ),
          ),



         
           TextField(
                controller: _dateCotroller, //editing controller of this TextField
                decoration: InputDecoration( 
                   icon: Icon(Icons.calendar_today), //icon of text field
                   labelText: "วันที่ฝากรถ", //label text of field
                ),
                readOnly: true,  //set it true, so that user will not able to edit text
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context, initialDate: DateTime.now(),
                      firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101)
                  );
                  
                  if(pickedDate != null ){
                      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 
                      print(formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                      setState(() {
                         _dateCotroller.text = formattedDate; //set output date to TextField value. 
                      });
                  }else{
                      print("Date is not selected");
                  }
                },
             ),


             
      
            ElevatedButton(
            onPressed: () {
              FirebaseFirestore.instance.collection("Vm").add({
                "username": _nameController.text,
                "Ncar": _vrcarController.text,
                "date":_dateCotroller.text,
                "tel":_telCotroller.text,
                "brand":_brandCotroller.text,
                "color":_colorCotroller.text,
              });
              _formKey.currentState!.reset();
            },

            child: const Text("Save"),
          ),
          const Divider(),


                ],

               ),

            )
          ],

        ),
      
  
      ),
    );
  }
}
