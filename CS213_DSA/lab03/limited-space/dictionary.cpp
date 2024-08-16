#include "dictionary.h"
#include <cmath>
#include<bits/stdc++.h>
using namespace std;
Dictionary::Dictionary()
{
    
    this->A = new Entry[DICT_SIZE]; // allocating memory to the array
    this->N=0;
    for(int i=0 ; i < DICT_SIZE;i++){
        this->A[i].value=-1;
        this->A[i].key=NULL;
    }
    
};

int Dictionary::hashValue(char key[])
{
    int hashValue = 0;

    // compute hash

    // using polynomial accumulation
    long long int p = 33;
    double A1 = (sqrt(5)-1)/2.0;
    long long int powers=1;

    
    long long int key_to_int =0;

    for (int i = 0; key[i] != '\0'; i++)
    {
        key_to_int += ((key[i]) * powers)%1009;
        powers=(powers*p)%1009;
        
    }
    double fraction = key_to_int * A1-int(key_to_int * A1);
    int int_to_sizeoftable = (DICT_SIZE* (fraction));
    hashValue = int_to_sizeoftable;
    return hashValue;
}

int Dictionary::findFreeIndex(char key[])
{
    int index = hashValue(key);
    int fIndex = -1;
    if (A[index].value != -1||A[index].value==-2) /// the index is occupied (if no value is there )||(if there is tombstone)
    {
        int cnt = DICT_SIZE;
        while (cnt--)
        {
            if (A[index].value == -1)
            {
                fIndex = index;
                break;
            }
            index = (index + 1) % DICT_SIZE;
        }
    }
    else
    {
        fIndex = index;
    }
    return fIndex;
}

struct Entry *Dictionary::get(char key[])
{
    int has_V = hashValue(key);
    int index=has_V;

    if(A[index].value==-1) return NULL;


    if(A[index].value!=-2&&strcmp(A[index].key,key)==0)
    { 
        return A+has_V;
    }
    else {
        int cnt = DICT_SIZE;
        while (cnt--)
        {
            if(A[index].key!=NULL&&A[index].value!=-2&&strcmp(A[index].key,key)==0)
            {
                return A+index;
            }
            index=(index+1)%DICT_SIZE;
        }
    }

    return NULL;
}

bool Dictionary::put(Entry e)
{
    int has_V = hashValue(e.key);
    if (A[has_V].value==-1) // THE STORAGE IS EMPTY
    {
        A[has_V] = e;
        N++;
        return true;
    }
    // else find free space
    else
    {
        int index = findFreeIndex(e.key);

        if (index == -1)
            return false;
        else
        {
            A[index] = e;
            N++;
            return true;
        }
    }
}

bool Dictionary::remove(char key[])
{
   
    Entry *a1=get(key);
    if(a1==NULL)
    {
        return false;
    }
    
    else{
        
        a1->value=-2;
        return true;
    }


}
