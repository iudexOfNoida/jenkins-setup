#include <iostream>

void createMemoryLeak() {
    int a =5;
    std::cout<<a<<std::endl;
}

int main() {
    // Call the function that creates a memory leak
    createMemoryLeak();

    // Continue with the rest of the program
    std::cout << "Program is running, but there's a memory leak!" << std::endl;

    return 0;
}
