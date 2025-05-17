[[Two pointers]]

# 1. Segment with good sum

This problem asks us for a given array, to get the length of the longest/shortest array, that has the sum either less than S or greater than S.

lets look at the solution for both:
`find the max length of subarray with sum less than s`:

to way to go with this is to do a fast right pointer with a slow left pointer, we will push the right pointer as long as the sum is less than s.
if the sum exceeds s, we move the left pointer until the 