#pragma once

#include "Defines.h"

#include "VAEngine/Window.h"
#include "VAEngine/LayerStack.h"
#include "Events/Event.h"
#include "VAEngine/Events/ApplicationEvent.h"

namespace VAEngine {

	class VAE_API Application
	{
	public:
		Application();
		virtual ~Application(); // this destructor should be virtual because we want to inherit this class by application/game project

		void Run();
		void OnEvent(Event& e);

		void PushLayer(Layer* layer);
		void PushOverlay(Layer* layer);

		inline static Application& Get() { return *s_Instance; }
		inline Window& GetWindow() { return *m_Window; }
	private:
		bool OnWindowClose(WindowCloseEvent& e);

		std::unique_ptr<Window>m_Window;
		bool m_Running = true;
		LayerStack m_LayerStack;
		static Application* s_Instance;
	};

	// to be defined in CLIENT
	Application* CreateApplication();
}
