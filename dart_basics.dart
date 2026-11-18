// Student: Ishimwe Ellen
// Reg no: 27283
const String regNo = '27283';
final int d = int.parse(regNo[regNo.length - 1]);
final int t = int.parse(regNo.substring(regNo.length - 2));

// ---------------------------------------------------------------------
// B2: countVowels
// ---------------------------------------------------------------------
// FIRST DRAFT (kept for the Part G log). It forgot capital letters:
//
//   int countVowels(String text) {
//     // by IE
//     int count = 0;
//     int i = 0;
//     while (i < text.length) {
//       if ('aeiou'.contains(text[i])) count++;
//       i++;
//     }
//     return count;
//   }
//
// With 'Ishimwe Ellen' it printed: Ishimwe Ellen has 3 vowels
// (the capital I and the capital E were missed)

int countVowels(String text) {
  // by IE
  String lower = text.toLowerCase(); // this line makes capital letters count
  const String vowels = 'aeiou';
  int count = 0;
  int i = 0;
  while (i < lower.length) {
    if (vowels.contains(lower[i])) {
      count++;
    }
    i++;
  }
  return count;
}

// ---------------------------------------------------------------------
// B3: initials
// ---------------------------------------------------------------------
// FIRST DRAFT (kept for the Part G log). It crashed on extra spaces:
//
//   String initials(String fullName) {
//     // by IE
//     String result = '';
//     List<String> parts = fullName.split(' ');
//     int i = 0;
//     while (i < parts.length) {
//       result += parts[i][0].toUpperCase() + '.';
//       i++;
//     }
//     return result;
//   }
//
// For ' ana uwase ' the split gives ['', 'ana', 'uwase', ''], and
// parts[0][0] asks for the first letter of an empty string -> RangeError.

String initials(String fullName) {
  // by IE
  List<String> parts = fullName.trim().split(' ');
  String result = '';
  int i = 0;
  while (i < parts.length) {
    // extra spaces in the middle give empty pieces, so skip those
    if (parts[i].isNotEmpty) {
      result += parts[i][0].toUpperCase() + '.';
    }
    i++;
  }
  return result;
}

// ---------------------------------------------------------------------
// C5: drawTriangle
// ---------------------------------------------------------------------
void drawTriangle(int height) {
  // by IE
  int row = 1;
  while (row <= height) {
    String symbol = row.isOdd ? '*' : '#';
    String spaces = ' ' * (height - row); // fewer spaces on each lower row
    print(spaces + symbol * row);
    row++;
  }
}

// ---------------------------------------------------------------------
// D2: MoMo receipt printer
// ---------------------------------------------------------------------
int momoFee(int amount) {
  // by IE
  if (amount <= 0) return -1; // invalid
  if (amount <= 1000) return 20;
  if (amount <= 10000) return 100;
  if (amount <= 150000) return 250;
  return 1500;
}

String maskPhone(String phone) {
  // by IE
  if (phone.length != 10) return 'INVALID';
  String first = phone.substring(0, 3);
  String last = phone.substring(phone.length - 2);
  String stars = '*' * (phone.length - 5);
  return first + stars + last;
}

void main() {
  // by IE
  print('Reg no: $regNo | D = $d | T = $t');
  print('');

  // B2
  String fullName = 'Ishimwe Ellen';
  print('$fullName has ${countVowels(fullName)} vowels');

  // B3
  print("Initials of '$fullName': '${initials(fullName)}'");
  print("Initials of ' ana uwase ': '${initials(' ana uwase ')}'");
  print("Initials of ' ': '${initials(' ')}'");
  print('');

  // C5
  int height = d + 3;
  print('drawTriangle($height):');
  drawTriangle(height);
  print('drawTriangle(0) (prints nothing):');
  drawTriangle(0);
  print('drawTriangle(-2) (prints nothing):');
  drawTriangle(-2);
  print('');

  // D2
  String phone = '0788123456';
  int totalFees = 0;
  int i = 1;
  while (i <= d + 3) {
    int amount = i * 4000 + t * 100;
    int fee = momoFee(amount);
    print('Receipt $i | $amount RWF | fee $fee RWF | to ${maskPhone(phone)}');
    totalFees += fee;
    i++;
  }
  print('Total fees: $totalFees RWF');
}
