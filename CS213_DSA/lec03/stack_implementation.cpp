#include<bits/stdc++.h>
using namespace std;
class arr_stack{
    public:
    int N;
    int * s=NULL; //pointer to an array
    int top1=-1;

    //constructor
    arr_stack(int size)
    {
        s=new int[size];
        this->N=size;
    }

    //push operation
    void push(int data)
    {
        if(top1==this->N) expand();
        s[++top1]=data;
    }

    void expand(){
        int new_size=2*this->N;
        int *tmp=new int[new_size];
        for(int i=0;i<this->N;i++) tmp[i]=this->s[i];
        delete [] s;
        s=tmp;
        this->N=new_size;
    }

    //pop operation
    void pop()
    {
        if(top1<0) cout<<"Stack Underflow"<<endl;
        else 
        {
            top1--;
        }
    }

    void top(){
        if(top1>=0)
        cout<< s[top1]<<endl;
    }

    void empty()
    {
        if(top1<0) cout<<"Empty"<<endl;
        else cout<<"Not Empty"<<endl;
    }
};

int main()
{
    arr_stack s1(5);
    s1.push(1);
    s1.push(2);
    s1.top();
    s1.pop();
    s1.top();
    s1.pop();
    s1.top();
    s1.empty();
}