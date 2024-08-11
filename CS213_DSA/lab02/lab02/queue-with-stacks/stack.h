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
    Stack();
    ~Stack();
    void push(T value);
    T pop();
    T peek();
    bool isEmpty();
    size_t getSize();
};

// ENTER YOUR IMPLEMENTATIONS OF METHODS BELOW
template <typename T>
Stack<T>::Stack(){
    this->capacity=100000000;
    this->arr=new T[this->capacity];
    this->top=-1;
}
template<typename T>
T Stack<T>::peek(){
    return this->arr[top];
}
template<typename T>
void Stack<T>::push(T value){
    this->arr[++top]=value;
}

template<typename T>
bool Stack<T>::isEmpty(){
    return top==-1;
}

template<typename T>
T Stack<T>:: pop()
{
    T ans=this->arr[top];
    top--;
    return ans;
}

template<typename T>
Stack<T>::~Stack(){
    delete [] this->arr;

}

template<typename T>
size_t Stack<T>:: getSize(){
    return top+1;
}