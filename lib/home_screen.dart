// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codered/fire_crud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  bool subscriber = false;
  bool updateSubscriber = false;
  User? user = FirebaseAuth.instance.currentUser;
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Code Red With Sharjeel"),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(hintText: "Name"),
          ),

          ElevatedButton(
              onPressed: () async  {
               await db.collection('sharjeel').add({'name': nameController.text, 'subscribe': subscriber});
                setState(() {
                  subscriber = !subscriber;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Subscribed"), backgroundColor: Colors.green,)
                );
              },
              child: subscriber == false
                  ? const Text("Subscribe")
                  : const Text("Subscribed")
            ),

          StreamBuilder(
              stream: db.collection('sharjeel').snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, int index) {
                          DocumentSnapshot documentSnapshot =
                              snapshot.data.docs[index];
                          return ListTile(
                              title: Text(documentSnapshot['name']),
                              trailing: IconButton(
                                  onPressed: () {
                                    db.collection('sharjeel').doc(documentSnapshot.id).delete();
                                     ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text("Deleted"), backgroundColor: Colors.red,));
                                  },
                                  icon: const Icon(Icons.delete)),
                              leading: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      updateSubscriber = !updateSubscriber;
                                    });
                                    print(subscriber);
                                    db.collection('sharjeel').doc(documentSnapshot.id).update({
                                      'subscribe': subscriber,
                                    });
                                     ScaffoldMessenger.of(context).showSnackBar(
                                     const SnackBar(content: Text("Unsubscribed"), backgroundColor: Colors.amber,));
                                  },
                                  child: documentSnapshot['subscribe'] != false
                                      ? const Text("Subscribe")
                                      : const Text("Subscribed")));
                        }),
                  );
                }
              })
        ],
      ),
    );
  }
}
