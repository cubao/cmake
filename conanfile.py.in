from conans import ConanFile, tools
import os


class CppLibraryConan(ConanFile):
    name = "CppLibrary"
    version = "0.1"
    settings = "os", "compiler", "build_type", "arch"
    description = "<Description of cpp lib here>"
    url = "None"
    license = "None"
    author = "None"
    topics = None
    generators = "cmake"
    requires = ()

    def package(self):
        prefix = "/workdir"
        self.copy("*", dst="include/prefix", src=f"{prefix}/include")
        self.copy("*", dst="lib", src=f"{prefix}/build/lib")
        self.copy("*", dst="bin", src="{prefix}/build/bin")

    def package_info(self):
        self.cpp_info.libs = tools.collect_libs(self)

    def imports(self):
        self.copy("*", "bin", "bin")
        self.copy("*.so*", "lib", "lib")
