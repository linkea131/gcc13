#!/bin/bash
# by Linke 2023 临客
#-----可变参数-start-----
# 要编译的gcc版本
# gcc的大版本号
gcc_version=13.2
# gcc的具体版本号
version=$gcc_version.0

#-----可变参数-end-----

echo -e "\033[31m\033[01m[ $1即将安装gcc$version ]\033[0m"
echo -e "\033[31m\033[01m[ $1即将安装zlib-1.3 ]\033[0m"
echo -e "\033[31m\033[01m[ $1即将安装libunwind-1.6.2 ]\033[0m"
echo -e "\033[31m\033[01m[ $1即将安装perl-5.36.0 ]\033[0m"
echo -e "\033[31m\033[01m[ $1即将安装Texinfo-7.0.3 ]\033[0m"

# 安装依赖以及升级索引
{
yum install dnf -y

# 更新系统
dnf update -y

# 安装依赖环境
dnf install wget bzip2 gcc-c++ libstdc++-devel tar -y
dnf install glibc-devel.i686 libstdc++-devel.i686 glibc-* libstdc++-* gcc-* gcc bzip2 -y

# 安装开发包
yum -y groupinstall "Development Tools"
yum groupinstall -y "Office Suite and Productivity" --setopt=group_package_types=mandatory,default,optional
}

# 下载zlib
{
echo -e '正在下载zlib'
# 使用官方网址下载--速度可能比较慢 1
wget https://zlib.net/zlib-1.3.tar.gz
echo -e "正在解压"
# 静默解压
tar xf zlib-1.3.tar.gz
cd zlib-1.3
echo -e "正在安装zlib-1.3"
./configure && make -j$(nproc) && make install
echo -e "libunwind-1.6.2安装已完成"
# 回主目录
cd
rm -rf zlib-*.tar.gz
rm -rf zlib-*
}

# 下载libunwind
{
echo -e '正在下载libunwind'
# 使用官方网址下载--速度可能比较慢 1
wget http://download.savannah.nongnu.org/releases/libunwind/libunwind-1.6.2.tar.gz
echo -e "正在解压libunwind"
# 静默解压
tar -zxf libunwind-*.tar.gz
cd libunwind-1.6.2
echo -e "正 在 安 装 libunwind"
CFLAGS=-fPIC ./configure
# 编译安装
echo -e "正在安装libunwind-1.6.2"
CFLAGS=-fPIC make -j$(nproc) && CFLAGS=-fPIC make -j$(nproc) install
echo -e "libunwind-1.6.2安装已完成"
# 回主目录
cd
rm -rf libunwind-*tar.gz
rm -rf libunwind-*
}

# 下载perl
{
echo -e '正在下载perl'
# 使用官方网址下载--速度可能比较慢 1
wget https://www.cpan.org/src/5.0/perl-5.36.0.tar.gz
echo -e "正在解压perl"
# 静默解压
tar xf perl-5.36.0.tar.gz
cd perl-5.36.0
# 编译安装
echo -e "正在安装perl-5.36.0"
./Configure -des -Dprefix=/usr/perl && make -j$(nproc)  && make -j$(nproc)  test && make -j$(nproc)  install
ln -sf /usr/perl/bin/perl /usr/bin/perl
# 回主目录
cd
rm -rf perl-*tar.gz
rm -rf perl-*
}

# 下载texinfo
{
echo -e '正在下载texinfo'
# 使用官方网址下载--速度可能比较慢 1
wget https://ftp.gnu.org/gnu/texinfo/texinfo-7.0.3.tar.gz
echo -e "正在解压texinfo"
# 静默解压
tar zxvf texinfo-7.0.3.tar.gz
cd texinfo-7.0.3
# 编译安装
echo -e "正在安装texinfo-7.0.3"
./configure && make -j$(nproc) && make -j$(nproc) install
# 回主目录
cd
rm -rf texinfo-*tar.gz
rm -rf texinfo-*
}

