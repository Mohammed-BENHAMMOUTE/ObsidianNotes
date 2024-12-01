[[authentication]] 
## What is OAuth?
OAuth is authorisation standard that anyone can implement. there are two versions of OAuth OAuth 1.0a and OAuth 2.0. now we use the 2.0 version.

## Why OAuth?
OAuth is a  ``password anti-pattern``.  OAuth is a system where the identity provider is delagated to an outside service or account that the user is signed in to, so here is how t works:
an end user chooses an identity provider that generates a signed token for him  and then its hand off to the application to authenticate the user.

`"Signed tokens can **verify the integrity of the claims contained within it**, while encrypted tokens hide those claims from other parties. When tokens are signed using public/private key pairs, the signature also certifies that only the party holding the private key is the one that signed it." `
here is an image of how it works.
![[Pasted image 20240807122646.png]]

