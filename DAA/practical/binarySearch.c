#include<stdio.h>
#include<time.h>

int binarySearch(int arr[],int n, int key){
    int low = 0, high = n-1;
     while(low <= high){
        int mid = (low + high)/2;

        if(arr[mid] == key){
            return mid;
        }else if(arr[mid] < key){
            low = mid + 1;
        }else
            high = mid - 1;
     }
     return -1;
}

void main(){
    int n;
    clock_t start,end;
    double cpu_time_used;
    printf("Enter size of array : ");
    scanf("%d",&n);

    int arr[n];
    for(int i = 0; i < n; i++){
        printf("Enter element %d",i);
        scanf("%d",&arr[i]);
    }
    int key;
    printf("Enter elemet to find :");
    scanf("%d",&key);

    start = clock();
    int result = binarySearch(arr,n,key);
    end = clock();

    cpu_time_used = ((double)(end - start))/CLOCKS_PER_SEC;

    if(result!=-1){
        printf("Element found at index %d \n", result);
    }else{
        printf("Element not found");
    }

    printf("Cpu time used %f",cpu_time_used);

}