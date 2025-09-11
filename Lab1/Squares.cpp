void compute_c(int a, int b, int &c) {
    // Intermediate variables
    long long aa = (long long)a * (long long)a; // a^2
    long long bb = (long long)b * (long long)b; // b^2

    long long result = aa - bb;

    if (result <= 0) {
        c = 0;
        return;
    }

    // Initial guess for sqrt(result)
    long long root = result/3;

    // Newton's method
    for (int i = 0; i < 32; i++) {
        root = (root + result / root) / 2;
    }

    c = (int)root;
}
