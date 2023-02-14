import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_tut/ui/auth/login_screen.dart';
import 'package:firebase_tut/ui/post/add_post.dart';
import 'package:firebase_tut/utils/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchfilter = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('PostScreen'),
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
            }).onError((error, stackTrace){
              Utils().toastMessage(error.toString());
            });
          }, icon: Icon(Icons.logout_outlined)),
          SizedBox(width: 10,)
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
              controller: searchfilter,
              decoration: InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder()
              ),
              onChanged: (String value){
                setState(() {
                  
                });
              },
            ),
          ),
          // Expanded(child: StreamBuilder(
          //   stream: ref.onValue,
          //   builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
          //     if(!snapshot.hasData){
          //       return CircularProgressIndicator();
          //     }
          //     else{
          //       Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
          //       List<dynamic> list = [];
          //       list.clear();
          //       list = map.values.toList();
          //       return ListView.builder(
          //       itemCount: snapshot.data!.snapshot.children.length,
          //         itemBuilder: (context,index){
          //       return ListTile(
          //         title: Text(list[index]['title']),
          //         subtitle: Text(list[index]['id']),
          //       );
          //     });}
          //   },
          // )),
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: Text('Loading'),
                itemBuilder: (context, snaphot, animation, index){
                  final title = snaphot.child('title').value.toString();
                  if(searchfilter.text.isEmpty){
                    return ListTile(
                      title: Text(snaphot.child('title').value.toString()),
                      subtitle: Text(snaphot.child('id').value.toString()),
                    );
                  }else if(title.toLowerCase().contains(searchfilter.text.toLowerCase().toString())){
                    return ListTile(
                      title: Text(snaphot.child('title').value.toString()),
                      subtitle: Text(snaphot.child('id').value.toString()),
                    );
                  }
                  else{
                    return Container();
                  }
                }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddPostScreen()));
          },
        child: Icon(Icons.add),
      ),
    );
  }
}
