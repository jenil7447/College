#include<stdio.h>
#include<time.h>

int linearSearch(int arr[], int n , int key){
    for(int  i = 0; i < n ; i++){
        if(key == arr[i]){
            return i;
        }
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
        printf("enter element %d: ",i);
        scanf("%d",&arr[i]);
    }
    int key;
    printf("Enter Key : ");
    scanf("%d",&key);

    start = clock();
    int result = linearSearch(arr,n,key);
    end = clock();

    cpu_time_used = (end-start)/CLOCKS_PER_SEC;

    if(result!=-1){
        printf("element found at index  %d  \n",result);
    }else{
        printf("Element not found");
    }

    printf("cpu time used %f",cpu_time_used);


}
