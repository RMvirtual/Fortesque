#include <iostream>
#include <glad/glad.h>
#include <GLFW/glfw3.h>

int main();

void framebuffer_size_callback(GLFWwindow * window, int width, int height);
void processInput(GLFWwindow* window);


const unsigned int SCR_WIDTH = 800;
const unsigned int SCR_HEIGHT = 600;

const char* vertexShaderSource = "#version 330 core\n"
"layout (location = 0) in vec3 aPos;\n"
"void main()\n"
"{\n"
"   gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);\n"
"}\0";

const char* fragmentShaderSource = "#version 330 core\n"
"out vec4 FragColor;\n"
"void main()\n"
"{\n"
"   FragColor = vec4(1.0f, 0.5f, 0.2f, 1.0f);\n"
"}\n\0";


int main()
{
	// OpenGL initialisation.
	glfwInit();
	glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
	glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

	// GLFW window creation.
	GLFWwindow* window = glfwCreateWindow(800, 600, "LearnOpenGL", NULL, NULL);
	if (window == NULL)
	{
		std::cout << "Failed to create GLFW window" << std::endl;
		glfwTerminate();

		return -1;
	}

	glfwMakeContextCurrent(window);
	glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);

	// Initialise GLAD and load all OpenGL function pointers.
	if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
	{
		std::cout << "Failed to initialize GLAD" << std::endl;
		return -1;
	}

    // Build and compile shader program.
    // Vertex shader.
    unsigned int vertexShader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
    glCompileShader(vertexShader);
    
    // Check for shader compile errors.
    int success;
    glGetShaderiv(vertexShader, GL_COMPILE_STATUS, &success);
    char infoLog[512];
    
    if (!success) {
        glGetShaderInfoLog(vertexShader, 512, NULL, infoLog);
        
        std::cout << 
            "ERROR::SHADER::VERTEX::COMPILATION_FAILED\n"
            << infoLog << std::endl;
    }

    // Fragment shader.
    unsigned int fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragmentShader, 1, &fragmentShaderSource, NULL);
    glCompileShader(fragmentShader);
    
    // Check for shader compile errors.
    glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, &success);
    
    if (!success) {
        glGetShaderInfoLog(fragmentShader, 512, NULL, infoLog);
        std::cout << "ERROR::SHADER::FRAGMENT::COMPILATION_FAILED\n" << infoLog << std::endl;
    }

    // Link shaders.
    unsigned int shaderProgram = glCreateProgram();
    glAttachShader(shaderProgram, vertexShader);
    glAttachShader(shaderProgram, fragmentShader);
    glLinkProgram(shaderProgram);
    
    // Check for linking errors.
    glGetProgramiv(shaderProgram, GL_LINK_STATUS, &success);
    
    if (!success) {
        glGetProgramInfoLog(shaderProgram, 512, NULL, infoLog);
        std::cout << "ERROR::SHADER::PROGRAM::LINKING_FAILED\n" << infoLog << std::endl;
    }

    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);

    // Setup vertex data (and buffers) and configure vertex attributes.
    float triangle1[] = {
        -0.9f, -0.9f, 0.0f, // left  
         0.1f, -0.9f, 0.0f, // right 
        -0.4f,  0.1f, 0.0f, // top
    };

    float triangle2[] = {
     0.1f, -0.9f, 0.0f, // left  
     0.9f, -0.9f, 0.0f, // right 
     0.45f,  0.1f, 0.0f  // top
    };

    // Vertex array object, vertex buffer object.
    unsigned int vertexBuffers[2], vertexArrays[2];
    glGenVertexArrays(2, vertexArrays);
    glGenBuffers(2, vertexBuffers);

    // first triangle setup
    glBindVertexArray(vertexArrays[0]);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffers[0]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(triangle1), triangle1, GL_STATIC_DRAW);
    glVertexAttribPointer(
        0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*) 0);
    glEnableVertexAttribArray(0);
    
    // second triangle setup
    glBindVertexArray(vertexArrays[1]);
    glBindBuffer(GL_ARRAY_BUFFER, vertexBuffers[1]);	
    
    glBufferData(
        GL_ARRAY_BUFFER, sizeof(triangle2), triangle2, GL_STATIC_DRAW);
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 0, (void*) 0);
    glEnableVertexAttribArray(0);
    
    glVertexAttribPointer(
        0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*) 0);
    
    glEnableVertexAttribArray(0);

    // uncomment this call to draw in wireframe polygons.
    // glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);

	// Rendering loop.
	while (!glfwWindowShouldClose(window)) {
		// Input.
		processInput(window);
		
		// Rendering
        glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);
        glUseProgram(shaderProgram);


        // Draw first triangle using the data from the first VAO.
        glBindVertexArray(vertexArrays[0]);
        glDrawArrays(GL_TRIANGLES, 0, 3);

        // Draw second triangle using the data from the second VAO.
        glBindVertexArray(vertexArrays[1]);
        glDrawArrays(GL_TRIANGLES, 0, 3);

        // Check and call events and swap buffers.
		glfwSwapBuffers(window);
		glfwPollEvents();
	}

    // Optional: de-allocate all resources once outlived purpose.
    glDeleteVertexArrays(2, vertexArrays);
    glDeleteBuffers(2, vertexBuffers);
    glDeleteProgram(shaderProgram);

	glfwTerminate();

	return 0;
}


// Make sure viewport matches the GLFW window size.
void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
	glViewport(0, 0, width, height);
}


//Process user input.
void processInput(GLFWwindow* window)
{
	if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
		glfwSetWindowShouldClose(window, true);
}
