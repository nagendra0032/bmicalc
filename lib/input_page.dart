import 'package:bmicalc/results_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:bmicalc/icon_content.dart';
import 'package:bmicalc/reusable_card.dart';
import 'package:bmicalc/constants.dart';
import 'package:bmicalc/results_page.dart';
import 'package:bmicalc/bottom_button.dart';
import 'package:bmicalc/calculator_brain.dart';


enum Gender {
  male,
  female
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

//  Color maleCardColour = inactiveCardColour;
//  Color femaleCardColour = inactiveCardColour;
    Gender selectGender;
    int height = 180;
    int weight = 20;
    int age = 0;

//  void updateColour(Gender gender) {
//    if(gender == Gender.male) {
//      if(maleCardColour == inactiveCardColour) {
//        maleCardColour = activeCardColour;
//        femaleCardColour = inactiveCardColour;
//      } else {
//        maleCardColour = inactiveCardColour;
//      }
//    }
//
//    if(gender == Gender.female) {
//      if(femaleCardColour == inactiveCardColour) {
//        femaleCardColour = activeCardColour;
//        maleCardColour = inactiveCardColour;
//      } else {
//        femaleCardColour = inactiveCardColour;
//      }
//    }
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(child: Row(
            children: <Widget>[
              Expanded(child: ReusableCard(
                onPress: () {
                  setState(() {
                    selectGender = Gender.male;
                  });
                },
                colour:selectGender == Gender.male ? kActiveCardColour : kInactiveCardColour,
                cardChild: IconContent(
                  icon:  FontAwesomeIcons.mars,
                  label: "Male",
                ),
              ),
              ),
              Expanded(child: ReusableCard(
                onPress: () {
                  setState(() {
                    selectGender = Gender.female;
                  });
                },
                colour:selectGender == Gender.female ? kActiveCardColour : kInactiveCardColour,
                cardChild: IconContent(
                  icon: FontAwesomeIcons.venus,
                  label: "Female",
                ),
              ),
              ),
            ],
          ),),
          Expanded(child: ReusableCard(
            colour:kActiveCardColour,
            cardChild: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('HEIGHT',
                  style: kLabelTextStyle,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    Text(height.toString(),
                      style:kFontStyle,
                    ),
                    Text('cm',
                    style:kLabelTextStyle,
                    ),
                  ],
                ),
                Slider(
                  value: height.toDouble(),
                  min: 120.0,
                  max: 220,
                  activeColor: Color(0xFFEB1555),
                  inactiveColor: Color(0xFF8D8E98),
                  onChanged: (double newValue) {
                   setState(() {
                     height = newValue.round();
                   });
                  },

                    ),
              ],
            ),
          ),
          ),
          Expanded(child: Row(
            children: <Widget>[
              Expanded(child: ReusableCard(
                colour:kActiveCardColour,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('WEIGHT',
                      style: kLabelTextStyle,
                    ),
                    Text(weight.toString(),
                      style: kFontStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RoundIconButton(
                          icon: FontAwesomeIcons.plus,
                          onPressed: (){
                            setState(() {
                              weight++;
                            });
                          },
                        ),
//                        FloatingActionButton(
//                          backgroundColor: Color(0xFF4C4F5E),
//                          child: Icon(
//                            Icons.add,
//                            color: Colors.white,
//
//                          ),
//                        ),
                        SizedBox(width: 10.0,),
                        RoundIconButton(
                          icon: FontAwesomeIcons.minus,
                          onPressed: (){
                            setState(() {
                              weight--;
                            });
                          },
                        ),
                      ],
                    ),

                  ],
                ),
              ),
              ),
              Expanded(child: ReusableCard(
                colour:kActiveCardColour,
                  cardChild: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('AGE',
                        style: kLabelTextStyle,
                      ),
                      Text(age.toString(),
                        style: kFontStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RoundIconButton(
                            icon: FontAwesomeIcons.plus,
                            onPressed: (){
                              setState(() {
                                age++;
                              });
                            },
                          ),
//                        FloatingActionButton(
//                          backgroundColor: Color(0xFF4C4F5E),
//                          child: Icon(
//                            Icons.add,
//                            color: Colors.white,
//
//                          ),
//                        ),
                          SizedBox(width: 10.0,),
                          RoundIconButton(
                            icon: FontAwesomeIcons.minus,
                            onPressed: (){
                              setState(() {
                                age--;
                              });
                            },
                          ),
                        ],
                      ),

                    ],
                  ),
              ),
              ),
            ],
          ),),
           BottomButton(
             buttonTitle: 'CALCULATE',
             onTap: (){
               CalculatorBrain calc = CalculatorBrain(height: height, weight: weight);

               Navigator.push(context,
                 MaterialPageRoute(builder: (context) => ResultsPage(
                   bmiResult: calc.calculateBMI(),
                   resultText: calc.getResult(),
                   interpretation: calc.getInterpretation(),
                 ),),
                   );
             },
           ),
          ],
      ),
    );
  }
}


class RoundIconButton extends StatelessWidget {

  RoundIconButton({@required this.icon, @required this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child:Icon(icon),
      onPressed: onPressed,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        width: 56.0,
        height: 56.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}






