#! /bin/bash
# Exit on error_code(-1)
set -e
#
function create_repo_dir_if_absent() {
    cd ~
    REPO_DIR="$(pwd)/src/$1/"
    mkdir -p $REPO_DIR
    cd $REPO_DIR
    echo "$REPO_DIR"
}

function set_git_identity() {
    # Set git identity
    set -e
    git config --global user.email ksanichalive@gmail.com 
    git config --global user.name ksanich
    set +e
}

# Create local repo files
REPO_NAME=$1
REPO_DIR_CREATED=$(create_repo_dir_if_absent $REPO_NAME)
echo "Local files located at: $REPO_DIR_CREATED"
cd $REPO_DIR_CREATED
# TODO: run `init` only when `.git` file is absent (e.g. git repo was noy initialized)
set +e
git init -b main
echo "This is readme" | tee -a README.md
# TODO: run `create` only when remote is absent
gh repo create $REPO_NAME --public --source=. --remote=$REPO_NAME
#TODO: push local files
set_git_identity
git add --all .
git commit -m "[gh_scripts-0] Initial commit."
git push -u origin main
set -e
echo "Local repo created at: $REPO_DIR_CREATED"
