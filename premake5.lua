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
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "vaepch.h"
	pchsource "VAEngine/src/vaepch.cpp"

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
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
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"
		 
		defines
		{
			"VAE_PLATFORM_WINDOWS",
			"VAE_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/SandboxApplication")
		}

	filter "configurations:Debug"
		defines "VAE_DEBUG"
		buildoptions "/MDd"
		symbols "On"

	filter "configurations:Release"
		defines "VAE_RELEASE"
		buildoptions "/MD"
		optimize "On"

	filter "configurations:Debug"
		defines "VAE_DIST"
		buildoptions "/MDd"
		optimize "On"

project "SandboxApplication"
	location "SandboxApplication"
	kind "ConsoleApp"
	language "C++"

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
		"VAEngine/src"
	}

	links
	{
		"VAEngine"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"VAE_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "VAE_DEBUG"
		buildoptions "/MDd"
		symbols "On"

	filter "configurations:Release"
		defines "VAE_RELEASE"
		buildoptions "/MD"
		optimize "On"

	filter "configurations:Debug"
		defines "VAE_DIST"
		buildoptions "/MDd"
		optimize "On"
