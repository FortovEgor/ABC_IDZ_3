#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>

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


int main(int argc, char** argv) {
	// ee command prompt paramentrs below (in the nearest function "printf")
	if (argc != 5) {  // argv[0] is the name of executed file
        	printf("Command line must have 1-st arguement (int (bool) value - 1, 2 or 3) - 1 - if user wants to input a number himself, 2 - generate a double number, 3 - take a number from input file; 2-nd & 3-rd parameters - full names of input & output files. The fourth arguement is double value: in 1-st case it is a number, in the 2-nd - seed of the generator, in the 3-rd - any value.\n");
        	return 1;
        }
        double num, result;
        int seed;
        const double eps = 0.00005;   // 0.05% <=> 0.0005
        FILE *input, *output;

	/* INPUT begin */
	if (atoi(argv[1]) == 1) {  // working with users's input number
		num = strtod(argv[4], 0);  // введенное пользователем число
        } else if (atoi(argv[1]) == 2) {  // working with generated number 
        	seed = atoi(argv[4]);
		srand(seed);
		num = (double) (rand() % 12 + 7);
        	srand(seed+1);
        	num /= (double) (rand() % 17 + 3);
        	// теперь num - псевдослучайное действит. число
        } else {  // take a number from input file
        	input = fopen(argv[2], "r");
        	fscanf(input, "%lf", &num);
        	fclose(input);
        	// теперь num - число, взятое из файла
        }
        
        /* INPUT end */
	
	/* MAIN ALGORITHM BEGIN */
	clock_t t;
        t = clock();  // НАЧАЛО ЗАМЕРА ВРЕМЕНИ
	result = findCubicRoot(num, eps);
	const int iterations_num = 3000000;  
	// 3M iterations is enough for string to slow down algo speed
	// execution time is more than 1 sec (see in console)
	for (int i = 0; i < iterations_num; ++i) {  // extra cycles in order to slow down the algorithm
		result = findCubicRoot(num, eps);
	}
	t = clock() - t;  // КОНЕЦ ЗАМЕРА ВРЕМЕНИ
	double time_taken = ((double) t)/ CLOCKS_PER_SEC; // in seconds
	/* MAIN ALGORITHM END */
	
	/* OUTPUT begin */
	// выведем получившийся результат И в консоль, И в output file
	// в консоль также выведем время
	output = fopen(argv[3], "w");
	fprintf(output, "%lf", result);
	fclose(output);
	printf("initial number: %lf\n", num);
	printf("answer: %lf\n", result);
	printf("TIME: %lf sec\n", time_taken); 
	/* OUTPUT end */
	
	return 0;
}
