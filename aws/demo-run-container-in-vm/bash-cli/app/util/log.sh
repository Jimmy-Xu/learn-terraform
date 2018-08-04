#!/bin/bash
#log path is ${LOG_DIR}/bash-cli
#if commod execute sucessed,it will return 0 else return 1


LOG_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && cd ../../log && pwd )"

function log_info ()
{
    if [  -d ${LOG_DIR}  ]
    then
        mkdir -p ${LOG_DIR} 
    fi

    LOG_FILENAME="$1"
    if [ "${LOG_FILENAME}" == "" ];then
        LOG_FILENAME="default"
    else
        shift
    fi

    DATE_N=`date "+%Y-%m-%d %H:%M:%S"`
    USER_N=`whoami`
    echo "${DATE_N} ${USER_N} execute $0 \n[INFO] $@" >> ${LOG_DIR}/$LOG_FILENAME #执行成功日志打印路径
}

function log_error ()
{
    LOG_FILENAME="$1"
    if [ "${LOG_FILENAME}" == "" ];then
        LOG_FILENAME="default"
    else
        shift
    fi

    DATE_N=`date "+%Y-%m-%d %H:%M:%S"`
    USER_N=`whoami`
    echo -e "\033[41;37m ${DATE_N} ${USER_N} execute $0 \n[ERROR] $@ \033[0m"  >>${LOG_DIR}/$LOG_FILENAME.err #执行失败日志打印路径
}

function fn_log ()  {
    if [  $? -eq 0  ]
    then
        LOG_FILENAME="$1"
        if [ "${LOG_FILENAME}" == "" ];then
            LOG_FILENAME="default"
        else
            shift
        fi
        log_info "$LOG_FILENAME" "$@ sucessed."
        echo -e "\033[32m $@ sucessed. \033[0m"
    else
        LOG_FILENAME="$1"
        if [ "${LOG_FILENAME}" == "" ];then
            LOG_FILENAME="default"
        else
            shift
        fi
        log_error "$LOG_FILENAME" "$@ failed."
        echo -e "\033[41;37m $@ failed. \033[0m"
        exit 1
    fi
}

trap 'fn_log "DO NOT SEND CTR + C WHEN EXECUTE SCRIPT !!!! "'  2