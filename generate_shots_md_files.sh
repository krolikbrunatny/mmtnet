#!/usr/bin/env bash
# Written in [Amber](https://amber-lang.com/)
# version: 0.3.4-alpha
# date: 2024-07-28 22:23:35
function replace_once__1_v0 {
    local source=$1
    local pattern=$2
    local replacement=$3
    __AMBER_VAL_0=$(echo "${source/${pattern}/${replacement}}");
    __AS=$?;
    __AF_replace_once1_v0="${__AMBER_VAL_0}";
    return 0
}
function replace__2_v0 {
    local source=$1
    local pattern=$2
    local replacement=$3
    __AMBER_VAL_1=$(echo "${source//${pattern}/${replacement}}");
    __AS=$?;
    __AF_replace2_v0="${__AMBER_VAL_1}";
    return 0
}
function lines__10_v0 {
    local text=$1
    __AMBER_ARRAY_0=();
    local result=("${__AMBER_ARRAY_0[@]}")
    IFS=$'
' read -rd '' -a result <<<"$text";
    __AS=$?
    __AF_lines10_v0=("${result[@]}");
    return 0
}
function trim_left__13_v0 {
    local text=$1
    __AMBER_VAL_2=$(echo "${text}" | sed -e 's/^[[:space:]]*//');
    __AS=$?;
    __AF_trim_left13_v0="${__AMBER_VAL_2}";
    return 0
}
function trim_right__14_v0 {
    local text=$1
    __AMBER_VAL_3=$(echo "${text}" | sed -e 's/[[:space:]]*$//');
    __AS=$?;
    __AF_trim_right14_v0="${__AMBER_VAL_3}";
    return 0
}
function trim__15_v0 {
    local text=$1
    trim_right__14_v0 "${text}";
    __AF_trim_right14_v0__74_22="${__AF_trim_right14_v0}";
    trim_left__13_v0 "${__AF_trim_right14_v0__74_22}";
    __AF_trim_left13_v0__74_12="${__AF_trim_left13_v0}";
    __AF_trim15_v0="${__AF_trim_left13_v0__74_12}";
    return 0
}
function get_template_str__48_v0 {
    local title=$1
    local desc=$2
    local date=$3
    local resource=$4
    local template="---
title: ${title}
description: ${desc}
params:
  resource: ${resource}
date: ${date}
style: shots/css/single.css
---"
    __AF_get_template_str48_v0="${template}";
    return 0
}
function get_title_from_commit__49_v0 {
    local file=$1
    __AMBER_VAL_4=$(git log -n 1 --format=%s -- ${file});
    __AS=$?;
if [ $__AS != 0 ]; then
        echo "Git log failed with status: $__AS"
fi;
    local title="${__AMBER_VAL_4}"
    trim__15_v0 "${title}";
    __AF_trim15_v0__21_10="${__AF_trim15_v0}";
    __AF_get_title_from_commit49_v0="${__AF_trim15_v0__21_10}";
    return 0
}
function get_desc_from_commit__50_v0 {
    local file=$1
    __AMBER_VAL_5=$(git log -n 1 --format=%B -- ${file} | tail -n +2);
    __AS=$?;
if [ $__AS != 0 ]; then
        echo "Git log failed with status: $__AS"
fi;
    local desc="${__AMBER_VAL_5}"
    trim__15_v0 "${desc}";
    __AF_trim15_v0__29_10="${__AF_trim15_v0}";
    desc="${__AF_trim15_v0__29_10}"
    __AMBER_VAL_6=$(echo "${desc}" | sed '1{/^[[:space:]]*$/d;}');
    __AS=$?;
if [ $__AS != 0 ]; then
        echo "Failed to remove new lines in the beginning of a string, status: $__AS"
fi;
    desc="${__AMBER_VAL_6}"
    if [ $([ "_${desc}" != "_" ]; echo $?) != 0 ]; then
        __AF_get_desc_from_commit50_v0="No description.";
        return 0
fi
    __AF_get_desc_from_commit50_v0="${desc}";
    return 0
}
function get_date_from_commit__51_v0 {
    local file=$1
    __AMBER_VAL_7=$(git log --reverse --date=format:'%Y-%m-%d' --format=%cd -- ${file} | head -1);
    __AS=$?;
if [ $__AS != 0 ]; then
        echo "Git log failed with status:: $__AS"
fi;
    local date="${__AMBER_VAL_7}"
    trim__15_v0 "${date}";
    __AF_trim15_v0__50_10="${__AF_trim15_v0}";
    __AF_get_date_from_commit51_v0="${__AF_trim15_v0__50_10}";
    return 0
}
args=("$@")
    shots_path="./assets/shots"
    __AMBER_VAL_8=$(find ${shots_path} -type f -maxdepth 1 -exec basename {\} \;);
    __AS=$?;
if [ $__AS != 0 ]; then
        echo "Find command failed with status: $__AS"
fi;
    lines__10_v0 "${__AMBER_VAL_8}";
    __AF_lines10_v0__56_16=("${__AF_lines10_v0[@]}");
    images=("${__AF_lines10_v0__56_16[@]}")
    replace_once__1_v0 "${shots_path}" "./assets/" "";
    __AF_replace_once1_v0__60_24="${__AF_replace_once1_v0}";
    resources_path="${__AF_replace_once1_v0__60_24}"
    idx=0;
for name in "${images[@]}"
do
        file="${shots_path}""/""${name}"
        get_title_from_commit__49_v0 "${file}";
        __AF_get_title_from_commit49_v0__63_17="${__AF_get_title_from_commit49_v0}";
        title="${__AF_get_title_from_commit49_v0__63_17}"
        get_desc_from_commit__50_v0 "${file}";
        __AF_get_desc_from_commit50_v0__64_16="${__AF_get_desc_from_commit50_v0}";
        desc="${__AF_get_desc_from_commit50_v0__64_16}"
        get_date_from_commit__51_v0 "${file}";
        __AF_get_date_from_commit51_v0__65_16="${__AF_get_date_from_commit51_v0}";
        date="${__AF_get_date_from_commit51_v0__65_16}"
        resource="${resources_path}""/""${name}"
        get_template_str__48_v0 "${title}" "${desc}" "${date}" "${resource}";
        __AF_get_template_str48_v0__67_20="${__AF_get_template_str48_v0}";
        contents="${__AF_get_template_str48_v0__67_20}"
        replace__2_v0 "${title}" " " "-";
        __AF_replace2_v0__69_19="${__AF_replace2_v0}";
        md_file="${__AF_replace2_v0__69_19}"
        md_file="${md_file}"".md"
        echo "${contents}" > ./content/shots/${md_file};
        __AS=$?;
if [ $__AS != 0 ]; then
            echo "Markdown file creation failed with status: $__AS"
fi
        (( idx++ )) || true
done