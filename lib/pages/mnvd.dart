import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:proj/pages/editvd.dart';
import 'package:proj/pages/homevd.dart';
import 'package:proj/pages/homevm.dart';
import 'package:proj/pages/mnvm.dart';
import 'package:proj/pages/returnvd.dart';

class mnvdPage extends StatefulWidget {
  const mnvdPage({ Key? key }) : super(key: key);
  

  @override
  State<mnvdPage> createState() => _mndvPageState();
}
  CollectionReference Vd = FirebaseFirestore.instance.collection('Vd');

  Future<void> deleteProduct({required String id}) {
    return Vd
        .doc(id)
        .delete()
        .then((value) => print("Deleted data Successfully"))
        .catchError((error) => print("Failed to delete user: $error"));
  }



class _mndvPageState extends State<mnvdPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _vrcarController = TextEditingController();
  final _dateCotroller = TextEditingController();
  final _telCotroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('จัดการข้อมูลรายวัน'),

        
      ),
      drawer: Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
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
            padding: const EdgeInsets.only(top: 57),
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
       Text("รายการฝากรถรายวัน\n",style: TextStyle(fontSize: 30.0,

                   fontStyle: FontStyle.normal),),
        createRealTimeData(),
        const Divider(),
      ],
    );
  }

  Widget createRealTimeData() {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Vd").snapshots(),
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
      
      return ListTile(
        onTap: () {
          print(doc.id);
          // ดึงข้อมูล มาแสดง เพื่อแก้ไข
        },
        title: Text(
            data['username'] + ", " + data['Ncar'] .toString() ),
        subtitle: Text("รายวัน"),
        trailing:
         IconButton(
            onPressed: () {
              print("Delete");
              showConfirmDialog(doc.id);
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ),

            ),



            leading: IconButton(
            onPressed: () {
            Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => editvdPage(id: doc.id),
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
              FirebaseFirestore.instance.collection("Vd").doc(id).delete();
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
