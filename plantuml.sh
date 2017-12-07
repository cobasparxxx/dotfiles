#!/bin/bash
java -jar $HOME/dotfiles/lib/plantuml.jar -tpng $@
open ${@%%.*}.png
