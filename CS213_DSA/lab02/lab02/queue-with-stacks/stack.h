#include <cstdlib>
#include <cstddef>
using namespace std;
#pragma once

/*
 * You must NOT add ANY other includes than this.
 * The purpose of this file is to implement the functioning of a stack in C++.
 * Implement all the method functions in this file, your way.
 * Ensure that ALL of them are on average constant time. Amortized O(1) is OK.
 * You must NOT change the method signature of any of the methods.
 * You may add any additional methods or data members as you need.
 * Those methods and data members should be protected.
 */

template <typename T>
class Stack {
    // ADD ANY ADDITIONAL DATA MEMBERS OR METHODS HERE
    int top;
    T* arr;
    int size;
    int capacity;
    // DO NOT CHANGE THE METHOD SIGNATURES BELOW
public:
    Stack(){
        top=-1;
        this->size=100;
        this->arr=new T[this->size];
    }
    ~Stack(){
        delete [] this->arr;
    }
    void push(T value){
        if(getSize()==capacity){
            cout<<" Space full "<<endl;
        }
        else{
            this->arr[++top]=value;
        }
    }
    T pop(){
        if(getSize()==0){
            throw "Empty";
        }
        else{
            T ans=this->arr[top];
            top--;
            return ans;
        }
    }
    T peek(){
        return this->arr[top];
    }
    bool isEmpty(){
        return top==-1;
    }
    size_t getSize(){
        return top+1;
    }
};

// ENTER YOUR IMPLEMENTATIONS OF METHODS BELOW

