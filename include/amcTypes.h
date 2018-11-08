// amcTypes.h

#ifndef __AMC_TYPES_H__
#define __AMC_TYPES_H__

// ==========
// Basic types
#ifndef BOOL
#define BOOL    int
#define FALSE   (0)
#define TRUE    (!0)
#endif

#ifndef NULL
#define NULL    ((void*)0)
#endif


// ==========
// error type
typedef struct AMC_ERROR {
    int     sys_errno;
    int     lib_errno;
} AMCError;

enum {
    AMC_ERR_SUCCESS = 0,
    AMC_ERR_UNKNOWN_ERROR,
    AMC_ERR_BUGGY,
};

const char *AMCError_StrError(AMCError error);
void AMCError_SetSysErrno(AMCError *error_ptr, int sys_errno);
void AMCError_SetLibErrno(AMCError *error_ptr, int lib_errno);
void AMCError_SetSuccess(AMCError *error_ptr);
BOOL AMCError_IsSuccess(const AMCError *error_ptr);
BOOL AMCError_IsError(const AMCError *error_ptr);
AMCError AMCError_Make(int sys_errno, int lib_errno);
AMCError AMCError_MakeSuccess();

#endif  /* EOF */
