double absCustom(double x) { 
    return (x < 0) ? -x : x;
}

double findCubicRoot(double x, double eps) {
    // функция считает кубичесий корень из числа х с точностью eps
    // применен быстро сходящийся итерационный алгоритм
    double root = x / 3;   // начальное приближение корня
    double rootDiv = x;                  // значение корня последовательным делением
    while(absCustom(root - rootDiv) >= eps){
        rootDiv = x;
        for(int i = 1; i < 3; i++){
            rootDiv /= root;
        }
        root = 0.5 * (rootDiv + root);
    }
    return root;
}
