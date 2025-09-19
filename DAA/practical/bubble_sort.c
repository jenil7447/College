#include<stdio.h>
#include<time.h>

void bubbleSort(int arr[], int n){
    int swap;
    for(int i = 0; i < n; i ++){
        for(int j = 0; j < n - i - 1; j++){
            if(arr[j] > arr[j + 1]){
                swap = arr[j];
                arr[j] = arr[j+1];
                arr[j+1] = swap;
            }
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
    bubbleSort(arr,n);
    end = clock();

    cpu_time_used = (end-start)/CLOCKS_PER_SEC;

    for(int i = 0; i < n ; i ++){
        printf("%d ",arr[i]);
    }
    printf(" \n cpu time used %f",cpu_time_used);


}
