import 'package:flutter/material.dart';
import 'package:ican/navBar.dart';

class TargetsPage extends StatefulWidget {
  const TargetsPage({super.key});

  @override
  State<TargetsPage> createState() => _TargetsPageState();
}

class _ArticleDescription extends StatelessWidget {
  const _ArticleDescription({
    required this.title,
    required this.author,
    required this.likesCount,
    required this.dislikesCount,
  });

  final String title;
  final String author;
  final int likesCount;
  final int dislikesCount;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                author,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(221, 255, 0, 0),
                ),
              ),
              const SizedBox(height: 5), 
              Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Container(
              margin: const EdgeInsets.all(10),
              height: 40.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.0),
                  side: const BorderSide(color: Color.fromRGBO(0, 0, 0, 1))),
                  //padding: const EdgeInsets.all(10.0),
                  backgroundColor: Color.fromARGB(255, 255, 0, 0),
                ),
                onPressed: () {},
                child: const Text(

                  "Перейти",
                  style: TextStyle(fontSize: 14,
                  color: Colors.black)),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children:[
              RichText(
                text: TextSpan(
                      style: const TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  children: [
                    TextSpan(text:  '$likesCount'),
                    const WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                        child: Icon(
                          Icons.thumb_up,
                          size: 15,
                          ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              RichText(
                text: TextSpan(
                      style: const TextStyle(
                      fontSize: 20.0,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  children: [
                    TextSpan(text:  '$dislikesCount'),
                    const WidgetSpan(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 0, 0, 0),
                        child: Icon(
                          Icons.thumb_down,
                          size: 15,
                          ),
                      ),
                    ),
                  ],
                ),
              ),
              ]
            ),
              //const Padding(padding: EdgeInsets.only(bottom: 2.0)),
            ],
          ),
        ),
      ],
    );
  }
}


@override
class _TargetsPageState extends State<TargetsPage> {
  Widget buildList(context) {
        return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: SizedBox(
        height: 200,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1.2,
              child: Image.asset('images/taz.jpg'),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.0, 10.0, 2.0, 0.0),
                child: _ArticleDescription(
                  title: 'Коплю на таз',
                  author: 'Username',
                  likesCount: 5,
                  dislikesCount: 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
        
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        toolbarHeight: MediaQuery.of(context).size.height * 0.08,
        centerTitle: true,
        title: Image.asset(
          'images/ICANicon.png',
          width: 180
        )
      ),
      drawer: const NavBar(),
      body:
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) => buildList(
              context,
            ),
          )
    );
  }
}