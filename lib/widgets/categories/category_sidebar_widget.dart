import 'package:crossptodo/db_provider.dart';
import 'package:crossptodo/widgets/categories/new_category_button_widget.dart';
import 'package:flutter/material.dart';

import 'category_widget.dart';
import 'category_divider_widget.dart';

class CategorySideBar extends StatefulWidget {

  BuildContext contxt;
  VoidCallback updateStateCallback;
  Function pageTitleMethod;

  CategorySideBar({super.key, required this.contxt, required this.updateStateCallback, required this.pageTitleMethod});

  @override
  State<StatefulWidget> createState () => _CategorySideBarState();
}

class _CategorySideBarState extends State<CategorySideBar> {

  TextEditingController _controller = TextEditingController();
  String _errorText = "";
  
  @override
  Widget build (BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.height,
      padding: const EdgeInsets.all(10.0),
      color: Color.fromARGB(255, 34, 34, 34),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.0,
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      CategoryButtonWidget(openNewDialogCallback: newCategoryDialog, title: "New category", icon: Icons.add_box_rounded),
                    ],
                  ),
                ),
              ],
            ),
          ),
          CategoryDivider(),
          Expanded(
            child: FutureBuilder(
              future: DBProvider().getCategories(),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) =>
                        CategoryWidget(deleteCatCallback: removeCategoryFromList, sendPageTitleMethod: getPageTitle, id: snapshot.data![index].id, title: snapshot.data![index].title!)
                  );
                } else if (snapshot.hasError) {
                  return const Text("There was an error");
                }
                return const CircularProgressIndicator();
              }
            )
          )
        ],
      )
    );
  }

  void getPageTitle (String title) {
    widget.pageTitleMethod(title);
  }

  void removeCategoryFromList (int id, String category) async {
    await DBProvider().deleteCategory(id, category);
    widget.updateStateCallback();
    getPageTitle("");
  }

  void newCategoryDialog () {
    showDialog(
      context: widget.contxt,
      builder: (context) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.black,
        title: const Text(
          "Add a new category",
          style: TextStyle(
            color: Colors.white
          ),
        ),
        content: TextField(
          controller: _controller,
          style: const TextStyle(
            color: Colors.white
          ),
          decoration: InputDecoration(
            hintText: "Add a new task here...",
            hintStyle: TextStyle(
              color: Colors.grey.shade400
            ),
            isDense: true,
            filled: true,
            fillColor: const Color.fromARGB(255, 24, 24, 24),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 24, 24, 24),
                width: 2.0
              )
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 24, 24, 24),
                width: 2.0
              )
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              )
            ),
            onPressed: () => Navigator.of(widget.contxt).pop(),
            child: const Text(
              "Cancel",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)
              )
            ),
            onPressed: () => updateCategoryList(),
            child: const Text(
              "Create",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          )
        ],
      )
    );
  }

  void updateCategoryList () async {
    if (_controller.text.isNotEmpty) {
      if (await DBProvider().categoryExists(_controller.text.toString())) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Category '${_controller.text.toString()}' already exists"))
        );
      } else {
        await DBProvider().createCategory(_controller.text.toString());
        _controller.text = "";
        Navigator.of(context).pop();
        widget.updateStateCallback();
      }
      
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Category can't be empty"))
      );
    }
  }
}