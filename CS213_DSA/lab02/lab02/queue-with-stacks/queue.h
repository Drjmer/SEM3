#include <cstdlib>
#include <cstddef>
#include "stack.h"
#pragma once

/*
 * You must NOT add ANY other includes than what is already here.
 * The purpose of this file is to implement the functioning of a queue in C++.
 * The task is to implement a Queue using stacks. This requires two stacks.
 * Ensure that ALL of them are on average constant time. Amortized O(1) is OK.
 * You must NOT change the data members or ANY of the method signatures.
 * NOR are you allowed to add any additional methods or data members.
 * You are free to use the PUBLIC methods of the Stack class here.
 */

template <typename T>
void spill(Stack<T> first_stack, Stack<T> second_stack)
{
    while (first_stack.getSize() == 0)
    {
        second_stack.push(first_stack.peek());
        first_stack.pop();
    }
}
template <typename T>
class Queue
{
    class Stack<T> first_stack;
    class Stack<T> second_stack;

public:
    Queue();
    ~Queue();
    void enqueue(T value);
    T dequeue();
    T peek();
    bool isEmpty();
    size_t getSize();
};

// ENTER YOUR IMPLEMENTATIONS OF METHODS BELOW
template<typename T>
Queue<T>::Queue(){}

template<typename T>
Queue<T>::~Queue(){
    first_stack.~Stack();
    second_stack.~Stack();
}

template< typename T>
void Queue<T>::enqueue(T value){
    first_stack.push(value);
}

template<typename T>
T Queue<T>::dequeue(){
    spill(first_stack,second_stack);
    return second_stack.pop();
}

template<typename T>
T Queue<T>::peek(){
    if(!first_stack.isEmpty())
    {
        return first_stack.peek();
    }
    else{
        spill(second_stack,first_stack);
        return first_stack.peek();
    }
}

template <typename T>
size_t Queue<T>::getSize(){
    return first_stack.getSize()+second_stack.getSize();
}

template<typename T>
bool Queue<T>::isEmpty(){
    return getSize()==0?true:false;
}