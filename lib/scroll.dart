import 'package:flutter/material.dart';
import 'package:infinite_listview/infinite_listview.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.4,
            child: InfiniteListView.builder(itemBuilder: (context, index) {
              return Center(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6 * 0.25,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Card(
                    child: ListTile(
                      title: const Text('Vertical'),
                      subtitle: Text('vertical box № $index'),
                    ),
                  ),
                ),
              );
            }),
          ),
          const Divider(
            color: Colors.black,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: InfiniteListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.width * 0.6,
                    child: Card(
                      child: ListTile(
                        title: const Text('Horizontal'),
                        subtitle: Text('horizontal box № $index'),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
