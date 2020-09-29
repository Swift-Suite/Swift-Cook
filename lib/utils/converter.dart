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
    _unitsToML['US_teaspoon'] = 4.9289215937;
    _unitsToML['UK_teaspoon'] = 5.9193880208;
    _unitsToML['Metric_teaspoon'] = 5;

    _unitsToML['US_tablespoon'] = 14.786764781;
    _unitsToML['UK_tablespoon'] = 17.758164063;
    _unitsToML['Metric_tablespoon'] = 15;

    _unitsToML['US_cup'] = 236.5882365;
    _unitsToML['UK_cup'] = 284.130625;
    _unitsToML['Metric_cup'] = 250;

    _unitsToML['US_pint'] = 473.176473;
    _unitsToML['UK_pint'] = 568.26125;

    _unitsToML['US_quarts'] = 946.352946;
    _unitsToML['UK_quarts'] = 1136.5225;

    _unitsToML['US_gallon'] = 3785.411784;
    _unitsToML['UK_gallon'] = 4546.09;

    _unitsToML['US_barrel'] = 119240.4712;
    _unitsToML['UK_barrel'] = 163659.24;

    _unitsToML['US_fl_ounce'] = 29.573529562;
    _unitsToML['UK_fl_ounce'] = 28.4130625;

    _unitsToML['mL'] = 1;
    _unitsToML['liter'] = 1000;
  }

  // Class Public Variables
  Map<String, double> _unitsToML = Map<String, double>();
  String usTsp = 'US_teaspoon';
  String ukTsp = 'UK_teaspoon';
  String metricTsp = 'Metric_teaspoon';
  String usTbsp = 'US_tablespoon';
  String ukTbsp = 'UK_tablespoon';
  String metricTbsp = 'Metric_tablespoon';
  String usCup = 'US_cup';
  String ukCup = 'UK_cup';
  String metricCup = 'Metric_cup';
  String usPint = 'US_pint';
  String ukPint = 'UK_pint';
  String usQuart = 'US_quart';
  String ukQuart = 'UK_quart';
  String usGallon = 'US_gallon';
  String ukGallon = 'UK_gallon';
  String usBarrel = 'US_barrel';
  String ukBarrel = 'UK_barrel';
  String usFlOunce = 'US_fl_ounce';
  String ukFlOunce = 'UK_fl_ounce';
  String mL = 'mL';
  String liter = 'liter';

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
