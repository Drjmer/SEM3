#include <iostream>
#include <map>
#include <vector>
#include "rdtsc.h"
using namespace std;
// Let's consider vectors again. When a vector is declared without specifying
// a size, it starts empty. However, there needs to be some initial allocation
// of space in anticipation of new elements being added. As we begin filling
// the vector, there will come a point when the allocated memory runs out.
// At this stage, the vector needs to allocate more memory. Your task is to
// write code that detects at what size the new allocation occurs and determine
// the amount of extra memory being allocated.

// Hint: Keep in mind that when a vector requires more memory, it not only
//   needs additional space but also needs to be relocated to ensure continuous
//   storage of the vector. This relocation process takes some time to execute.

int main()
{
  std::cout << "0 0\n"; // Dumping dummy data such that
  vector<int> arr;
  int size = arr.capacity();
  
  ClockCounter time;
  for (int i = 0; i < 1088; i++)
  {
    time.start();
    arr.push_back(i);
    double t=time.stop();
    cout<<i<<" "<<t<<endl;
  }
   // GNUplot does not complain
  return 0;
}
