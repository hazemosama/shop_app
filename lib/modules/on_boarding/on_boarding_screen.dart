import 'package:flutter/material.dart';
import 'package:shopapp/modules/login/shop_login_screen.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/network/local/cache_helper.dart';
import 'package:shopapp/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel
{
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body
  });
}
class OnBoardingScreen extends StatefulWidget
{

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
{
  var boardController = PageController();

  bool isLast = false;

  void submit()
  {
    CacheHelper.saveData(key: 'OnBoarding', value: true).then((value)
    {
      if (value)
      {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });

  }
  List<BoardingModel> boarding =
  [
    BoardingModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'onBoarding 1 title',
      body: 'onBoarding 1 body',
    ),
    BoardingModel(
      image: 'assets/images/onboard_2.jpg',
      title: 'onBoarding 2 title',
      body: 'onBoarding 2 body',
    ),
    BoardingModel(
      image: 'assets/images/onboard_3.jpg',
      title: 'onBoarding 3 title',
      body: 'onBoarding 3 body',
    ),
  ];

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        actions:
        [
          defaultTextButton(
            text: Text(
              'SKIP',
              style: TextStyle(
                  fontWeight: FontWeight.bold
              ),
            ),
            onPressed: ()
            {
              submit();
            }
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children:
          [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                onPageChanged: (int index)
                {
                  if(index == boarding.length - 1)
                  {
                    setState(()
                    {
                      isLast = true;
                    });
                  } else
                    {
                      setState(()
                      {
                        isLast = false;
                      });
                    }
                },
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children:
              [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    expansionFactor: 4,
                    spacing: 5.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onPressed: ()
                  {
                    if(isLast)
                    {
                      submit();
                    } else
                      {
                      boardController.nextPage(
                      duration: Duration(milliseconds: 750,),
                      curve: Curves.fastLinearToSlowEaseIn,
                      );
                      }
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          image: AssetImage(model.image,),
          height: 320.0,
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
      Text(
        model.title,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        model.body,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
    ],
  );
}
