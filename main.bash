#                             Online Bash Shell.
#                 Code, Compile, Run and Debug Bash script online.
# Write your code in this editor and press "Run" button to execute it.

echo "The program creates a new text file named mytextfile.txt," \
     "writes “Hello, World!” to it, and appends the current timestamp." \
     "If the file already exists, it displays a message; otherwise," \
     "it creates the file with the specified content. 🚀"


filename="mytextfile.txt"

if [ -e "$filename" ]; then
    echo "File '$filename' already exists!"
else
    echo "$(date '+%Y-%m-%d %H:%M:%S')"
    echo "Hello, World!" > "$filename"
    echo "$(date '+%Y-%m-%d %H:%M:%S')" >> "$filename"
    
fi