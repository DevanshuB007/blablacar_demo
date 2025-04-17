import 'package:flutter/material.dart';

class popfromup extends StatelessWidget {
  const popfromup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 50),
              child: IconButton(
                  icon: const Icon(Icons.star),
                  onPressed: () {
                    showGeneralDialog(
                      context: context,
                      barrierDismissible: true,
                      transitionDuration: Duration(milliseconds: 500),
                      barrierLabel:
                          MaterialLocalizations.of(context).dialogLabel,
                      barrierColor: Colors.black.withOpacity(0.5),
                      pageBuilder: (context, _, __) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              color: Colors.white,
                              child: Card(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: <Widget>[
                                    ListTile(
                                      title: Text('Item 1'),
                                      onTap: () =>
                                          Navigator.of(context).pop('item1'),
                                    ),
                                    ListTile(
                                      title: Text('Item 2'),
                                      onTap: () =>
                                          Navigator.of(context).pop('item2'),
                                    ),
                                    ListTile(
                                      title: Text('Item 3'),
                                      onTap: () =>
                                          Navigator.of(context).pop('item3'),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                      transitionBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeOut,
                          ).drive(Tween<Offset>(
                            begin: Offset(0, -1.0),
                            end: Offset.zero,
                          )),
                          child: child,
                        );
                      },
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
