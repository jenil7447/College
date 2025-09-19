#include<stdio.h>
#include<time.h>

void insertionSort(int arr[], int n){
    for(int i = 0; i < n-1; i++){
        for(int j = i + 1; j  > 0; j--){
            if(arr[j] < arr[j-1]){
                int swap = arr[j];
                arr[j] = arr[j-1];
                arr[j-1] = swap;
            }
            else break;
        }
    }
}


void main(){
    int n;
    clock_t start,end;
    double cpu_time_used;
    printf("Enter size of array : ");
    scanf("%d",&n);

    int arr[n];
    for(int i = 0; i < n; i++){
        printf("enter element %d: ",i);
        scanf("%d",&arr[i]);
    }
    start = clock();
    insertionSort(arr,n);
    end = clock();

    cpu_time_used = ((double)(end-start))/CLOCKS_PER_SEC;

    for(int i = 0; i < n ; i ++){
        printf("%d ",arr[i]);
    }
    printf(" \ncpu time used %f",cpu_time_used);


}
