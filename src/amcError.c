// amcError.c

#include "amcTypes.h"
#include <errno.h>
#include <string.h>


const char *_LIB_ERROR_STR[] = {
    "success",
    "unknown error",
    "library bug",
};

#define _MAX_LIB_ERRNO      (sizeof(_LIB_ERROR_STR) / sizeof(_LIB_ERROR_STR[0]) - 1)


const char *AMCError_StrError(AMCError error)
{
    if (error.sys_errno) {
        return strerror(error.sys_errno);
    }
    else if (error.lib_errno) {
        if (error.lib_errno > _MAX_LIB_ERRNO) {
            return "undefined error";
        }
        else {
            return _LIB_ERROR_STR[error.lib_errno];
        }
    }
    else {
        return "success";
    }
}


void AMCError_SetSysErrno(AMCError *error_ptr, int sys_errno)
{
    if (error_ptr) {
        error_ptr->sys_errno = sys_errno;
        error_ptr->lib_errno = 0;
    }
    return;
}


void AMCError_SetLibErrno(AMCError *error_ptr, int lib_errno)
{
    if (error_ptr) {
        error_ptr->sys_errno = 0;
        error_ptr->lib_errno = lib_errno;
    }
    return;
}


void AMCError_SetSuccess(AMCError *error_ptr)
{
    if (error_ptr) {
        error_ptr->sys_errno = 0;
        error_ptr->lib_errno = 0;
    }
    return;
}


BOOL AMCError_IsSuccess(const AMCError *error_ptr)
{
    if (error_ptr) {
        return (0 == error_ptr->sys_errno) && (0 == error_ptr->lib_errno);
    }
    else {
        return FALSE;
    }
}


BOOL AMCError_IsError(const AMCError *error_ptr)
{
    if (error_ptr) {
        return error_ptr->sys_errno || error_ptr->lib_errno;
    }
    else {
        return TRUE;
    }
}


AMCError AMCError_Make(int sys_errno, int lib_errno)
{
    AMCError error;
    error.sys_errno = sys_errno;
    error.lib_errno = lib_errno;
    return error;
}


AMCError AMCError_MakeSuccess()
{
    AMCError error = {0, 0};
    return error;
}

