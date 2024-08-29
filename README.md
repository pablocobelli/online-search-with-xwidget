# Online Search with xwidget

**Author:** Pablo Cobelli
**Date:** [2024-08-26]
**Description:** A package for searching online documentation and resources using xwidget-webkit.

## Introduction

This package provides tools to search for information online using xwidget-webkit. It includes functions to:
- Open URLs in an xwidget-webkit window.
- Run a Python script with user input and display the output.
- Search the web for documentation and other resources.

## Installation

To install the `online-search-with-xwidget` package, go to ~package.el~ file in ~doom emacs~ configuration
and add the following:

``` emacs-lisp
(package! online-search-with-xwidget
  :recipe (:host github
           :repo "pablocobelli/online-search-with-xwidget"
           :files ("online-search-with-xwidget.el" "search_with_duckduckgo.py")))
```

## Suggested keybindings for ~emacs~

SPC o D : search docs from prompt
SPC o W : search docs from word under cursor
SPC o S : search online (not only docs)

``` emacs-lisp
(map! :leader
      :desc "Search online python docs"
      "o D" #'oswx-search-online-for-python-docs
      :desc "Search word under cursor in online Python docs"
      "o W" #'oswx-search-online-for-python-docs-for-word-under-cursor
      :desc "Search online"
      "o S" #'oswx-search-online)
```
