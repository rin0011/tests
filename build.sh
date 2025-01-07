#!/bin/bash
        LTO=thin 
        export ARCH=arm64
        export SUBARCH=arm64
        export HEADER_ARCH=arm64
        export PATH=/home/lin/clang-aosp/bin:$PATH
        export KBUILD_BUILD_USER=$(echo ${rin} | tr A-Z a-z)
        AR_CMD="ARCH=${ARCH} SUBARCH=${SUBARCH} HEADER_ARCH=${HEADER_ARCH}"
        BA_CMD="CC=clang CXX=clang++"
        EX_CMD="LD=ld.lld AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump READELF=llvm-readelf OBJSIZE=llvm-size STRIP=llvm-strip LLVM=1 LLVM_IAS=1"
        DEFCONFIG="gki_defconfig vendor/kalama_GKI.config vendor/oplus/kalama_GKI.config vendor/debugfs.config vendor/oplus/aston.config"
        make O=out $AR_CMD $BA_CMD $EX_CMD $DEFCONFIG
        scripts/config --file out/.config -e LTO_CLANG -d LTO_NONE -e LTO_CLANG_THIN -d LTO_CLANG_FULL -e THINLTO
        make -j$(nproc --all) O=out $AR_CMD $BA_CMD $EX_CMD
