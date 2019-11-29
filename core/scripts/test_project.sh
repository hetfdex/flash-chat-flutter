#!bin/bash -e

cd ..

flutter format .

flutter analyze .

flutter test --coverage

genhtml coverage/lcov.info  --output-directory coverage/html/

open coverage/html/index.html