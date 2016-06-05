---
title: "Review"
author: "Fred Jaworski"
date: "May 23, 2016"
---

# Peer Review, Login

Code is used to control access to the application.

SHA: 48ef8f2d3b395c2a63ef4dcc4e53be13ceeda189

## Files
- Login.aspx.cs

#Comments
- Line 48, public variable HashLength should be private or protected, should also be stylized as hashLength following standards, could possibly be local to GetUserID method
- Line 21, SqlConnection should be initialized inside the the PageLoad function
- Lines 69 - 83 need more comments to describe what exactly is being done
- Lines 17, 18 unnecessary whitespace

Overall, more comments