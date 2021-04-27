# Terraform Best Practices

1. Define Terraform Logical Frontier

2. Use TF ENV
```
https://github.com/tfutils/tfenv 
```

3. Always Set Up State (Backend)

4. Always Define Provider Versions

5. Use Service Accounts/Principal Accounts for authentication

6. Use Modules to Share Common Resources, avoiding Code Duplication, and saving Time

7. Use Workspaces to logically split environments

8. Just Output the necessary information

9. Avoid Hardcode variables if you can get it with Data Resource

10. Use for_each instead count