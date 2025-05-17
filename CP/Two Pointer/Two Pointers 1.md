In the two pointers method, two pointers are used to iterate through the array
values.

Both pointers can move to one direction only, which ensures that the algorithm works efficiently. Next we discuss two problems that can be solved
using the two pointers method.

## 1. Subarray Sum equal to a given target:

Goal: we try to find a subarray with sum equal to x;

we can solve this using two pointers, where the two pointers are both set to 0, the right pointer keeps moving to the right as long as the element we add doesn't make the sum greater than the target sum.

here are the steps:
1. keep adding elements from left to the right as long as the current sum is less then the target sum.
2. if we realize that we have exceeded the target sum we decrease the current sum by moving the left pointer to the right, until the current sum is less then or equal to the target sum.
in this process we would have processed all the elements in the array at most twice, meaning we either include it or exclude it, so at worst case we process each element at most twice.

## 2. Two Sum Problem:
we sort the array and we initialize two pointers one to the left, the other to the right:

then we move each element either to the left or to the right, depending on the value of the sum of the two elements;

## 3. Nearest smaller elements
Consider the problem of finding for each array element the nearest smaller element, i.e., the first smaller element that precedes the element in the array. It is possible that no such element exists, in which case the algorithm should report this.


## 4. Sliding window Minimum

we have an array and we are asked to give all the minimums of all windows of length K,
to do that we can keep a deque that its first element will be the smallest element, so the deque will be sorted and will contain indices, for the first window we go through it , and push back the element if its larger that the back() of the deque, 
after that when we move to the next window we first remove from the front all the elements that has indices less than i-k (index <= i - k)
after that we add the new element to the back our our dequeue and we take the minimum.

