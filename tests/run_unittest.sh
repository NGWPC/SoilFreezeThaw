#!/bin/bash
set -e

EWTS_PREFIX="${EWTS_PREFIX:-/tmp/ewts_install}"

${CXX:-g++} -Og -std=c++17 -Wall \
  -DBMI_ACTIVE \
  -DEWTS_HAVE_NGEN_BRIDGE \
  -I../include \
  -I../bmi \
  -I"${EWTS_PREFIX}/include" \
  -c ./main_unittest.cxx \
  -o main_unittest.o

${CXX:-g++} -Og -std=c++17 -Wall \
  -DBMI_ACTIVE \
  -DEWTS_HAVE_NGEN_BRIDGE \
  -I../include \
  -I../bmi \
  -I"${EWTS_PREFIX}/include" \
  -c ../src/bmi_soil_freeze_thaw.cxx \
  -o bmi_soil_freeze_thaw.o

${CXX:-g++} -Og -std=c++17 -Wall \
  -DBMI_ACTIVE \
  -DEWTS_HAVE_NGEN_BRIDGE \
  -I../include \
  -I../bmi \
  -I"${EWTS_PREFIX}/include" \
  -c ../src/soil_freeze_thaw.cxx \
  -o soil_freeze_thaw.o

${CXX:-g++} \
  main_unittest.o \
  bmi_soil_freeze_thaw.o \
  soil_freeze_thaw.o \
  -L"${EWTS_PREFIX}/lib" \
  -Wl,-rpath,"${EWTS_PREFIX}/lib" \
  -Wl,--no-as-needed \
  -lewts_ngen_bridge \
  -Wl,--as-needed \
  -lewts_cpp \
  -lboost_serialization \
  -lm \
  -o run_sft

./run_sft configs/unittest.txt
test_pass=$?

rm -f main_unittest.o bmi_soil_freeze_thaw.o soil_freeze_thaw.o
rm -f run_sft
rm -rf run_sft.dSYM

if [ "$test_pass" -eq 0 ]; then
  echo "SFT BMI unit test passed"
else
  echo "SFT BMI unit test failed with exit code ${test_pass}"
fi

exit $test_pass
