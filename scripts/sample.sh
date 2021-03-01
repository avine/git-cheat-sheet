# Goto ""./scripts"
cd "$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Goto "demo"
mkdir -p ../demo
cd ../demo

# Clean "demo"
sh ../scripts/rm.sh
sh ../scripts/init.sh

# Commit files
echo "Hello" >> hello.txt

mkdir ./folder
echo "Lorem" >> ./folder/lorem.txt

echo "ignored.txt" >> .gitignore
echo "Ignored" >> ignored.txt

git add .
git commit -m "First commit"

# Add untracked file
echo "Untracked\n\n" >> untracked.txt
