#include<bits/stdc++.h>
using namespace std;
int foo (int x ) {
try {
throw 20; // something has gone wrong !!
}
catch ( int  e ){ // type of e is matched !
cout << "An int exception occurred . " << e << endl;
}

}
int main()
{
    foo(10);
}
