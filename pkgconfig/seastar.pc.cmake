prefix=@CMAKE_INSTALL_PREFIX@
exec_prefix=${prefix}
includedir=${prefix}/@CMAKE_INSTALL_INCLUDEDIR@
libdir=${prefix}/@CMAKE_INSTALL_LIBDIR@

Name: Seastar
Url: http://seastar-project.org
Description: Advanced C++ framework for high-performance server applications on modern hardware.
Version: @PROJECT_VERSION@

# Platform dependencies.
dl_libs=$<JOIN:@dl_LIBRARIES@, >
stdfilesystem_libs=$<JOIN:@StdFilesystem_LIBRARIES@, >
rt_libs=$<JOIN:@rt_LIBRARIES@, >

# Dependencies of dependencies.
boost_system_libs=@Boost_SYSTEM_LIBRARY@

# Dependencies.
boost_cflags=-I$<JOIN:@Boost_INCLUDE_DIRS@, -I>
boost_filesystem_libs=@Boost_FILESYSTEM_LIBRARY@
boost_program_options_libs=@Boost_PROGRAM_OPTIONS_LIBRARY@
boost_thread_libs=${boost_system_libs} @Boost_THREAD_LIBRARY@
c_ares_cflags=-I$<JOIN:@c-ares_INCLUDE_DIRS@, -I>
c_ares_libs=$<JOIN:@c-ares_LIBRARIES@, >
cryptopp_cflags=-I$<JOIN:@cryptopp_INCLUDE_DIRS@, -I>
cryptopp_libs=$<JOIN:@cryptopp_LIBRARIES@, >
dpdk_libs=$<JOIN:@dpdk_LIBRARIES@, >
fmt_cflags=-I$<JOIN:$<TARGET_PROPERTY:fmt::fmt,INTERFACE_INCLUDE_DIRECTORIES>, -I>
fmt_libs=$<TARGET_LINKER_FILE:fmt::fmt>
lksctp_tools_cflags=-I$<JOIN:@lksctp-tools_INCLUDE_DIRS@, -I>
lksctp_tools_libs=$<JOIN:@lksctp-tools_LIBRARIES@, >
numactl_cflags=-I$<JOIN:@numactl_INCLUDE_DIRS@, -I>
numactl_libs=$<JOIN:@numactl_LIBRARIES@, >
sanitizers_cflags=$<JOIN:@Sanitizers_COMPILER_OPTIONS@, >

# Us.
seastar_cflags=-I{includedir} $<JOIN:$<TARGET_PROPERTY:seastar,INTERFACE_COMPILE_OPTIONS>, > -D$<JOIN:$<TARGET_PROPERTY:seastar,INTERFACE_COMPILE_DEFINITIONS>, -D>
seastar_libs=$<TARGET_FILE:seastar>

Requires: liblz4 >= 1.8.0
Requires.private: gnutls >= 3.5.18, protobuf >= 3.3.1, hwloc >= 1.11.5, yaml-cpp >= 0.5.3
Conflicts:
Cflags: ${boost_cflags}  ${c_ares_cflags} ${cryptopp_cflags} ${fmt_cflags} ${lksctp_tools_cflags} ${numactl_cflags} ${sanitizers_cflags} ${seastar_cflags}
Libs: ${boost_program_options_libs} ${boost_thread_libs} ${c_ares_libs} ${cryptopp_libs} ${fmt_libs} ${seastar_libs}
Libs.private: ${dl_libs} ${rt_libs} ${boost_filesystem_libs} ${boost_thread_libs} ${dpdk_libs} ${lksctp_tools_libs} ${numactl_libs} ${stdfilesystem_libs}
