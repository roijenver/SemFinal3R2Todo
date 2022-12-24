import 'package:untitled/form_page.dart';
import 'package:flutter/material.dart';
import 'db_helper.dart';
import 'classes.dart';
import 'todo_widget.dart';

class PageOne extends StatefulWidget {
  const PageOne({Key? key}) : super(key: key);

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("TODO"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const FormPage()));
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
        body: FutureBuilder<List<Todo>?>(
          future: dbHelper.getAllTodo(),
          builder: (context, AsyncSnapshot<List<Todo>?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              if (snapshot != null) {
                return ListView.builder(
                  itemBuilder: (context, index) => TodoWidget(
                    todo: snapshot.data![index],
                    onTap: () async {
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FormPage(todo: snapshot.data![index],)));
                      setState(() {});
                    },
                    onLongPress: () async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title:
                              const Text('You want to delete?'),
                              actions: [
                                ElevatedButton(
                                  onPressed: () async {
                                    await dbHelper
                                        .deleteTodo(snapshot.data![index]);
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: const Text('YES'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('NO'),
                                ),
                              ],
                            );
                          });
                    },
                  ),
                  itemCount: snapshot.data!.length,
                );
              }
              return const Center(
                child: Text('NO TODO'),
              );
            }
            return const SizedBox.shrink();
          },
        ));
  }
}
