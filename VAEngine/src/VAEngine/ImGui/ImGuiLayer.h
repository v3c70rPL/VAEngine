#pragma once

#include "VAEngine/Layer.h"
#include "VAEngine/Events/KeyEvent.h"
#include "VAEngine/Events/MouseEvent.h"
#include "VAEngine/Events/ApplicationEvent.h"

namespace VAEngine
{
	class VAE_API ImGuiLayer : public Layer
	{
	public:
		ImGuiLayer();
		~ImGuiLayer();

		virtual void OnAttach() override;
		virtual void OnDetach() override;
		virtual void OnImGuiRender() override ;

		void Begin();
		void End();
	private:
		float m_Time = 0.0f;
	};
}