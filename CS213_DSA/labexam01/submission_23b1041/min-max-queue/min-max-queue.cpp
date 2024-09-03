#include "min-max-queue.h"

/*
The task of this question is to implement a Min Max Queue, a queue
data structure that can find the minimum/maximum of ALL
the elements CURRENTLY PRESENT in it in O(1)/amortized O(1) time.
The queue should also be able to push/pop in amortized O(1) time.
Checking front/empty should also be O(1) time.

In min-max-queue.cpp, complete the function definitions
(You may leave the constructor/destructor empty if not needed).
Feel free to add any member variables/functions to this class or
any new class/struct(s) if needed. There are brief descriptions
for the given functions as well.

Constraints:
 - 0 <= n <= 10^7 (or 10 million) where n are the number of
   elements pushed/popped from queue.
 - Only non-negative integers (any from 0 to 2^31-1) will be
   pushed into the queue.

2 public testcases have been given to you (one for small n and other
for large). There will be some hidden testcases as well.
Your grading will depend on the output obtained from the hidden
testcases ONLY and NOT the 2 public ones.

"min-max-queue.cpp" shall ONLY be considered for grading (Don't put your solution in any other file).
DON'T TOUCH "main.cpp" or any ".h" file.

NOTE: NO OTHER "#include"s are allowed. Straight 0 if did.

During grading, a time limit will be set for the execution on the
testcases. If the functions are implemented in O(1)/amortized O(1)
time, then you don't need to worry about the time limit, they won't
exceed it. (Long testcase may take few seconds).

More efficient implementations will get greater marks!!

In case of the queue is empty, return INT_MAX for getMin(),
return INT_MIN for getMax() and return -1 for front().

*/


class MinMaxQueue {
private:
  // Add your fields here!!
  stack<long long >mini,maxi,buff1,buff2;
  long long *arr=new long long [10000000];
  long long  head=0,tail=0;
  long long  N=10000000;
  
public:

  void push(int n) {
    if(((tail-head+N)%N+1)==N) throw "Full";
    else{
    arr[tail]=n;
    tail=(tail+1)%N;

    if(mini.empty()){
      mini.push(n);
    }
    else{
      int ans=mini.top();
      if(n<ans){
        mini.push(n);
      }
      else{
        while(!mini.empty()){
          int a1=mini.top();
          if(a1<n) {
            mini.pop();
            buff2.push(a1);
          }
          else break;
        }
        mini.push(n);
        while(!buff2.empty()){
          int a1=buff2.top();
          buff2.pop();
          mini.push(a1);
        }
      }
    }

    if(maxi.empty()){
      maxi.push(n);
    }
    else{
      int ans=maxi.top();
      if(n>ans){
        maxi.push(n);
      }
      else{
        while(!maxi.empty()){
          int a1=maxi.top();
          if(a1>n) {
            maxi.pop();
            buff1.push(a1);
          }
          else break;
        }
        maxi.push(n);
        while(!buff1.empty()){
          int a1=buff1.top();
          buff1.pop();
          maxi.push(a1);
        }
      }
    }
    }
  }

  void pop() {
    int num;
    if(empty()){
      throw "Empty";
    }
    else{
    num=arr[head];
    head=(head+1)%N;
    if(head==tail){
      head=0;
      tail=0;
    }
    if(!maxi.empty()) 
    {
      while(!maxi.empty()){
        int a1=maxi.top();
        maxi.pop();
        if(a1==num) break;
        buff1.push(a1);
      }

      while(!buff1.empty()){
        int a1=buff1.top();
        maxi.push(a1);
        buff1.pop();
      }
    }
   

    if(!mini.empty()) 
    {
      while(!mini.empty()){
        int a1=mini.top();
        mini.pop();
        if(a1==num) break;
        buff2.push(a1);
      }

      while(!buff2.empty()){
        int a1=buff2.top();
        mini.push(a1);
        buff2.pop();
      }
    }

    }
  }

  int front() {
    if(empty()) throw "Empty";
    else
    return arr[head]; // dummy
  }

  int getMin() {
    if(!mini.empty()) return mini.top();
    else return INT_MAX; // dummy

  }

  int getMax() {
    if(!maxi.empty()) return maxi.top();
    else
    return INT_MIN; // dummy
  }

  bool empty() {
    return (tail-head)==0; // dummy
  }
};
