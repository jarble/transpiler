
#include <stdio.h>
#include <math.h>

#include "map.h" //MAP and MAP_LIST macros

#define type_to_string(x) x: #x "\n"

// get the variable's type as a string
#define get_type(X) _Generic((X), MAP_LIST(type_to_string,int,double,double*,int*,float*, default))

#define struct_member(X) X X ## _ ;

typedef struct Any_type{
	MAP(struct_member,int,float)
} Any_type;

int main(void)
{
    //int x = 8;
    //int i = 1;
    //printf("%d",f_i);
    //const float y = 3.375;
    //MAP(CALL, ('a'), ('b'), ('c'));
    int arr[] = {1,2,3};
    double arr1[] = {1.,2.,3.};
    printf("%s",get_type(arr));
    printf("%s",get_type(arr1));
    printf("%s",get_type(arr[0]));
    printf("%s",get_type(arr1[0]));
    return 0;
}
