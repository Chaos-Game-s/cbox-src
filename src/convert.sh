#!/bin/bash
convert_vcxproj_to_cmake() {
    local vcxproj_file=$1
    local cmakelists_file="CMakeLists.txt"
    echo "Converting $vcxproj_file to $cmakelists_file..."
    local project_name=$(grep -oP '<ProjectName>\K[^<]+' "$vcxproj_file" | head -n 1)
    local source_files=$(grep -oP '<ClCompile Include="\K[^"]+' "$vcxproj_file")
    local header_files=$(grep -oP '<ClInclude Include="\K[^"]+' "$vcxproj_file")
    echo "cmake_minimum_required(VERSION 3.20)" > "$cmakelists_file"
    echo "project(${project_name} LANGUAGES CXX)" >> "$cmakelists_file"
    echo "set(SOURCES" >> "$cmakelists_file"
    for file in $source_files; do
        echo "    $file" >> "$cmakelists_file"
    done
    echo ")" >> "$cmakelists_file"
    echo "add_executable(${project_name} ${SOURCES})" >> "$cmakelists_file"
    echo "Conversion complete: $cmakelists_file created."
}

convert_sln_to_cmake() {
    local sln_file=$1
    local cmakelists_file="CMakeLists.txt"
    echo "Converting $sln_file to $cmakelists_file..."
    local projects=$(grep -oP 'Project\(\".*\"\) = \"\K[^"]+' "$sln_file")
    echo "cmake_minimum_required(VERSION 3.20)" > "$cmakelists_file"
    echo "project(Solution LANGUAGES CXX)" >> "$cmakelists_file"
    for project in $projects; do
        echo "add_subdirectory($project)" >> "$cmakelists_file"
    done
    echo "Conversion complete: $cmakelists_file created."
}

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path-to-vcxproj-or-sln>"
    exit 1
fi
input_file=$1
if [[ $input_file == *.vcxproj ]]; then
    convert_vcxproj_to_cmake "$input_file"
elif [[ $input_file == *.sln ]]; then
    convert_sln_to_cmake "$input_file"
else
    echo "Error: Unsupported file type. Please provide a .vcxproj or .sln file."
    exit 1
fi