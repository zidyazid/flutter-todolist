import 'package:flutter/material.dart';
// import 'package:todo_list/model.dart';
import 'package:todo_list/repository.dart';
import 'package:ndialog/ndialog.dart';

class TodolistMain extends StatefulWidget {
  // const TodolistMain({ Key? key }) : super(key: key);

  @override
  State<TodolistMain> createState() => _TodolistMainState();
}

class _TodolistMainState extends State<TodolistMain> {
  List<dynamic> todo = [];
  Repository repository = Repository();

  getTodoData() async {
    todo = await repository.getAllData();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    getTodoData();
    super.initState();
  }

  Widget build(BuildContext context) {
    TextEditingController judulController = TextEditingController();
    TextEditingController deskripsiController = TextEditingController();

    var judul = "";
    var deskripsi = "";

    return Scaffold(
        appBar: AppBar(
          title: Text("TodoList Online App"),
          actions: [
            // tambah data
            TextButton(
                onPressed: () async {
                  await NDialog(
                    dialogStyle: DialogStyle(titleDivider: true),
                    title: Text("Tambah Data"),
                    content: Container(
                      height: 150,
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.blue[200],
                                borderRadius: BorderRadius.circular(8)),
                            child: TextField(
                              controller: judulController,
                              decoration:
                                  InputDecoration.collapsed(hintText: "Judul"),
                            ),
                          ),
                          SizedBox(height: 12),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Colors.blue[200],
                                borderRadius: BorderRadius.circular(8)),
                            child: TextField(
                              controller: deskripsiController,
                              decoration: InputDecoration.collapsed(
                                  hintText: "Deskripsi"),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              primary: Colors.white),
                          onPressed: () async {
                            judul = judulController.text;
                            deskripsi = deskripsiController.text;

                            bool response =
                                await repository.postData(judul, deskripsi);

                            getTodoData();

                            print(response);

                            setState(() {});
                          },
                          child: Text("Save"))
                    ],
                  ).show(context);
                },
                child: Icon(Icons.add, color: Colors.white))
          ],
          backgroundColor: Colors.black87,
        ),
        body: ListView(
            children: todo.map((e) {
          return Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: Colors.black87,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Judul :",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                e.judul,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          Row(
                            children: [
                              Text(
                                "Deskripsi :",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                e.deskripsi,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 24,
                    ),
                    Container(
                      // color: Colors.white,
                      // width: MediaQuery.of(context).size.width / 5 - 48,
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Edit data
                          TextButton(
                              onPressed: () async {
                                await NDialog(
                                  dialogStyle: DialogStyle(titleDivider: true),
                                  title: Text("Edit Data"),
                                  content: Container(
                                    height: 150,
                                    padding: EdgeInsets.all(24),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Colors.blue[200],
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: TextField(
                                            controller: judulController,
                                            decoration:
                                                InputDecoration.collapsed(
                                                    hintText: ""),
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: Colors.blue[200],
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          child: TextField(
                                            controller: deskripsiController,
                                            decoration:
                                                InputDecoration.collapsed(
                                                    hintText: "Deskripsi"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: Colors.blue,
                                            primary: Colors.white),
                                        onPressed: () {},
                                        child: Text("Save"))
                                  ],
                                ).show(context);
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 24,
                              )),
                          TextButton(
                              onPressed: () async {
                                bool response =
                                    await repository.deleteData(e.id);
                                print(e.id);

                                getTodoData();

                                WidgetsBinding.instance.addPostFrameCallback(
                                    (_) => setState(() {}));
                              },
                              child: Icon(Icons.delete, color: Colors.white)),
                        ],
                      ),
                    )
                  ],
                ),
              ));
        }).toList()));
  }
}
