import 'package:crossptodo/db_provider.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  Function deleteCatCallback;
  Function sendPageTitleMethod;
  int id;
  String title;

  CategoryWidget({super.key, required this.deleteCatCallback, required this.sendPageTitleMethod, required this.id, required this.title});

  @override
  Widget build (BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 43, 43, 43),
          borderRadius: BorderRadius.circular(30.0)
        ),
        child: ListTile(
          onTap: () => sendPageTitleMethod(title),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600
            ),
          ),
          leading: Container(
            width: 20.0,
            height: 20.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20.0)
            ),
            child: FutureBuilder(
              future: DBProvider().getCategoryTaskCount(title),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return Text(
                    snapshot.data!.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0
                    ),
                  );
                }
                return CircularProgressIndicator();
              }
            )
          ),
          trailing: IconButton(
            onPressed: () async {
              int count = await DBProvider().getCategoryTaskCount(title);
              count < 1 ? deleteCatCallback(id, title) :
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  insetPadding: EdgeInsets.zero,
                  backgroundColor: Colors.black,
                  title: const Text(
                    "Are you sure?",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                  content: const Text(
                    "Removing the category will delete all tasks within the category",
                    style: TextStyle(
                      color: Colors.white
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
                      onPressed: () => Navigator.of(context).pop(),
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
                      onPressed: () {
                        deleteCatCallback(id, title);
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Delete",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                    )
                  ],
                )
              );
            },
            icon: Icon(Icons.delete_rounded, color: Colors.grey.shade400),
          ),
        )
      )
    );
  }
}