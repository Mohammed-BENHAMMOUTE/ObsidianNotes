[Longest Palindromic Substring](https://leetcode.com/problems/longest-palindromic-substring/)
the problem here requires us to deliver the longest palindromic substring, the solution to this problem will be from each charater try to find the longest palindromin substring that is centered at that character, meaning the we going to start from the center and move outwords.
but there is a problem, if we start from just one character the palindrom will always be of odd length, thats why we need a second iteration for the where we start from two adjacent charcters and move outwards, that way we are guarenteeing the substring is of even length.

here is my solution:

```Cpp
class Solution {  
public:  
    string longestPalindrome(string s) {  
        int n = s.size();  
        if (n == 0) return "";  
        string  res = "";  
        for(int i = 0; i < n ; i++) {  
            string temp = checkPalindrome(s, i, i);  
            if(res.length() < temp.length()) {  
                res = temp;  
            }        }        for(int i =0 ; i < n-1; i++) {  
            string temp2 = checkPalindrome(s, i, i+1);  
            if(res.length() < temp2.length()) {  
                res = temp2;  
            }        }        return res;  
    }private:  
    string checkPalindrome(string& s , int l , int r) {  
        while(l >=0 && r<s.length() && s[l] == s[r]) {  
            l--;  
            r++;  
        }        return s.substr(l+1 ,r-l-1);  
	}
};
```


[300. Longest Increasing Subsequence](https://leetcode.com/problems/longest-increasing-subsequence/)
