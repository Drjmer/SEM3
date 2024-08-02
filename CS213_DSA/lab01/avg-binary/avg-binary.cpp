#include <iostream>
using namespace std;
// Consider the binary search algorithm presented in class. We are interested
// in determining the average execution time of the binary search. To
// accomplish this, let's conduct an experiment.

// Suppose we have an array of size 1024, which contains distinct elements
// arranged in non-increasing order. We have already analyzed the running
// time when the element being searched for is not present in the array.
// Now, let's assume that we are only searching for elements that we know
// exist in the array.

// Our goal is to experimentally calculate the average number of
// iterations required to search for all 1024 elements in the array.

// In the following,
//   -- Implement BinarySearch that can handle non-increasing array
//   -- Harness BinarySearch such that we can compute avarage number
//      of iterations

int BinarySearch(int *S, int n, int e)
{
  int iteration_count = 0;
  // Implement binary search here
  int s = 0, end = n, mid = (s + end) / 2;
  while (s < e)
  {
    if (S[mid] == e)
      {
        
        break;
      }
    else if (S[mid] > e)
    {
      end = mid;
    
    }
    else
    {
      s = mid + 1;
      
    }
    iteration_count++;
    mid=(s+end)/2;
  }
  // instead of returning position return the number
  // of executed iterations of binary search.
  return iteration_count;
}

int main()
{
  unsigned size = 1024;
  int S[1024];
  float average = 0;
  // Initialize array S with distinct elements
  for(int i=0;i<1024;i++) S[i]=i;
  // search 1024 element stored in S and compute
  // the average number of iterations in binary search
  for(int i=0;i<1024;i++) {
    average+=BinarySearch(S,size,i);
  }
  average/=1024;
  cout << "Average: " << average << "\n";
  
  return 0;
}
