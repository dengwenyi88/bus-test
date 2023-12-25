# build.sh
work=$(pwd)
build=${work}/build
src=${work}/src

rm -rf ${build}
mkdir -p ${build}

source_module=$1
testbentch_module=${source_module}_tb

# ctags -R --langmap=verilog:+.vh --langmap=verilog:+.v --languages=verilog --fields=+n

# 主要的编译过程
# cd ${build}
cd $src
# 安装iverilog
iverilog -o ${build}/${testbentch_module}.vvp \
    -I ${src}/include \
    ${src}/${source_module}.v \
    ${src}/${testbentch_module}.v

cd $build
vvp -n ${testbentch_module}.vvp

cd ${work}
