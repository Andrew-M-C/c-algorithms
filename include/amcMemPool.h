// amcMemPool.h

#ifndef __AMC_MEM_POOL_H__
#define __AMC_MEM_POOL_H__

#include "amcTypes.h"

struct AMCMemPool;
struct AMCMemUnit;
typedef void (*AMCMemPool_DidEmpty_Callback)(struct AMCMemPool *pool, void *arg);

struct AMCMemPool *AMCMemPool_Create(unsigned long unitSize, unsigned long initUnitCount, unsigned long growUnitCount, BOOL useLock);
int AMCMemPool_Destory(struct AMCMemPool *pool);
BOOL AMCMemPool_IsAllFree(struct AMCMemPool *pool);
int AMCMemPool_SetEmptyCallback(struct AMCMemPool *pool, AMCMemPool_DidEmpty_Callback callback, void *arg);

void *AMCMemPool_Alloc(struct AMCMemPool *pool);
int AMCMemPool_Free(void *pData);

unsigned long AMCMemPool_DataSize(void *data);
unsigned long AMCMemPool_UnitSizeForPool(struct AMCMemPool *pool);

void AMCMemPool_DebugStdout(struct AMCMemPool *pool);

unsigned long AMCMemPool_MemoryUsage(struct AMCMemPool *pool);


#endif  /* EOF */
