#include <iostream>

void createMemoryLeak() {
    // Allocate memory for an integer
    int a =5;


    // Normally, we would delete the allocated memory
    // delete leakyInt;

    // Because we do not delete it, we have a memory leak
}

int main() {
    // Call the function that creates a memory leak
    createMemoryLeak();

    // Continue with the rest of the program
    std::cout << "Program is running, but there's a memory leak!" << std::endl;

    return 0;
}
