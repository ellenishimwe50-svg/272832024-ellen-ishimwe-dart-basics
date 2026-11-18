// Student: Ishimwe Ellen
// Reg no: 27283
const String regNo = '27283';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

// ---------------------------------------------------------------------
// copied from D2 (dart_basics.dart)
// ---------------------------------------------------------------------
int momoFee(int amount) {
  // by IE
  if (amount <= 0) return -1; // invalid
  if (amount <= 1000) return 20;
  if (amount <= 10000) return 100;
  if (amount <= 150000) return 250;
  return 1500;
}

// ---------------------------------------------------------------------
// F1: formatRwf
// ---------------------------------------------------------------------
// FIRST DRAFT (kept for the Part G log). It counted from the LEFT:
//
//   String formatRwf(int amount) {
//     // by IE
//     String digits = amount.toString();
//     String result = '';
//     int i = 0;
//     while (i < digits.length) {
//       if (i % 3 == 0 && i != 0) result += ',';
//       result += digits[i];
//       i++;
//     }
//     return result + ' RWF';
//   }
//
// formatRwf(1000) printed '100,0 RWF' instead of '1,000 RWF'.
// (It also did not handle negative numbers: -5000 gave '-50,00 RWF'.)

String formatRwf(int amount) {
  // by IE
  bool negative = amount < 0;
  String digits = amount.abs().toString();
  String result = '';
  int count = 0; // how many digits we have placed so far, from the right
  int i = digits.length - 1;
  while (i >= 0) {
    if (count > 0 && count % 3 == 0) {
      result = ',' + result;
    }
    result = digits[i] + result;
    count++;
    i--;
  }
  String sign = negative ? '-' : '';
  return '$sign$result RWF';
}

// ---------------------------------------------------------------------
// F2: isValidPin
// ---------------------------------------------------------------------
bool isValidPin(String pin) {
  // by IE
  if (pin.length != 5) return false;
  bool allSame = true;
  int i = 0;
  while (i < pin.length) {
    int code = pin.codeUnitAt(i);
    if (code < 48 || code > 57) return false; // '0' is 48 and '9' is 57
    if (pin[i] != pin[0]) allSame = false;
    i++;
  }
  if (pin == '12345') return false;
  if (allSame) return false; // like 77777
  return true;
}

// ---------------------------------------------------------------------
// F3: sendMoney
// ---------------------------------------------------------------------
int sendMoney(int balance, int amount) {
  // by IE
  int fee = momoFee(amount);
  if (fee == -1) {
    print('Failed: invalid amount');
    return balance;
  }
  if (amount + fee > balance) {
    print('Failed: insufficient balance');
    return balance;
  }
  int newBalance = balance - amount - fee;
  print('Sent ${formatRwf(amount)} (fee ${formatRwf(fee)}). '
      'New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

// ---------------------------------------------------------------------
// F4: buyAirtime
// ---------------------------------------------------------------------
int buyAirtime(int balance, int amount) {
  // by IE
  if (amount < 100 || amount > 50000) {
    print('Failed: airtime must be from ${formatRwf(100)} to ${formatRwf(50000)}');
    return balance;
  }
  if (amount > balance) {
    print('Failed: insufficient balance');
    return balance;
  }
  int newBalance = balance - amount;
  print('Airtime bought: ${formatRwf(amount)}. '
      'New balance: ${formatRwf(newBalance)}');
  return newBalance;
}

void main() {
  // by IE
  print('Reg no: $regNo | D = $d | T = $t');
  print('');

  // 1. PIN checks
  print('--- PIN checks ---');
  List<String> pins = ['12345', '77777', '4821', '48a21', '4821$d'];
  int p = 0;
  while (p < pins.length) {
    print("isValidPin('${pins[p]}') = ${isValidPin(pins[p])}");
    p++;
  }
  print('');

  // 2. starting balance
  print('--- Transactions ---');
  int balance = 20000 + t * 500;
  print('Starting balance: ${formatRwf(balance)}');

  // 3. in order: send (D + 1) * 3000 three times, airtime 1,000, send 0, send 200000
  int sends = 0;
  while (sends < 3) {
    balance = sendMoney(balance, (d + 1) * 3000);
    sends++;
  }
  balance = buyAirtime(balance, 1000);
  balance = sendMoney(balance, 0);
  balance = sendMoney(balance, 200000);

  // 4. final balance
  print('Final balance: ${formatRwf(balance)}');
  print('');

  // 5. my own tests (expected output is in the comment)
  print('--- My own tests ---');
  print(formatRwf(100000)); // 100,000 RWF  (breaks if I add a comma at the front)
  print(formatRwf(-999)); // -999 RWF  (breaks if the minus sign gets a comma: -,999)
  print(formatRwf(-1000)); // -1,000 RWF
  print(formatRwf(1234567890)); // 1,234,567,890 RWF
  print(formatRwf(12)); // 12 RWF
  print(isValidPin('00000')); // false  (same digit five times)
  print(isValidPin('12340')); // true
  print(isValidPin('')); // false  (empty string must not crash)
  print(isValidPin('12 45')); // false  (a space is not a digit)
  print(isValidPin('１２３４５')); // false  (full-width digits: might break, but only 0-9 are accepted)
}
