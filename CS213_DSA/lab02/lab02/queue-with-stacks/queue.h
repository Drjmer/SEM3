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
        second_stack.push(first_stack.top());
        first_stack.pop();
    }
}
template <typename T>
class Queue
{
    class Stack<T> first_stack;
    class Stack<T> second_stack;

public:
    Queue() {}
    ~Queue()
    {
        delete first_stack;
        delete second_stack;
    }
    void enqueue(T value)
    {
        first_stack.push(value);
    }
    T dequeue()
    {
        if(second_stack.isEmpty()){
        spill(first_stack,second_stack);
        return second_stack.pop();}
        else {
            second_stack.pop();
        }
    }
    T peek(){
        if(first_stack.getSize()!=0)
        return first_stack.top();
        else
        {
            spill(second_stack,first_stack);
            T ans=first_stack.top();
            return ans;
        }
    }
    bool isEmpty(){
        if(first_stack.getSize()==0&&second_stack.getSize()==0) return true;
        else return false;
    }
    size_t getSize(){
        return first_stack.getSize()+second_stack.getSize();
    }
};

// ENTER YOUR IMPLEMENTATIONS OF METHODS BELOW
