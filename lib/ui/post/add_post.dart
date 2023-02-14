import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_tut/utils/utils.dart';
import 'package:firebase_tut/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  final postController = TextEditingController();
  bool loading = false;
  final databaseRef = FirebaseDatabase.instance.ref('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            SizedBox(height: 30,),
            TextFormField(
              maxLines: 4,
              controller: postController,
              decoration: InputDecoration(
                hintText: 'Whats in ur mind?',
                border: OutlineInputBorder()
              ),
            ),
            SizedBox(height: 30,),
            RoundButton(title: 'Add',
                loading: loading,
                onTap: (){
              setState(() {
                loading = true;
              });
              databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).child('Comments').set({
                'title' : postController.text.toString(),
                'id' : DateTime.now().millisecondsSinceEpoch.toString()
              }).then((value){
              Utils().toastMessage('POST ADDED');
              setState(() {
                loading = false;
              });
              }).onError((error, stackTrace){
                Utils().toastMessage(error.toString());
                setState(() {
                  loading = false;
                });
              });
            })
          ],
        ),
      ),
    );
  }
}