# 下载Gcc
{
echo -e '正在下载Gcc'
# 使用官方网址下载--速度可能比较慢 1
wget https://gcc.gnu.org/pub/gcc/releases/gcc-13.2.0/gcc-$version.tar.gz

echo -e "正在解压Gcc"
# 静默解压
tar -zxf gcc-*.tar.gz
# 删除压缩包
echo -e "解压完成，删除压缩包"
rm -rf gcc-*.tar.gz
cd gcc-*

# 下载编译所需支持库
echo -e "正在自动下载编译所需支持库"
./contrib/download_prerequisites
echo -e "所需编译支持库下载完成"
# 自动生成Makefile文件
echo -e "生成Makefile文件"
./configure --prefix=/usr/local/gcc --enable-languages=c,c++,fortran,lto --mandir=/usr/share/man --infodir=/usr/share/info --with-bugurl=http://bugzilla.redhat.com/bugzilla --enable-shared --enable-threads=posix --enable-checking=release --enable-multilib --with-system-zlib --enable-__cxa_atexit --enable-libunwind-exceptions --enable-gnu-unique-object --enable-linker-build-id --with-gcc-major-version-only --with-linker-hash-style=gnu --enable-plugin --enable-initfini-array --with-isl --enable-libmpx --enable-offload-targets=nvptx-none --without-cuda-driver --enable-gnu-indirect-function --enable-cet --with-tune=generic --with-arch_32=x86-64 --build=x86_64-redhat-linux --enable-bootstrap --enable-maintainer-mode

# 温馨提示
echo -e "\033[31m\033[01m[ $1警告⚠️此安装时长由服务器配置决定 配置越高越快 ]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️此安装时长由服务器配置决定 配置越高越快 ]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️此安装时长由服务器配置决定 配置越高越快 ]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️低于2G2H以及母鸡严禁编译安装后果自负推荐使用RPM或yum安装较为新的版本 ]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️如配置低的离谱请勿编译安装轻者长时间处于无响应状态重则宕机 ]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️此编译安装时间较长 4H8G 编译平均1-1.5个小时完成编译安装 如时间不充足需临时取消编译可Ctrl+C取消安装 ]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️此安装时长由服务器配置决定 配置越高越快 重要的事情说三遍 ]\033[0m"

sleep 10

echo -e "正在安装"
make -j$(nproc) && make -j$(nproc) install

echo -e "环境变量配置"
echo 'export PATH=/usr/local/gcc/bin:$PATH'>>/etc/profile
echo -e "环境变量配置完成"
}

# 配置软连
{
echo -e "配置软连"
cd /usr/lib64
rm -rf libstdc++.so.6
cp /usr/local/gcc/lib64/libstdc++.so.6.0.32 /usr/lib64
ln -sf libstdc++.so.6.0.32 libstdc++.so.6
echo -e "软连配置完成"
}

# 软连配置检测
echo -e "软连配置检测"
strings /usr/lib64/libstdc++.so.6 | grep GLIB
echo -e "\033[31m\033[01m[ $1警告⚠️⚠️⚠️软连配置检测请确认是否配置成功  ]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️⚠️⚠️软连配置检测请确认是否配置成功  ]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️⚠️⚠️软连配置检测请确认是否配置成功  ]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️⚠️⚠️以防导致部分功能无法正常使用  ]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️⚠️⚠️请仔细检查输出日志  ]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️⚠️⚠️如无反馈请手动配置后在重启否则后果自负 重要的事情说三遍 ]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️⚠️⚠️手动配置方法百度搜索gcc 升级后动态库不更新问题解决 重要的事情说三遍 ]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️⚠️⚠️手动配置方法可参考这篇文章 https://blog.csdn.net/aganliang/article/details/103227028 ]\033[0m"
echo -e "\033[31m\033[01m[ $1警告⚠️⚠️⚠️如yum等无法正常使用, 此处将停留36秒  ]\033[0m"

sleep 36

# Gcc-13.2安装完成
{
echo -e "Gcc-${version}编译已完成"
}

# 编译完成删除Gcc文件
{
rm -rf gcc-*
echo -e "Gcc文件删除成功"
}

# 重启系统
{
read -p "需重启系统才能使环境变量生效，是否现在重启 ? [Y/n] :" yn
  [ -z "${yn}" ] && yn="y"
  if [[ $yn == [Yy] ]]; then
    echo -e "${Info} VPS 重启中..."
    reboot
  fi
}

