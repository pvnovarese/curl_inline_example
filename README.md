# curl_inline_example

This is an example of using the anchore inline_scan capability with jenkins.

There are two policy bundles included.  The policy_curl_blacklist_only.json bundle has three rules (all issue stops):
1) curl package blacklist
2) check for exposed ports 22, 80, 443 
3) check if effective user is root

The policy_curl_blacklist_instruction.json bundle is idenitcal with the addition of:
4) a dockerfile must be provided
5) check for any RUN instruction in the dockerfile that has a "curl" in it

There are two dockerfiles.  The simple dockerfile will fail with with either policy.  The multistage dockerfile will pass with the blacklist-only policy since the curl package is added in the build stage but does not appear in the final stage, which is the image that is actually scanned.  The blacklist-instruction policy will stop this dockerfile, however, because it will see the curl commands issued in the dockerfile RUN instructions.
