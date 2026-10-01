#!/bin/bash

# A simple script to find the first commit (by date) where Claude was present in a repo.
# Might also extend it to find commits by other coding agents.
# Useful for repos with a long history before Claude, so you can relive the glory days before they turned to shit.
# Remember that we can't detect everything. People love to claim they did work that they did not in fact actually do...
# FUCK YOU <3

INPUT_REPO=$1

if [ -z "$INPUT_REPO" ]
then
    echo "No input repo provided"
fi

pushd $INPUT_REPO > /dev/null

# Check either first co-author, or agents helper files
AGENTS_MD_COMMIT=$(git log --pretty='%at %H' --diff-filter=A -- AGENTS.md)
CLAUDE_MD_COMMIT=$(git log --pretty='%at %H' --diff-filter=A -- CLAUDE.md)

# TODO: improve grep pattern once everything works. Should be a bit more wildcardy. I'm fucking lazy as fuck
FIRST_CLAUDE_COMMIT=$(git log --pretty='%at %H' --grep 'Co-Authored-By: Claude' --date-order | tail -n 1)


FIRST_SLOP_COMMIT=$(echo -e "$AGENTS_MD_COMMIT\n$CLAUDE_MD_COMMIT\n$FIRST_CLAUDE_COMMIT" | uniq | sed -n '/[[:blank:]]/p' | sort -n | head -n 1)

if [ -z "$FIRST_SLOP_COMMIT" ]
then
    echo 'No slop commits <3'
else
    # probably the most horrible sed way, but I really don't like wasting too much time on regex
    COMMIT_HASH=$(echo "$FIRST_SLOP_COMMIT" | sed -E 's/.* (.*)/\1/')
    echo "First slop commit: $COMMIT_HASH"
fi

popd > /dev/null
