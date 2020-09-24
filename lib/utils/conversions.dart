class Converter {
  // Convert to lowest measurement then to desired measurement
  // list of units: teaspoon, tablespoon, cup, ounce, pint, quart, gallon, milliliter, liter
  // https://whatscookingamerica.net/equiv.htm

  List unit = [
    'teaspoon',
    'tablespoon',
    'cup',
    'ounce',
    'pint',
    'quart',
    'gallon',
    'milliliter',
    'liter'
  ];
  Map<String, double> units = Map<String, double>();

  Converter() {
    units['teaspoon'] = teaspoons();
    units['tablespoon'] = tablespoons();
    units['cup'] = cups();
    units['ounce'] = ounces();
    units['pint'] = pints();
    units['gallon'] = gallons();
    units['mL'] = mLs();
    units['liter'] = liters();
  }

  double convert(String fromUnit, String toUnit) {
    return 0.0;
  }

  double ounces() {
    return 6.9;
  }

  double pints() {
    return 6.9;
  }

  double gallons() {
    return 6.9;
  }

  double cups() {
    return 6.9;
  }

  double mLs() {
    return 6.9;
  }

  double liters() {
    return 6.9;
  }

  double grams() {
    return 6.9;
  }

  double teaspoons() {
    return 6.9;
  }

  double tablespoons() {
    return 6.9;
  }

  double quarts() {
    return 6.9;
  }
}
