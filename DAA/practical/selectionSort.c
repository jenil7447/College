#include<stdio.h>
#include<time.h>

void swap(int arr[],int first, int secound){
    int temp = arr[first];
    arr[first] = arr[secound];
    arr[secound] = temp;
}

int getMaxIndex(int arr[],int start,int end){
    int max = start;
    for(int i = start; i <= end; i++ ){
        if(arr[max] < arr[i]){
            max = i;
        }
    }
    return max;
}


void selectionSort(int arr[],int n){
    for(int i = 0; i < n; i++){
        int last = n - i -1;
        int maxIndex = getMaxIndex (arr,0,last);
        swap(arr,maxIndex,last);
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
    selectionSort(arr,n);
    end = clock();

    cpu_time_used = (end-start)/CLOCKS_PER_SEC;

    for(int i = 0; i < n ; i ++){
        printf("%d ",arr[i]);
    }
    printf(" \n cpu time used %f",cpu_time_used);


}
