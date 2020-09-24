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

  Map<String, double> unitsToML = Map<String, double>();
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

  Converter() {
    // Volume
    unitsToML['US_teaspoon'] = 4.9289215937;
    unitsToML['UK_teaspoon'] = 5.9193880208;
    unitsToML['Metric_teaspoon'] = 5;

    unitsToML['US_tablespoon'] = 14.786764781;
    unitsToML['UK_tablespoon'] = 17.758164063;
    unitsToML['Metric_tablespoon'] = 15;

    unitsToML['US_cup'] = 236.5882365;
    unitsToML['UK_cup'] = 284.130625;
    unitsToML['Metric_cup'] = 250;

    unitsToML['US_pint'] = 473.176473;
    unitsToML['UK_pint'] = 568.26125;

    unitsToML['US_quarts'] = 946.352946;
    unitsToML['UK_quarts'] = 1136.5225;

    unitsToML['US_gallon'] = 3785.411784;
    unitsToML['UK_gallon'] = 4546.09;

    unitsToML['US_barrel'] = 119240.4712;
    unitsToML['UK_barrel'] = 163659.24;

    unitsToML['US_fl_ounce'] = 29.573529562;
    unitsToML['UK_fl_ounce'] = 28.4130625;

    unitsToML['mL'] = 1;
    unitsToML['liter'] = 1000;
  }

  double convert(double quantity, String fromUnit, String toUnit) {
    /**
   * Returns the result of converting `fromUnit` to `toUnit`.
   */
    return quantity * unitsToML[fromUnit] / unitsToML[toUnit];
  }
}

// Use Case Example
void main() {
  Converter con = Converter(); // Initialize Converter

  // US Cup -> US Tsp
  double cup = con.convert(100, con.usCup, con.usTsp);
  print(cup);
}
