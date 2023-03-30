import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj/pages/homevd.dart';
import 'package:proj/pages/mnvd.dart';
import 'package:proj/pages/homevm.dart';
import 'package:proj/pages/mnvm.dart';
import 'package:proj/pages/returnvd.dart';


class editvdPage extends StatefulWidget {
  const editvdPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<editvdPage> createState() => _editvdPageState();

}


  class _editvdPageState extends State<editvdPage> {


  
  // ignore: prefer_final_fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _vrcarController = TextEditingController();
 

  
  CollectionReference Vd = FirebaseFirestore.instance.collection('Vd');


Future<void> updateProduct() {
    return Vd.doc(widget.id).update({
      'username': _nameController.text,
      'Ncar': _vrcarController.text,
    }).then((value) {
      print("Data updated successfully");
      Navigator.pop(context);
    }).catchError((error) => print("Failed to update user: $error"));
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('แก้ไขข้อมูลฝากรถรายวัน'),
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
              editformfield(context)
              // showOnetimeRead(),
              // showRealtimeChange(),
            ],
          ),
        ),
      ),
    );
  }


Widget editformfield(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: Vd.doc(widget.id).get(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;

          _nameController.text = data['username'];
          _vrcarController .text = data['Ncar'];

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(top: 57),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 35, right: 35),
                    child: Column(
                      children: [

                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            label: Text(
                              'ชื่อ',
                
                            ),
                          ),
                        ),
                      





                        TextFormField(
                          controller: _vrcarController,
                          decoration: InputDecoration(
                            label: Text(
                              'ทะเบียนรถ',
                            ),
                           
                          
                          ),
                        ),




                        // const SizedBox(
                        //   height: 30,
                        // ),
                        // const SizedBox(
                        //   height: 40,
                        // ),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //   children: [
                        //     Text(
                        //       'บันทึกข้อมูล',
                        //       style: TextStyle(
                        //           color: Colors.black,
                        //           fontSize: 27,
                        //           fontWeight: FontWeight.w700),
                        //     ),
                        //     CircleAvatar(
                        //       radius: 30,
                        //       backgroundColor:
                        //           Color.fromARGB(255, 238, 204, 231),
                        //       child: IconButton(
                        //           color: Colors.pink,
                        //           onPressed: updateProduct,
                        //           icon: const Icon(
                        //             Icons.arrow_forward,
                        //           )),
                        //     )
                        //   ],
                        // ),

 ElevatedButton(
            onPressed: updateProduct,
            child: const Text("Save"),
          ),

                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return const Text('Loading');
      },
    );
  }
}

