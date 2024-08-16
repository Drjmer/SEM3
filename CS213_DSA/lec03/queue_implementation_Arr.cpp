#include<bits/stdc++.h>
using namespace std;
class queue_i{

public: 
int *q;
int size;
int head;
int tail;

queue_i(int size) 
{
    head=0;
    tail=0;
    this->size=size;
    q=new int[this->size];
}

//push
void push(int data)
{
    if(no_of_elmts()==this->size-1) expand();

    q[tail]=data;
    this->tail=(this->tail+1)%this->size;
}

int no_of_elmts()
{

    return (this->size+tail-head)%this->size;

}
void expand(){
    int new_size=2*this->size;
    int *tmp=new int[new_size];
    for(int i=0;i<this->size;i++)
    {
        tmp[i]=this->q[head];
        head=(head+1)%this->size;
    }
    this->head=0;
    this->tail=this->size-1;
    delete [] this->q;
    this->q=tmp;
    this->size=new_size;
}
void display()
{
    for(int i=0;i<this->size;i++) cout<<q[i]<<" ";
    cout<<endl;
}
void pop(){
    if(empty()) cout<<"Nothing to pop"<<endl;

    
    head=(head+1)%this->size; 
    if(head==tail) head=tail=0;
}
void front(){

    cout<<q[head]<<endl;
}
bool empty(){

    return head==tail;
}
};

int main()
{
    queue_i q(2);
    q.push(1);
    q.push(2);
    q.push(3);
    q.push(4);
    q.push(5);  
    q.display();
    cout<<q.no_of_elmts()<<endl;
    // q.pop();
    cout<<q.no_of_elmts()<<endl;
    q.front();
    // cout<<q.size<<endl;

}