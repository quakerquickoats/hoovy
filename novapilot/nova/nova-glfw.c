//
// Nova
//
// (c) 2018 Lyndon Tremblay
//

#include "nova.h"

#include <stdio.h>
#include <string.h>
#include <GL/gl.h>
#include <GLFW/glfw3.h>

#include <caml/mlvalues.h>

nova_session_t nova = {
    // config
    { 240, 320 }
};

GLFWwindow* window;

static void error_callback(int error, const char* description)
{
    NV_Error("GLFW Error: %i: %s", error, description);
}

void NV_Init (int w, int h)
{
    nova_config_t *c = &nova.config;
    memset(&nova, 0, sizeof(nova));

    glfwSetErrorCallback(error_callback);
        
    if (!glfwInit())
        NV_Error("Failed to initialize GLFW.");

    c->width = w;
    c->height = h;

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);
    /*     windowHint ~hint:WindowHint.RefreshRate ~value:(Some 60); */
    /* windowHint ~hint:WindowHint.DepthBits ~value:None; */

    window = glfwCreateWindow(c->width, c->height, "Nova", NULL, NULL);
    if (!window)
        NV_Error("Failed to create GLFW window.");
    
    glfwMakeContextCurrent(window);
    glfwSetInputMode(window, GLFW_STICKY_KEYS, GL_TRUE);
    glfwSwapInterval(1);

    //glClearColor();
    glClear(GL_COLOR_BUFFER_BIT);
    glViewport(0, 0, c->width, c->height);
}

void NV_Shutdown ()
{
    glfwDestroyWindow(window);
    memset(&nova, 0, sizeof(nova));
    glfwTerminate();
}

BOOL NV_Update ()
{
    glfwPollEvents();
    
    if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS ||
        glfwWindowShouldClose(window))
        return Val_bool(NO);
    
    return Val_bool(YES);
}

void NV_EndFrame ()
{
    if (window)
        glfwSwapBuffers(window);
}

double NV_GetTime ()
{
    return glfwGetTime();
}
