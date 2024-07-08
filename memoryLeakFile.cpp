#include <iostream>

void createMemoryLeak() {
    int* ptr = new int(5);  // Allocating memory without freeing it
}

int main() {
    createMemoryLeak();  // Call the function that creates a memory leak
    std::cout << "Program finished." << std::endl;

    return 0;
}
