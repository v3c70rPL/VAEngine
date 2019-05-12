#include <VAEngine.h>

class ExampleLayer : public VAEngine::Layer
{
public:
	ExampleLayer() : Layer("Example")
	{
	}

	void OnUpdate() override
	{
	}

	void OnEvent(VAEngine::Event& event) override
	{
		VAE_TRACE("{0}", event);
	}
};

class Sandbox : public VAEngine::Application
{
public:
	Sandbox()
	{
		PushLayer(new ExampleLayer());
		PushOverlay(new VAEngine::ImGuiLayer());
	}

	~Sandbox()
	{

	}
};

VAEngine::Application* VAEngine::CreateApplication()
{
	return new Sandbox();
}