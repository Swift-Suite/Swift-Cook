class Converter {
  /**
 * This class converts from one unit to another.
 * 
 * You can use [String variable names] to quickly refer to a unit type without
 * having to memorize the string name.
 * 
 *     For Example:
 * 
 *     Converter converter = Converter();
 *     print(converter.usTsp);
 * 
 *     Output: "US_teaspoon"
 */

  // Initialize as Singleton
  static final Converter _converter = Converter._internal();
  factory Converter() {
    return _converter;
  }
  Converter._internal() {
    // Volume
    _unitsToML['US Teaspoon'] = 4.9289215937;
    _unitsToML['UK Teaspoon'] = 5.9193880208;
    _unitsToML['Metric Teaspoon'] = 5;

    _unitsToML['US Tablespoon'] = 14.786764781;
    _unitsToML['UK Tablespoon'] = 17.758164063;
    _unitsToML['Metric Tablespoon'] = 15;

    _unitsToML['US Cup'] = 236.5882365;
    _unitsToML['UK Cup'] = 284.130625;
    _unitsToML['Metric Cup'] = 250;

    _unitsToML['US Pint'] = 473.176473;
    _unitsToML['UK Pint'] = 568.26125;

    _unitsToML['US Quart'] = 946.352946;
    _unitsToML['UK Quart'] = 1136.5225;

    _unitsToML['US Gallon'] = 3785.411784;
    _unitsToML['UK Gallon'] = 4546.09;

    _unitsToML['US Barrel'] = 119240.4712;
    _unitsToML['UK Barrel'] = 163659.24;

    _unitsToML['US Fl Ounce'] = 29.573529562;
    _unitsToML['UK Fl Ounce'] = 28.4130625;

    _unitsToML['Milliliter'] = 1;
    _unitsToML['Liter'] = 1000;
  }

  // Class Public Variables
  Map<String, double> _unitsToML = Map<String, double>();
  String usTsp = 'US Teaspoon';
  String ukTsp = 'UK Teaspoon';
  String metricTsp = 'Metric Teaspoon';
  String usTbsp = 'US Tablespoon';
  String ukTbsp = 'UK Tablespoon';
  String metricTbsp = 'Metric Tablespoon';
  String usCup = 'US Cup';
  String ukCup = 'UK Cup';
  String metricCup = 'Metric Cup';
  String usPint = 'US Pint';
  String ukPint = 'UK Pint';
  String usQuart = 'US Quart';
  String ukQuart = 'UK Quart';
  String usGallon = 'US Gallon';
  String ukGallon = 'UK Gallon';
  String usBarrel = 'US Barrel';
  String ukBarrel = 'UK Barrel';
  String usFlOunce = 'US Fl Ounce';
  String ukFlOunce = 'UK Fl Ounce';
  String mL = 'Milliliter';
  String liter = 'Liter';

  double convert(double quantity, String fromUnit, String toUnit) {
    /**
   * Returns converted `toUnit`
   * 
   *      Example:
   * 
   *      Converter converter = Converter();
   *      double amount = converter.convert(converter.usTsp, converter.ukGallon);
   *       OR
   *      double amount = converter.convert('US_teaspoon', 'UK_barrel');
   */
    return quantity * _unitsToML[fromUnit] / _unitsToML[toUnit];
  }

  // Keys returns an iterable of the dictionary, haven't tested this so I'm not
  // sure if it works
  Iterable<String> getUnits() {
    return _unitsToML.keys;
  }
}
