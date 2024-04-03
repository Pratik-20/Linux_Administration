#!/bin/bash

# Define a function to calculate profit or loss
calculate_profit_or_loss() {
    local cost_price="$1"
    local selling_price="$2"

    if [ "$cost_price" -eq "$selling_price" ]; then
        echo "No profit or no loss."
    elif [ "$selling_price" -gt "$cost_price" ]; then
        profit=$((selling_price - cost_price))
        echo "Kudos To You! You have earned a profit of \$${profit}"
    else
        loss=$((cost_price - selling_price))
        echo "Total Loss: \$${loss}"
    fi
}

# Example usage
echo "Hello World"
echo "Enter the cost price of the item:"
read cost_price
echo "Enter the selling price of the item:"
read selling_price

# Call the function
calculate_profit_or_loss "$cost_price" "$selling_price"
