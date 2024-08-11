#include <stdlib.h>
#include "queue.h"

using namespace std;

template <typename T> bool DynamicQueue<T> :: isEmpty() {
  return head==tail; // dummy return
}

template <typename T> bool DynamicQueue<T> :: isFull() {
  return tail-head==N-1; // dummy return
}

template <typename T> void DynamicQueue<T> :: grow() {
  N=nextSize();
  T* tmp=new T[N];
  for(int i=0;i<tail;i++)
  {
    tmp[i]=A[i];
  }
  delete [] A;
  A=tmp;
}

template <typename T> unsigned int DynamicQueue<T> :: size() {
  return tail-head; // dummy return
}

template <typename T> void DynamicQueue<T> :: QInsert(T x) {
  if(isFull())
  {
    grow();
    A[tail]=x;
    tail++;
  }
  else{
    if(head!=0 && tail=N-1){
      for(int i=0;i<size()+1;i++){
        A[i]=A[i+head];
      }
      tail=size()+1;
      A[tail]=x;
      tail++;
    }
    else{
      A[tail]=x;
      tail++;
    }
  }
}

template <typename T> bool DynamicQueue<T> :: QDelete(T* x) {
  if(isEmpty())
  {
    return false;
    
  }
  else{
    x=A+head;
    head++;
    if(head==tail) head=tail=0;
    return true;
  }

}
