import 'package:flutter/material.dart';

class ListViewUnpaid extends StatefulWidget {
  const ListViewUnpaid({super.key});

  @override
  State<ListViewUnpaid> createState() => _ListViewUnpaidState();
}

class _ListViewUnpaidState extends State<ListViewUnpaid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Color.fromARGB(255, 170, 170, 170),
      ),
      height: 300,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 5 /*desksItems.length*/,
          itemBuilder: (context, index) {
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      Text('1x'),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Cola'),
                      Expanded(child: SizedBox()),
                      Text('2,50 €'),
                    ],
                  ), // Mit Listeneintrag füllen
                ),
                if (index <= 100 /*desksItems.length*/)
                  const Divider(
                    thickness: 0.3,
                    color: Colors.black,
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
