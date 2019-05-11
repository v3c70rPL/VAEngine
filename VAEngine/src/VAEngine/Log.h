#pragma once

#include "Defines.h"
#include  "spdlog/spdlog.h"
#include "spdlog/fmt/ostr.h"

namespace VAEngine {

	class VAE_API Log
	{
	public:
		static void Init();

		inline static std::shared_ptr<spdlog::logger>& GetCoreLogger() { return s_CoreLogger; }
		inline static std::shared_ptr<spdlog::logger>& GetClientLogger() { return s_ClientLogger; }

	private:
		static std::shared_ptr<spdlog::logger> s_CoreLogger;
		static std::shared_ptr<spdlog::logger> s_ClientLogger;
	};
}

// engine log macros
#define VAE_CORE_FATAL(...) ::VAEngine::Log::GetCoreLogger()->fatal(__VA_ARGS__)
#define VAE_CORE_ERROR(...) ::VAEngine::Log::GetCoreLogger()->error(__VA_ARGS__)
#define VAE_CORE_WARN(...) ::VAEngine::Log::GetCoreLogger()->warn(__VA_ARGS__)
#define VAE_CORE_INFO(...) ::VAEngine::Log::GetCoreLogger()->info(__VA_ARGS__)
#define VAE_CORE_TRACE(...) ::VAEngine::Log::GetCoreLogger()->trace(__VA_ARGS__)

// client log macros
#define VAE_FATAL(...) ::VAEngine::Log::GetClientLogger()->fatal(__VA_ARGS__)
#define VAE_ERROR(...) ::VAEngine::Log::GetClientLogger()->error(__VA_ARGS__)
#define VAE_WARN(...) ::VAEngine::Log::GetClientLogger()->warn(__VA_ARGS__)
#define VAE_INFO(...) ::VAEngine::Log::GetClientLogger()->info(__VA_ARGS__)
#define VAE_TRACE(...) ::VAEngine::Log::GetClientLogger()->trace(__VA_ARGS__)
