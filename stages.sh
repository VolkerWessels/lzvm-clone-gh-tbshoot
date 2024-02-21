#!/bin/bash

# Define the boolean variables for each stage
dev=true
tst=false
acc=true
prd=false

# Initialize an empty array
stages=()

# Add stages to the array based on the boolean variables
if [ "$dev" = true ]; then
    stages+=("\"dev\"")
fi
if [ "$tst" = true ]; then
    stages+=("\"tst\"")
fi
if [ "$acc" = true ]; then
    stages+=("\"acc\"")
fi
if [ "$prd" = true ]; then
    stages+=("\"prd\"")
fi

# Convert the array to a string
stages_string="["$(IFS=, ; echo "${stages[*]}")"]"

# Print the string
echo $stages_string

# Define the comma-separated list of users
users=

# Convert the list into an array
IFS=',' read -r -a user_array <<< "$users"

# Quote each user
quoted_users=()
for user in "${user_array[@]}"; do
    quoted_users+=("\"$user\"")
done

# Convert the array to a string
user_string="["$(IFS=, ; echo "${quoted_users[*]}")"]"

# Print the string
echo $user_string