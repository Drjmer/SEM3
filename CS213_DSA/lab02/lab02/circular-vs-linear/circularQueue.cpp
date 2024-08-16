#include <stdlib.h>
#include "queue.h"

using namespace std;

template <typename T> bool DynamicQueue<T> :: isEmpty() {

  return head==tail; // dummy return
}

template <typename T> bool DynamicQueue<T> :: isFull() {
  return tail==-1; // dummy return
}

template <typename T> void DynamicQueue<T> :: grow() {
  T inital_size=size();
  N=nextSize();
  T* tmp=new T[N];
  for(int i=0;i<inital_size+1;i++)
  {
    tmp[i]=A[(i+head)%inital_size];
  }
  delete [] A;
  head=0;
  tail=inital_size+1;
  A=tmp;
}

template <typename T> unsigned int DynamicQueue<T> :: size() {
  return (tail-head+N)%N; // dummy return
}

template <typename T> void DynamicQueue<T> :: QInsert(T x) {
  if(isFull()){
    grow();
    A[tail]=x;
    tail=(tail+1)%N;
  }
  else{
    A[tail]=x;
    tail=(tail+1)%N;
    if(tail==head) tail=-1;
  }
}

template <typename T> bool DynamicQueue<T> :: QDelete(T* x) {
  if(isEmpty()){
    return false;
  }
  x=A+head;
  head=(head+1+N)%N;
  if(tail==-1) tail=(head-1+N)%N;
  if(head==tail) head=tail=0;
  return true; // dummy return
}
