import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proj/pages/editvm.dart';
import 'package:proj/pages/homevd.dart';
import 'package:proj/pages/homevm.dart';
import 'package:proj/pages/mnvd.dart';
import 'package:proj/pages/returnvd.dart';

class mnvmPage extends StatefulWidget {
  const mnvmPage({ Key? key }) : super(key: key);
  

  @override
  State<mnvmPage> createState() => _mndmPageState();
}
  CollectionReference Vm = FirebaseFirestore.instance.collection('Vm');

  Future<void> deleteProduct({required String id}) {
    return Vm
        .doc(id)
        .delete()
        .then((value) => print("Deleted data Successfully"))
        .catchError((error) => print("Failed to delete user: $error"));
  }


class _mndmPageState extends State<mnvmPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _vrcarController = TextEditingController();
  final _dateCotroller = TextEditingController();
  final _telCotroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('จัดการข้อมูลรายเดือน'),

        
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
            padding: const EdgeInsets.only(top: 40),
            shrinkWrap: true,
            children: [
             
              showRealtimeChange(),
            ],
          ),
        ),
      ),
    );
  }

  Widget showRealtimeChange() {
    return Column(
      children: [
        Text("รายการฝากรถรายเดือน\n",style: TextStyle(fontSize: 30.0,
              
                   fontStyle: FontStyle.normal),),

      
        createRealTimeData(),
        const Divider(),
      ],
    );
  }

  Widget createRealTimeData() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Vm").snapshots(),
      builder: (context, snapshot) {
        print("Realtime Change");
        print(snapshot.connectionState);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          print(snapshot.data!.docs);
          return Column(
            children: createDataList(snapshot.data),
          );
        }
      },
    );
  }


  List<Widget> createDataList(QuerySnapshot<Map<String, dynamic>>? data) {
    List<Widget> widgets = [];
    widgets = data!.docs.map((doc) {
      var data = doc.data();
      print(data['product_name']);
      return ListTile(
        onTap: () {
          print(doc.id);
          // ดึงข้อมูล มาแสดง เพื่อแก้ไข
        },
        title: Text(
            data['username'] + ", " + data['Ncar'] .toString() ),
        subtitle: Text("รายเดือน"),
        trailing: IconButton(
            onPressed: () {
              print("Delete");
              showConfirmDialog(doc.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            )
            
            ),
              leading: IconButton(
            onPressed: () {
            Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => editvmPage(id: doc.id),
                        ),
                      ).then((value) => setState(() {}));
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.orange,
            ),

            ),
      



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
              FirebaseFirestore.instance.collection("Vm").doc(id).delete();
            },
            child: Text("Delete")),
      ],
    );
    showDialog(
      context: context,
      builder: (context) => dialog,
    );
  }


}
