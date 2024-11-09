#!/bin/bash

flutter test --coverage
genhtml coverage/lcov.info -o coverage/html

# Detecta o sistema operacional e abre o relatório no navegador
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open coverage/html/index.html
elif [[ "$OSTYPE" == "darwin"* ]]; then
    open coverage/html/index.html
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    start coverage/html/index.html
else
    echo "Manually open the coverage/html/index.html file in your browser."
fi
