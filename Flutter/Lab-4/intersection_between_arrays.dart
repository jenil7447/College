//WAP to find the intersection of two integer arrays, nums1 and nums2.
// Each element in the result should appear as many times as it appears in both arrays,
// and the result should be returned in sorted order.
// Example: Input: nums1 = [1, 2, 2, 1], nums2 = [2, 2], Output: [2, 2];
// Input: nums1 = [4, 9, 5], nums2 = [9, 4, 9, 8, 4], Output: [4, 9].
import 'dart:io';

void main(){
  List<int> nums1 =[4, 9, 5];
  List<int> nums2 = [9, 4, 9, 8, 4];
  List<int> output = [];

   for(int i = 0 ; i < nums1.length ; i++){
     if(nums2.contains(nums1[i])){
       output.add(nums1[i]);
     }
   }
   print(output);
}