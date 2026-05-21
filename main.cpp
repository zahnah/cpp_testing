#include <cstdlib>
#include <iostream>
#include <string>
#include "utils.h"

int main(int argc, char* argv[]) {
    if (argc != 3) {
        std::cerr << "Usage: sum_app <a> <b>\n";
        return 1;
    }
    int a = std::stoi(argv[1]);
    int b = std::stoi(argv[2]);
    std::cout << add(a, b) << '\n';
    return 0;
}
