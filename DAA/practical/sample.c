#include <stdio.h>
#include <time.h>

void heapify(int arr[],int n, int i){
    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if(left < n && arr[left] > arr[largest]){
        largest = left;
    }
    if(right < n && arr[right] > arr[largest]){
        largest = right;
    }

    if(largest != i){
        int temp = arr[i];
        arr[i] = arr[largest];
        arr[largest] = temp;

        heapify(arr,n,largest);
    }
}

void heapSort(int arr[], int n){
    for(int i =  n / 2 - 1 ; i >= 0 ; i --){
        heapify(arr,n,i);
    }
    for(int i = n-1 ; i > 0 ; i --){
        int temp = arr[0];
        arr[0] = arr[i];
        arr[i] = temp;

        heapify(arr,i,0);
    }
}

int main() {
    int n;
    clock_t start, end;
    double cpu_time_used;

    printf("Enter size of array: ");
    scanf("%d", &n);

    int arr[n];
    for (int i = 0; i < n; i++) {
        printf("Enter element %d: ", i);
        scanf("%d", &arr[i]);
    }

    start = clock();
    heapSort(arr, n);
    end = clock();

    cpu_time_used = ((double)(end - start)) / CLOCKS_PER_SEC;

    printf("Sorted array: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\nCPU time used: %f seconds\n", cpu_time_used);

    return 0;
}
