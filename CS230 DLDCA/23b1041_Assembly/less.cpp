#include<bits/stdc++.h>
using namespace std;

struct Complex{
    int rem;
    int im;
};

int isLessThan(Complex e1,Complex e2)
{
    int ans=0;
    if(e1.rem<e2.rem) ans=1;
    else if(e1.rem==e2.rem && e1.im<e2.im) ans=1;

    return ans;
}
int numLessThan(Complex elt, Complex* A, int start, int end){

    int cnt=0;
    for(int i=start;i<end;i++){
        if(isLessThan(A[i],elt)) cnt++;
    }
    return cnt;

}
int main(){
    Complex *A= new Complex[4];
    A[0].rem=0;A[0].im=0;
    A[1].rem=-1;A[1].im=2;
    A[2].rem=0;A[2].im=2;
    A[3].rem=-1;A[3].im=-1;
    Complex elt;
    elt.rem=-1;elt.im=0;
    cout<<numLessThan(elt,A,0,4)<<endl;
}