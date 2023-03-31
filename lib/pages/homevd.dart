import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proj/pages/mnvd.dart';
import 'package:proj/pages/homevm.dart';
import 'package:proj/pages/mnvm.dart';
import 'package:proj/pages/namereturnvd.dart';
import 'package:proj/pages/returnvd.dart';


class HomevdPage extends StatefulWidget {
  const HomevdPage({super.key});

  @override
  State<HomevdPage> createState() => _HomevdPageState();
}

class _HomevdPageState extends State<HomevdPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _vrcarController = TextEditingController();
  final _dateCotroller = TextEditingController();
  final _telCotroller = TextEditingController();
  final _amountCotroller = TextEditingController();
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
                 child:  CircleAvatar(
  backgroundColor: Color(0xffE6E6E6),

  child: Icon(
    Icons.person,
    color: Color(0xffCCCCCC),
   
  
  ),


),
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
              Icons.car_crash,
            ),
            title: const Text('จัดการข้อมูลรายวัน'),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(
                    builder: (context) => const mnvdPage(),
                  ));
            },
          ),
           ListTile(
            leading: Icon(
              Icons.car_crash,
            ),
            title: const Text('จัดการข้อมูลรายเดือน'),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(
                    builder: (context) => const mnvmPage(),
                  ));
            },
          ),
  ListTile(
            leading: Icon(
              Icons.car_crash,
            ),
            title: const Text('คืนรถ(รายวัน)'),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(
                    builder: (context) => const rmnvdPage(),
                  ));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.car_crash,
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
                   Text("ฝากรถรายวัน\n",style: TextStyle(fontSize: 30.0,

                   fontStyle: FontStyle.normal),),

                   const Divider(),

                      

         
                    


    
          TextFormField
          (
          
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: "ชื่อ-นามสกุล",
            ),
             validator: (value) {
    if (value!.isEmpty) {
    return 'Enter text';
    }
    return null;
    },
           
           
          ),

         TextFormField(
   
            controller: _telCotroller,
            decoration: const InputDecoration(
              labelText: "เบอร์โทรศัพท์",
             
              ),
               validator: (value) {
    if (value!.isEmpty) {
    return 'Enter text';
    }
    return null;
    },
          ),

  

          TextFormField(
          
            controller: _vrcarController,
            decoration: const InputDecoration(
              labelText: "เลขทะเบียน",
              ),
               validator: (value) {
    if (value!.isEmpty) {
    return 'Enter text';
    }
    return null;
    },
          ),


              TextFormField(
               
            controller: _amountCotroller,
            decoration: const InputDecoration(
              labelText: "จำนวนเงินที่ได้รับ",
              ),
               validator: (value) {
    if (value!.isEmpty) {
    return 'Enter text';
    }
    return null;
    },
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
              FirebaseFirestore.instance.collection("Vd").add({
                "username": _nameController.text,
                "Ncar": _vrcarController.text,
                "date":_dateCotroller.text,
                "tel":_telCotroller.text,
                "amount":_amountCotroller.text,
              
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
