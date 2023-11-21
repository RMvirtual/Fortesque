#include <iostream>
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include "fortesque.h"
#include <math.h>

#include "shader.h"

const unsigned int SCREEN_WIDTH = 800;
const unsigned int SCREEN_HEIGHT = 600;


// Issue drawing triangle colours from file.
// Appears to not be pulling through.
int main()
{
    std::cout << "Starting program." << std::endl;
    
    glfwInit();
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    GLFWwindow* window = glfwCreateWindow(
        SCREEN_WIDTH, SCREEN_HEIGHT, "Fortesque", NULL, NULL);

    if (window == NULL) {
        std::cout << "Failed to create GLFW window" << std::endl;
        glfwTerminate();

        return -1;
    }

    glfwMakeContextCurrent(window);
    glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);

    if (!gladLoadGLLoader((GLADloadproc) glfwGetProcAddress)) {
        std::cout << "Failed to initialize GLAD" << std::endl;

        return -1;
    }

    Shader ourShader("3.3.shader.vs", "3.3.shader.fs");

    float vertices[] = {
        // positions         // colors
        0.5f, -0.5f, 0.0f,  1.0f, 0.0f, 0.0f,   // bottom right
        -0.5f, -0.5f, 0.0f,  0.0f, 1.0f, 0.0f,   // bottom left
        0.0f,  0.5f, 0.0f,  0.0f, 0.0f, 1.0f    // top 
    }; 

    unsigned int VBO, VAO;
    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);
    
    // Bind vertex array object first, then bind and set vertex 
    // buffer(s), and then configure vertex attributes(s).
    glBindVertexArray(VAO);
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    // Position attribute.
    glVertexAttribPointer(
        0, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float), (void*) 0);
    
    glEnableVertexAttribArray(0);

    // Colour attribute.
    glVertexAttribPointer(
        1, 3, GL_FLOAT, GL_FALSE, 6 * sizeof(float),
        (void*) (3 * sizeof(float))
    );

    glEnableVertexAttribArray(1);

    // note that this is allowed, the call to glVertexAttribPointer 
    // registered VBO as the vertex attribute's bound vertex buffer 
    // object so afterwards we can safely unbind
    // glBindBuffer(GL_ARRAY_BUFFER, 0); 

    // You can unbind the VAO afterwards so other VAO calls won't 
    // accidentally modify this VAO, but this rarely happens.
    // Modifying other VAOs requires a call to glBindVertexArray anyways
    // so we generally don't unbind VAOs (nor VBOs) when it's not
    // directly necessary.
    glBindVertexArray(0); 


    // uncomment this call to draw in wireframe polygons.
    // glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

    // render loop
    while (!glfwWindowShouldClose(window)) {
        processInput(window);

        // Clear screen.
        glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);

        // Draw our first triangle
        ourShader.use();
        
        // Seeing as we only have a single VAO there's no need to bind
        // it every time, but we'll do so to keep things a bit more
        // organized.
        glBindVertexArray(VAO); 
        glDrawArrays(GL_TRIANGLES, 0, 3);
        
        // Hmm...
        // glBindVertexArray(0); // no need to unbind it every time 
 
        // glfw: swap buffers and poll IO events.
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    // optional: de-allocate all resources once outlived purpose.
    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);

    // glfw terminate, clearing all previously allocated GLFW resources.
    glfwTerminate();

    return 0;
}

void processInput(GLFWwindow *window)
{
    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
        glfwSetWindowShouldClose(window, true);
}

void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
    // make sure the viewport matches the new window dimensions; note 
    // that width and height will be significantly larger than specified
    // on retina displays.
    glViewport(0, 0, width, height);
}