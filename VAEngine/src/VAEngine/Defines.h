#pragma once

#ifdef VAE_PLATFORM_WINDOWS
	#ifdef VAE_BUILD_DLL
		#define VAE_API __declspec(dllexport)
	#else 
		#define VAE_API __declspec(dllimport)
	#endif
#else
	#error Visual Applications Engine only support Windows
#endif

#ifdef VAE_ENABLE_ASSERTS
#define VAE_ASSERT(x, ...) { if(!(x)) { VAE_ERROR("Assertion Failed: {0}", __VA_ARGS__); __debugbreak(); } }
#define VAE_CORE_ASSERT(x, ...) { if(!(x)) { VAE_CORE_ERROR("Assertion Failed: {0}", __VA_ARGS__); __debugbreak(); } }
#else
#define VAE_ASSERT(x, ...)
#define VAE_CORE_ASSERT(x, ...)
#endif

#define BIT(x) (1 << x) 