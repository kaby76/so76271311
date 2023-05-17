# Generated from trgen 0.20.22
set -e
if [ -f transformGrammar.py ]; then python3 transformGrammar.py ; fi
rm -rf build
mkdir build
cd build
cmake .. -G "Visual Studio 17 2022" -A x64
cmake --build . --config Release
exit 0
