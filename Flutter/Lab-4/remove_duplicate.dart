//WAP to remove duplicates from a sorted integer array in-place such that each unique element appears only once.
// The relative order of the elements should be kept the same.
// The function should return the number of unique elements in the array.
// Example: Input: nums = [1, 1, 2], Output: 2, nums = [1, 2, _];
// Input: nums = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4], Output: 5, nums = [0, 1, 2, 3, 4, _, _, _, _, _].

void main(){
  List<int> array = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4];
  List<int> distinctElements = [];
  int setValue = array[0];
  int count = 1;
  distinctElements.add(setValue);
  for(int i = 0 ; i < array.length; i++){
    if(array[i] != setValue){
      count ++;
      setValue = array[i];
      distinctElements.add(setValue);
    }
  }
  print(count);
  print(distinctElements);
}