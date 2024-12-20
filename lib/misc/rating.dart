import 'package:flutter/material.dart';
import 'slide_list_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'graph.dart';

class MiscShowcase extends StatelessWidget {
  void _launchURL() async {
    const url = 'https://github.com/The-Young-Programer/FlutterScreens';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget _buildSection(
      String title, String description, Widget component, String codeSnippet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
          ),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 16, color: Colors.grey[700]),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: component,
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Text(
            codeSnippet,
            style: TextStyle(fontFamily: 'monospace', fontSize: 14),
          ),
        ),
        Divider(height: 32),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Misc Components'),
        actions: [
          ElevatedButton.icon(
            onPressed: _launchURL,
            icon: Icon(Icons.code),
            label: Text('View Code'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              'Rating Widget',
              'A customizable star rating widget with tap and drag functionality',
              Rating(
                initialRating: 3,
                onRated: (rating) {
                  print('Rating: $rating');
                },
              ),
              '''Rating(
  initialRating: 3,
  onRated: (rating) {
    print('Rating: \$rating');
  },
)''',
            ),
            _buildSection(
              'Slide List View',
              'A widget that toggles between two views with a 3D rotation animation',
              Container(
                height: 300,
                child: SlideListView(
                  view1: Container(
                    color: Colors.blue[100],
                    child: Center(child: Text('View 1')),
                  ),
                  view2: Container(
                    color: Colors.green[100],
                    child: Center(child: Text('View 2')),
                  ),
                  showFloatingActionButton: true,
                  enabledSwipe: true,
                ),
              ),
              '''SlideListView(
  view1: YourFirstView(),
  view2: YourSecondView(),
  showFloatingActionButton: true,
  enabledSwipe: true,
  floatingActionButtonColor: Colors.blue,
  floatingActionButtonIcon: AnimatedIcons.view_list,
  duration: Duration(milliseconds: 400),
)''',
            ),
            _buildSection(
              'Animated Graph',
              'An animated sine wave graph with a moving dot',
              Container(
                height: 300,
                child: Graph(),
              ),
              '''Graph(
  // Animated sine wave graph with moving dot
  // Uses CustomPaint and AnimationController
  // See graph.dart for implementation details
)''',
            ),
          ],
        ),
      ),
    );
  }
}

class Rating extends StatefulWidget {
  final int? initialRating;
  final void Function(int)? onRated;
  final double size;
  final Color color;

  Rating(
      {this.initialRating,
      this.onRated,
      this.size = 18.0,
      this.color = Colors.amber});

  @override
  _RatingState createState() => _RatingState();
}

class _RatingState extends State<Rating> {
  int _rating = 0;
  GlobalKey _starOneKey = GlobalKey();
  GlobalKey _starTwoKey = GlobalKey();
  GlobalKey _starThreeKey = GlobalKey();
  GlobalKey _starFourKey = GlobalKey();
  GlobalKey _starFiveKey = GlobalKey();
  bool _isDragging = false;

  _updateRating(int newRating) {
    if (_rating == 1 && newRating == 1 && _isDragging != true) {
      setState(() {
        _rating = 0;
        widget.onRated!(0);
      });
    } else {
      setState(() {
        _rating = newRating;
        widget.onRated!(newRating);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (DragStartDetails details) {
        _isDragging = true;
      },
      onHorizontalDragUpdate: (DragUpdateDetails details) {
        RenderBox? star1 =
            _starOneKey.currentContext!.findRenderObject() as RenderBox?;
        final Offset positionStar1 = star1!.localToGlobal(Offset.zero);
        final sizeStar1 = star1.size;

        RenderBox? star2 =
            _starTwoKey.currentContext!.findRenderObject() as RenderBox?;
        final positionStar2 = star2!.localToGlobal(Offset.zero);
        final sizeStar2 = star2.size;

        RenderBox? star3 =
            _starThreeKey.currentContext!.findRenderObject() as RenderBox?;
        final positionStar3 = star3!.localToGlobal(Offset.zero);
        final sizeStar3 = star3.size;

        RenderBox? star4 =
            _starFourKey.currentContext!.findRenderObject() as RenderBox?;
        final positionStar4 = star4!.localToGlobal(Offset.zero);
        final sizeStar4 = star4.size;

        RenderBox? star5 =
            _starFiveKey.currentContext!.findRenderObject() as RenderBox?;
        final positionStar5 = star5!.localToGlobal(Offset.zero);
        final sizeStar5 = star5.size;

        if (details.globalPosition.dx < positionStar1.dx) {
          print(details.globalPosition.dx.toString() +
              " " +
              positionStar1.dx.toString());
          _updateRating(0);
        } else if (details.globalPosition.dx > positionStar1.dx &&
            details.globalPosition.dx < (positionStar1.dx + sizeStar1.width)) {
          _updateRating(1);
        } else if (details.globalPosition.dx > positionStar2.dx &&
            details.globalPosition.dx < (positionStar2.dx + sizeStar2.width)) {
          _updateRating(2);
        } else if (details.globalPosition.dx > positionStar3.dx &&
            details.globalPosition.dx < (positionStar3.dx + sizeStar3.width)) {
          _updateRating(3);
        } else if (details.globalPosition.dx > positionStar4.dx &&
            details.globalPosition.dx < (positionStar4.dx + sizeStar4.width)) {
          _updateRating(4);
        } else if (details.globalPosition.dx > positionStar5.dx &&
            details.globalPosition.dx < (positionStar5.dx + sizeStar5.width)) {
          _updateRating(5);
        } else if (details.globalPosition.dx >
            (positionStar1.dx + sizeStar1.width)) {
          _updateRating(5);
        }
      },
      onHorizontalDragEnd: (DragEndDetails details) {
        _isDragging = false;
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            key: _starOneKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Icon(
                _rating >= 1 ? Icons.star : Icons.star_border,
                color: widget.color,
                size: widget.size,
              ),
            ),
            onTap: () => _updateRating(1),
          ),
          GestureDetector(
            key: _starTwoKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Icon(
                _rating >= 2 ? Icons.star : Icons.star_border,
                color: widget.color,
                size: widget.size,
              ),
            ),
            onTap: () => _updateRating(2),
          ),
          GestureDetector(
            key: _starThreeKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Icon(
                _rating >= 3 ? Icons.star : Icons.star_border,
                color: widget.color,
                size: widget.size,
              ),
            ),
            onTap: () => _updateRating(3),
          ),
          GestureDetector(
            key: _starFourKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Icon(
                _rating >= 4 ? Icons.star : Icons.star_border,
                color: widget.color,
                size: widget.size,
              ),
            ),
            onTap: () => _updateRating(4),
          ),
          GestureDetector(
            key: _starFiveKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Icon(
                _rating >= 5 ? Icons.star : Icons.star_border,
                color: widget.color,
                size: widget.size,
              ),
            ),
            onTap: () => _updateRating(5),
          ),
        ],
      ),
    );
  }
}
