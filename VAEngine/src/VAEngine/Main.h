#pragma once

#ifdef VAE_PLATFORM_WINDOWS

extern VAEngine::Application* VAEngine::CreateApplication();

int main(int args, char** argv)
{
	VAEngine::Log::Init();
	VAE_CORE_WARN("Initialization log");
	VAE_INFO("Welcome to Visual Applications Engine (VAE)");

	auto app = VAEngine::CreateApplication();
	app->Run();
	delete app;
}

#endif