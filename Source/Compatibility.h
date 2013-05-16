/**
 Hacks, macros, includes etc to massage the FTPDirectoryParser code into compiling.
 */

#define ENABLE(x) 1
#define PLATFORM(x) defined(PLATFORM_##x)
#define OS(x) defined (OS_##x)
#define USE(x) defined(USE_##x)
#define HAVE(x) defined(HAVE_##x)

#define PLATFORM_MAC

#include <memory.h>
#include <assert.h>
#include <stdint.h>

#define ASSERT assert

#define WTF_ARRAY_LENGTH(x) 32

#ifdef __cpp
namespace WTF {
}
#endif

