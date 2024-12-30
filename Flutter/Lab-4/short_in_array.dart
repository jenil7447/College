//WAP to sort an array of names based on the corresponding heights in descending order.
// The names and heights are given as two separate arrays, and the heights are distinct positive integers.
// Example: Input: names = ["Mary","John","Emma"], heights = [180,165,170], Output: ["Mary","Emma","John"];
// Input: names = ["Alice","Bob","Bob"], heights = [155,185,150], Output: ["Bob","Alice","Bob"].
void main() {
  List<String> names = ["Mary", "John", "Emma"];
  List<int> heights = [180, 165, 170];

  // Step 1: Pair names and heights manually
  List<List<dynamic>> paired = [];
  for (int i = 0; i < names.length; i++) {
    paired.add([names[i], heights[i]]);
  }

  // Step 2: Sort manually using bubble sort based on heights in descending order
  for (int i = 0; i < paired.length - 1; i++) {
    for (int j = 0; j < paired.length - i - 1; j++) {
      if (paired[j][1] < paired[j + 1][1]) {
        // Swap the pairs
        List<dynamic> temp = paired[j];
        paired[j] = paired[j + 1];
        paired[j + 1] = temp;
      }
    }
  }

  // Step 3: Extract sorted names
  List<String> sortedNames = [];
  for (var pair in paired) {
    sortedNames.add(pair[0]);
  }

  print(sortedNames); // Output: ["Mary", "Emma", "John"]
}

