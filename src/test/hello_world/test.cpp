#include "gtest/gtest.h"
#include "imgui.h""


TEST(DUMMY_TEST, DO_STUFF_AND_THINGS)
{
  IMGUI_CHECKVERSION();
  ImGui::CreateContext();
  ImGui::ShowDemoWindow();
}
