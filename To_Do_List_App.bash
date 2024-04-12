#                             Online Bash Shell.
#                 Code, Compile, Run and Debug Bash script online.
# Write your code in this editor and press "Run" button to execute it.


#!/bin/bash

# File path for storing tasks
TASKS_FILE="tasks.txt"

# Check if tasks.txt exists, and create it if not
if [ ! -f "$TASKS_FILE" ]; then
    touch "$TASKS_FILE"
    echo "Created $TASKS_FILE"
fi

# Function to add a task
add_task() {
    read -p "Enter task description: " task_description
    read -p "Enter task execution time (e.g., 14:30): " task_time

    echo "$task_description $task_time" >> "$TASKS_FILE"
    echo "Task '$task_description' added successfully!"
}

# Function to delete a task
delete_task() {
    read -p "Enter task description to delete: " task_description

    # Remove the specified task
    sed -i "/^$task_description/d" "$TASKS_FILE"
    echo "Task '$task_description' deleted successfully!"
}

# Function to check tasks
check_tasks() {
    current_time=$(date +"%H:%M")
    while read -r line; do
        task_description=$(echo "$line" | awk '{print $1}')
        task_time=$(echo "$line" | awk '{print $2}')
        if [ "$task_time" == "$current_time" ]; then
            notify-send "Task Reminder" "Task: $task_description\nTime: $task_time"
        fi
    done < "$TASKS_FILE"
}

# Main menu
while true; do
    echo -e "\n--- To-Do List Menu ---"
    echo "1. Add Task"
    echo "2. Delete Task"
    echo "3. Check Tasks"
    echo "0. Exit"

    read -p "Enter your choice: " choice
    case "$choice" in
        1) add_task ;;
        2) delete_task ;;
        3) check_tasks ;;
        0) break ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
done

