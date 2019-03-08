#include <stdio.h>
#include<stdlib.h>
int main()
{
	int x;
	long long i;
	float f;
	for(i = 0; i< 1000; i++)
	{
		float r2 = (float)rand()/(float)(RAND_MAX/1000);
		printf("%f\n",r2);
	}
}