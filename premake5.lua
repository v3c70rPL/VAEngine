workspace "va-engine"
	architecture "x64"
	startproject "sandbox-app"

	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

IncludeDir = {}
IncludeDir["GLFW"] = "va-engine/vendor/GLFW/include"
IncludeDir["Glad"] = "va-engine/vendor/Glad/include"
IncludeDir["Imgui"] = "va-engine/vendor/imgui"

include "va-engine/vendor/GLFW"
include "va-engine/vendor/Glad"
include "va-engine/vendor/imgui"

project "va-engine"
	location "va-engine"
	kind "SharedLib"
	language "C++"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	pchheader "vaepch.h"
	pchsource "va-engine/src/vaepch.cpp"

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
			"DE_PLATFORM_WINDOWS",
			"DE_BUILD_DLL",
			"GLFW_INCLUDE_NONE"
		}

		postbuildcommands
		{
			("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. outputdir .. "/sandbox-app")
		}

	filter "configurations:Debug"
		defines "DE_DEBUG"
		buildoptions "/MDd"
		symbols "On"

	filter "configurations:Release"
		defines "DE_RELEASE"
		buildoptions "/MD"
		optimize "On"

	filter "configurations:Debug"
		defines "DE_DIST"
		buildoptions "/MDd"
		optimize "On"

project "sandbox-app"
	location "sandbox-app"
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
		"va-engine/vendor/spdlog/include",
		"va-engine/src"
	}

	links
	{
		"va-engine"
	}

	filter "system:windows"
		cppdialect "C++17"
		staticruntime "On"
		systemversion "latest"

		defines
		{
			"DE_PLATFORM_WINDOWS"
		}

	filter "configurations:Debug"
		defines "DE_DEBUG"
		buildoptions "/MDd"
		symbols "On"

	filter "configurations:Release"
		defines "DE_RELEASE"
		buildoptions "/MD"
		optimize "On"

	filter "configurations:Debug"
		defines "DE_DIST"
		buildoptions "/MDd"
		optimize "On"
