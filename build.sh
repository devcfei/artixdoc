#!/bin/bash

ROOT=$PWD


dist()
{
    echo "distribution to docs"
    cd hugo-theme-artix/exampleSite
    hugo --baseUrl="https://devcfei.github.io/artixdoc"
    cd $ROOT

    rm -rf docs
    cp -r hugo-theme-artix/exampleSite/public docs

    # update dist
    #  
    git add .
    git commit --amend --no-edit
    git push -f
}

preview()
{
    echo "preview distribution contents..."

    cd hugo-theme-artix/exampleSite
    hugo server
    cd $ROOT
}


usage()
{
    echo "Usage: "

}


if [ -n "$1" ]; then
    if [ "$1" = "--init" ]; then
        git submodule init
        git submodule update
        git submodule foreach git checkout dev
        git submodule foreach git pull --rebase

    elif [ "$1" = "-d" ]; then
        echo "distribution..."
        dist
    elif [ "$1" = "-p" ]; then
        echo "prevew..."
        preview
    else
        echo "unknown arg"
        usage
    fi

else
    echo "no arguments... default preview"
    preview
    echo $ROOT
fi
