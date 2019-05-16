workspace "VAEngine"
	architecture "x64"
	startproject "SandboxApplication"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["GLFW"] = "VAEngine/vendor/GLFW/include"
IncludeDir["Glad"] = "VAEngine/vendor/Glad/include"
IncludeDir["Imgui"] = "VAEngine/vendor/imgui"

include "VAEngine/vendor/GLFW"
include "VAEngine/vendor/Glad"
include "VAEngine/vendor/imgui"

project "VAEngine"
	location "VAEngine"
	kind "StaticLib"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "vaepch.h"
	pchsource "VAEngine/src/vaepch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	defines
	{
		"_CRT_SECURE_NO_WARNINGS"
	}	

	includedirs
	{
		"%{prj.name}/src",
		"%{prj.name}/vendor/spdlog/include",
		"%{IncludeDir.GLFW}",
		"%{IncludeDir.Glad}",
		"%{IncludeDir.Imgui}"
	}

	links
	{
		"GLFW",
		"Glad",
		"Imgui",
		"opengl32.lib"
	}

	filter "system:windows"
		systemversion "latest"
		 
		defines
		{
			"VAE_PLATFORM_WINDOWS",
			"VAE_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

	filter "configurations:Debug"
		defines "VAE_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "VAE_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Debug"
		defines "VAE_DIST"
		runtime "Release"
		optimize "on"

project "SandboxApplication"
	location "SandboxApplication"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"VAEngine/vendor/spdlog/include",
		"VAEngine/src",
		"VAEngine/vendor"
	}

	links
	{
		"VAEngine"
	}

	filter "system:windows"
		systemversion "latest"
		staticruntime "on"

		defines
		{
			"VAE_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "VAE_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "VAE_RELEASE"
		runtime "Release"
		optimize "on"

	filter "configurations:Debug"
		defines "VAE_DIST"
		runtime "Release"
		optimize "on"
