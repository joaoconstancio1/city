#!/bin/bash
#!/bin/sh

outputFile="$(pwd)/test/coverage_helper_test.dart"
packageName="$(cat pubspec.yaml| grep '^name: ' | awk '{print $2}')"

if [ "$packageName" = "" ]; then
    echo "Run $0 from the root of your Dart/Flutter project"
    exit 1
fi

echo "/// *** GENERATED FILE - ANY CHANGES WOULD BE OBSOLETE ON NEXT GENERATION *** ///\n" > "$outputFile"
echo "/// Helper to test coverage for all project files" >> "$outputFile"
echo "library;" >> "$outputFile"
echo "// ignore_for_file: unused_import" >> "$outputFile"
find lib -name '*.dart' | grep -v '.g.dart' | grep -v 'generated_plugin_registrant' | awk -v package=$packageName '{gsub("^lib", "", $1); printf("import '\''package:%s%s'\'';\n", package, $1);}' >> "$outputFile"
echo "void main() {}" >> "$outputFile"


flutter test --coverage
genhtml coverage/lcov.info -o coverage/html


if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    xdg-open coverage/html/index.html
elif [[ "$OSTYPE" == "darwin"* ]]; then
    open coverage/html/index.html
elif [[ "$OSTYPE" == "cygwin" || "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
    start coverage/html/index.html
else
    echo "Manually open the coverage/html/index.html file in your browser."
fi
