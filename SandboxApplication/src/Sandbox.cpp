#include <VAEngine.h>
#include "imgui/imgui.h"

class ExampleLayer : public VAEngine::Layer
{
public:
	ExampleLayer() : Layer("Example")
	{
	}

	void OnUpdate() override
	{
	}

	virtual void OnImGuiRender() override
	{
		ImGui::Begin("ExampleLayer");
		ImGui::Text("Hello World from Example Layer ");
		ImGui::End();
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
	}

	~Sandbox()
	{

	}
};

VAEngine::Application* VAEngine::CreateApplication()
{
	return new Sandbox();
}