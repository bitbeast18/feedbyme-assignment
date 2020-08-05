#include <stdio.h>

void findTransactions(const int *list, int noOfDays){

    int profit = 0, lastBought = 0;

    for (int i=1; i<noOfDays; i++){
        if (list[i] < list[i - 1]){
            profit += list[i - 1] - list[lastBought];

            if (lastBought != i - 1){
                printf("Buy on - %d\nSell on - %d\n\n", lastBought + 1, i);
            }

            lastBought = i;
        }
    }

    profit += list[noOfDays - 1] - list[lastBought];

    if (lastBought != noOfDays - 1){
        printf("Buy on - %d\nSell on - %d\n\n", lastBought + 1, noOfDays);
    }

    printf("Max Profit: %d\n", profit);
}

int main(){

    int noOfDays;

    printf("Enter no. of days:");
    scanf("%d", &noOfDays);

    int list[noOfDays];

    printf("Enter prices (space separated):");
    for(int i=0; i<noOfDays; i++){
        scanf("%d", &list[i]);
    }

    findTransactions(list, noOfDays);

    return 0;
}