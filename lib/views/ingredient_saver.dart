import 'package:flutter/material.dart';
import 'package:chart_tuto/providers/data_provider.dart';
import 'ingredient_list.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

enum IngredientMode { Editing, Adding }

class SaveIngredient extends StatefulWidget {
  final IngredientMode ingredientMode;
  final Map<String, dynamic> ingredient;
  final String _recipename;

  SaveIngredient(this.ingredientMode, this.ingredient, this._recipename);

  @override
  IngredientState createState() {
    return new IngredientState();
  }
}

class IngredientState extends State<SaveIngredient> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _carbonintensityController =
      TextEditingController();
  final TextEditingController _calorieintensityController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  //final TextEditingController _unitController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      controller: _nameController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(30),
        BlacklistingTextInputFormatter.singleLineFormatter
      ],
      decoration: InputDecoration(
        /*
        labelText: 'Ingredient name',
        labelStyle: TextStyle(fontSize: 25),*/
        //suffixText: 'kg-CO2-eq',
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.green),
        ),
      ),
      onChanged: (String value) {
        _formKey.currentState.validate();
      },
      autovalidate: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'A name is required';
        }

        return null;
      },
    );
  }

  Widget _buildCarbonIntensity() {
    return TextFormField(
      controller: _carbonintensityController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        DecimalTextInputFormatter(decimalRange: 1),
        WhitelistingTextInputFormatter(RegExp("[0-9.]")),
        LengthLimitingTextInputFormatter(10),
        BlacklistingTextInputFormatter.singleLineFormatter
      ],
      decoration: InputDecoration(
        /*
        labelText: 'Ingredient name',
        labelStyle: TextStyle(fontSize: 25),*/
        suffixIcon: Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 0.0, right: 15),
            child: Text('kg-CO2-eq/kg', style: TextStyle(fontSize: 16))),
        //suffixText: 'kg-CO2-eq',
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.green),
        ),
      ),
      onChanged: (String value) {
        _formKey.currentState.validate();
      },
      autovalidate: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'A value is required';
        }
        if (double.parse(value) < 0) {
          return 'Value must be positive';
        }

        if (value.substring(value.length - 1) == '.') {
          return 'Invalid entry';
        }

        return null;
      },
    );
  }

  Widget _buildCalorieIntensity() {
    return TextFormField(
      controller: _calorieintensityController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        DecimalTextInputFormatter(decimalRange: 1),
        WhitelistingTextInputFormatter(RegExp("[0-9.]")),
        LengthLimitingTextInputFormatter(10),
        BlacklistingTextInputFormatter.singleLineFormatter
      ],
      decoration: InputDecoration(
        /*
        labelText: 'Ingredient name',
        labelStyle: TextStyle(fontSize: 25),*/
        suffixIcon: Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 0.0, right: 15),
            child: Text('kcal/kg', style: TextStyle(fontSize: 16))),
        //suffixText: 'kg-CO2-eq',
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.green),
        ),
      ),
      onChanged: (String value) {
        _formKey.currentState.validate();
      },
      autovalidate: true,
      validator: (String value) {
        if (value.isEmpty) {
          return 'A value is required';
        }
        if (double.parse(value) < 0) {
          return 'Value must be positive';
        }

        if (value.substring(value.length - 1) == '.') {
          return 'Invalid entry';
        }

        return null;
      },
    );
  }

  Widget _buildQuantity() {
    return TextFormField(
      //initialValue:'',
      controller: _quantityController,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        DecimalTextInputFormatter(decimalRange: 1),
        WhitelistingTextInputFormatter(RegExp("[0-9.]")),
        LengthLimitingTextInputFormatter(10),
        BlacklistingTextInputFormatter.singleLineFormatter
      ],
      decoration: InputDecoration(
        /*
        labelText: 'Ingredient name',
        labelStyle: TextStyle(fontSize: 25),*/
        suffixIcon: Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15, left: 0.0, right: 15),
            child: Text('grams', style: TextStyle(fontSize: 16))),
        //suffixText: 'kg-CO2-eq',
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.red),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.green),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 2.0, color: Colors.green),
        ),
      ),
      onChanged: (String value) {
        _formKey.currentState.validate();
      },
      autovalidate: true,
      validator: (String value) {
        if (value.isEmpty || value == '') {
          return 'A value is required';
        }
        if (double.parse(value) < 0) {
          return 'Value must be positive';
        }

        if (value.substring(value.length - 1) == '.') {
          return 'Invalid entry';
        }

        return null;
      },
    );
  }

  @override
  void initState() {
    _nameController.text = widget.ingredient['name'];
    _carbonintensityController.text =
        widget.ingredient['carbon_intensity'].toString();
    _calorieintensityController.text =
        widget.ingredient['calorie_intensity'].toString();
    _quantityController.text = widget.ingredient['quantity'].toString();
    //_unitController.text = widget.ingredient['unit'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ingredientMode == IngredientMode.Adding
            ? 'Add ingredient: ' + widget.ingredient['name']
            : 'Edit ingredient: ' + widget.ingredient['name']),
        backgroundColor: Color(0xFF162A49),
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: FutureBuilder(
            future: DataProvider.getRecipeMax(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView(children: <Widget>[
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Ingredient name:',
                                style: TextStyle(fontSize: 17)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: _buildName())
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Carbon intensity:',
                                style: TextStyle(fontSize: 17)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: _buildCarbonIntensity(),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Calorie intensity:',
                                style: TextStyle(fontSize: 17)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: _buildCalorieIntensity(),
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Quantity:', style: TextStyle(fontSize: 17)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.45,
                              child: _buildQuantity(),
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            _Button('Save', Colors.green[900], () {
                              final name = _nameController.text;
                              final carbonintensity =
                                  _carbonintensityController.text;
                              final calorieintensity =
                                  _calorieintensityController.text;
                              final quantity = _quantityController.text;
                              if (!_formKey.currentState.validate()) {
                                return;
                              }
                              if (widget?.ingredientMode ==
                                  IngredientMode.Adding) {
                                DataProvider.insertIngredient({
                                  'name': name,
                                  'carbon_intensity': carbonintensity,
                                  'calorie_intensity': calorieintensity,
                                  'quantity': quantity,
                                  'recipe_id': widget.ingredient['recipe_id']
                                });
                              } else if (widget?.ingredientMode ==
                                  IngredientMode.Editing) {
                                DataProvider.updateIngredient({
                                  'id': widget.ingredient['id'],
                                  'name': _nameController.text,
                                  'carbon_intensity': carbonintensity,
                                  'calorie_intensity': calorieintensity,
                                  'quantity': quantity,
                                  'recipe_id': widget.ingredient['recipe_id'],
                                });
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowIngredients(
                                        widget.ingredient['recipe_id'],
                                        widget._recipename)),
                              );
                            }),
                            Container(
                              height: 16.0,
                            ),
                            _Button('Cancel', Colors.grey, () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ShowIngredients(
                                        widget.ingredient['recipe_id'],
                                        widget._recipename)),
                              );
                            }),
                            widget.ingredientMode == IngredientMode.Editing
                                ? Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child:
                                        _Button('Delete', Colors.red[600], () async {
                                      await DataProvider.deleteIngredient(
                                          widget.ingredient['id']);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShowIngredients(
                                                    widget.ingredient[
                                                        'recipe_id'],
                                                    widget._recipename)),
                                      );
                                    }),
                                  )
                                : Container()
                          ],
                        ),
                      ],
                    ),
                  ),

                  /*
                  SizedBox(height: MediaQuery.of(context).size.height * 0.17),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.34,
                                child: Text('Ingredient name:',
                                    style: TextStyle(fontSize: 17))),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.46,
                                child: TextField(
                                  controller: _nameController,
                                  decoration: InputDecoration(
                                    hintText: 'Ingredient name',
                                    fillColor: Colors.white,
                                    filled: true,
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.green),
                                    ),
                                  ),
                                )),
                          ]),
                      Container(
                        height: 8,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.34,
                                child: Text('Carbon intensity:',
                                    style: TextStyle(fontSize: 17))),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.17,
                              child: TextField(
                                controller: _carbonintensityController,
                                decoration: InputDecoration(
                                  hintText: 'Carbon intensity',
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.03),
                            Text('kg-CO2-eq/kg',
                                style: TextStyle(fontSize: 17)),
                          ]),
                      Container(
                        height: 8,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.34,
                                child: Text('Calorie intensity:',
                                    style: TextStyle(fontSize: 17))),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.17,
                              child: TextField(
                                controller: _calorieintensityController,
                                decoration: InputDecoration(
                                  hintText: 'Calorie intensity',
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.08),
                            Text('Calories/kg', style: TextStyle(fontSize: 17)),
                          ]),
                      Container(
                        height: 8,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                                width: MediaQuery.of(context).size.width * 0.34,
                                child: Text('Quantity:',
                                    style: TextStyle(fontSize: 17))),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.17,
                              child: TextFormField(
                                controller: _quantityController,
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                inputFormatters: [
                                  DecimalTextInputFormatter(decimalRange: 1),
                                  //WhitelistingTextInputFormatter.digitsOnly,
                                  /*WhitelistingTextInputFormatter(
                                      RegExp("[1-9.]")),*/
                                  LengthLimitingTextInputFormatter(10),
                                  BlacklistingTextInputFormatter
                                      .singleLineFormatter
                                ],
                                decoration: InputDecoration(
                                  hintText: 'Quantity',
                                  fillColor: Colors.white,
                                  filled: true,
                                  enabledBorder:
                                      _quantityController.text.length ==0
                                          ? OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.red,
                                                  width: 2.0),
                                            )
                                          : OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.green,
                                                  width: 2.0),
                                            ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.blue, width: 2.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.17),
                            Text('grams', style: TextStyle(fontSize: 17)),
                            /*
                  Container(
                    width: 50,
                    child: TextField(
                      controller: _unitController,
                      decoration: InputDecoration(hintText: 'Unit'),
                    ),
                  ),*/
                          ]),
                      Container(
                        height: 16.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          _Button('Save', Colors.green[900], () {
                            final name = _nameController.text;
                            final carbonintensity =
                                _carbonintensityController.text;
                            final calorieintensity =
                                _calorieintensityController.text;
                            final quantity = _quantityController.text;

                            if (widget?.ingredientMode ==
                                IngredientMode.Adding) {
                              DataProvider.insertIngredient({
                                'name': name,
                                'carbon_intensity': carbonintensity,
                                'calorie_intensity': calorieintensity,
                                'quantity': quantity,
                                'recipe_id': widget.ingredient['recipe_id']
                              });
                            } else if (widget?.ingredientMode ==
                                IngredientMode.Editing) {
                              DataProvider.updateIngredient({
                                'id': widget.ingredient['id'],
                                'name': _nameController.text,
                                'carbon_intensity': carbonintensity,
                                'calorie_intensity': calorieintensity,
                                'quantity': quantity,
                                'recipe_id': widget.ingredient['recipe_id'],
                              });
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowIngredients(
                                      widget.ingredient['recipe_id'],
                                      widget._recipename)),
                            );
                          }),
                          Container(
                            height: 16.0,
                          ),
                          _Button('Cancel', Colors.grey, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ShowIngredients(
                                      widget.ingredient['recipe_id'],
                                      widget._recipename)),
                            );
                          }),
                          widget.ingredientMode == IngredientMode.Editing
                              ? Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child:
                                      _Button('Delete', Colors.red, () async {
                                    await DataProvider.deleteIngredient(
                                        widget.ingredient['id']);
                                    Navigator.pop(context);
                                  }),
                                )
                              : Container()
                        ],
                      )
                    ],
                  )*/
                ]);
              }
              return Container();
            }),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String _text;
  final Color _color;
  final Function _onPressed;

  _Button(this._text, this._color, this._onPressed);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: _onPressed,
      child: Text(
        _text,
        style: TextStyle(color: Colors.white),
      ),
      height: 40,
      minWidth: 100,
      color: _color,
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(',') ||
          value.contains('-') ||
          value.contains(' ') ||
          value.contains('..')) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
