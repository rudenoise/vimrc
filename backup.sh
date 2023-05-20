#!/bin/sh

cp $HOME/.vimrc ./

rm -fr ftplugin/*

cp $HOME/.vim/ftplugin/* ftplugin/
