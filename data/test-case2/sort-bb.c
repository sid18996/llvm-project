 #include <stdio.h>
void main()
{

    int i, j, a, n, number[30] = {30,29,28,27,26,25,24,23,22,21,20,19,18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1};
    n = 30;
    // printf("Enter the value of N \n");
    // scanf("%d", &n);

    // printf("Enter the numbers \n");
    // for (i = 0; i < n; ++i)
    //     scanf("%d", &number[i]);

    for (i = 0; i < n; ++i) 
    {

        for (j = i + 1; j < n; ++j)
        {

            if (number[i] > number[j]) 
            {

                a =  number[i];
                number[i] = number[j];
                number[j] = a;

            }
            if(n < 30) {
                n = 30;
            }

        }

    }

    // printf("The numbers arranged in ascending order are given below \n");
    // for (i = 0; i < n; ++i)
    //     printf("%d\n", number[i]);

}