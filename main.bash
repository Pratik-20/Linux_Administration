#                             Online Bash Shell.
#                 Code, Compile, Run and Debug Bash script online.
# Write your code in this editor and press "Run" button to execute it.


#!/bin/bash

# Define the filename for storing birthdays
BIRTHDAY_FILE="birthdays.json"

# Load birthdays from the JSON file
load_birthdays() {
    if [ -f "$BIRTHDAY_FILE" ]; then
        cat "$BIRTHDAY_FILE"
    else
        echo "{}"
    fi
}

# Save birthdays to the JSON file
save_birthdays() {
    echo "$1" > "$BIRTHDAY_FILE"
}

# Add a new birthday to the list
add_birthday() {
    echo "Enter friend's name:"
    read name
    echo "Enter birthday (YYYY-MM-DD):"
    read date_str
    if date -d "$date_str" >/dev/null 2>&1; then
        birthdays=$(load_birthdays)
        birthdays=$(echo "$birthdays" | jq --arg name "$name" --arg date "$date_str" '. + {($name): $date}')
        save_birthdays "$birthdays"
        echo "$name's birthday added successfully!"
    else
        echo "Invalid date format. Please use YYYY-MM-DD."
    fi
}

# Delete a birthday from the list
delete_birthday() {
    echo "Enter friend's name to delete:"
    read name
    birthdays=$(load_birthdays)
    if [ "$(echo "$birthdays" | jq -r ".[\"$name\"]")" != "null" ]; then
        birthdays=$(echo "$birthdays" | jq "del(.[\"$name\"])")
        save_birthdays "$birthdays"
        echo "$name's birthday deleted successfully!"
    else
        echo "$name not found in the list."
    fi
}

# List all birthdays
list_birthdays() {
    birthdays=$(load_birthdays)
    if [ "$birthdays" != "{}" ]; then
        echo "Birthdays:"
        echo "$birthdays" | jq -r 'to_entries[] | "\(.key): \(.value)"'
    else
        echo "No birthdays found."
    fi
}

# Remind birthdays at 10 am
remind_birthdays() {
    birthdays=$(load_birthdays)
    today=$(date +%Y-%m-%d)
    for name in $(echo "$birthdays" | jq -r 'keys[]'); do
        date_str=$(echo "$birthdays" | jq -r ".[\"$name\"]")
        if [ "$date_str" = "$today" ]; then
            echo "🎂 Happy Birthday, $name! 🎉"
            # You can add code here to send a notification or perform any other action
            # at 10 am on the birthday.
        fi
    done
}

# Main menu
while true; do
    echo -e "\nBirthday Reminder"
    echo "1. Add birthday"
    echo "2. Delete birthday"
    echo "3. List birthdays"
    echo "4. Remind birthdays"
    echo "5. Exit"
    read -p "Enter your choice: " choice

    case "$choice" in
        1) add_birthday ;;
        2) delete_birthday ;;
        3) list_birthdays ;;
        4) remind_birthdays ;;
        5) echo "Goodbye!"; break ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
done

