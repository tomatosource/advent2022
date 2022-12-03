#include <stdio.h>
#include <string.h>

#define MAX_LEN 8
#define THEM_IDX 0
#define ME_IDX 2


int main(void) {
	FILE* fp;
	fp = fopen("input.txt", "r");

	char buffer[MAX_LEN];
	int sum = 0;
	while (fgets(buffer, MAX_LEN, fp)) {
			switch (buffer[THEM_IDX]) {
				case 'A':
					switch (buffer[ME_IDX]) {
						case 'X':
							// rock lose -> play scissors
							sum += 3; // 0 + 3
							break;
						case 'Y':
							// rock draw -> play rock
							sum += 4; // 3 + 1
							break;
						case 'Z':
							// rock win -> play paper
							sum += 8; // 6 + 2
							break;
					}
					break;
				case 'B':
					switch (buffer[ME_IDX]) {
						case 'X':
							// paper lose -> play rock
							sum += 1; // 0 + 1
							break;
						case 'Y':
							// paper draw -> play paper
							sum += 5; // 3 + 2
							break;
						case 'Z':
							// paper draw -> play scissors
							sum += 9; // 6 + 3
							break;
					}
					break;
				case 'C':
					switch (buffer[ME_IDX]) {
						case 'X':
							// scissors lose -> play paper
							sum += 2; // 0 + 2
							break;
						case 'Y':
							// scissors draw -> play scissors
							sum += 6; // 3 + 3
							break;
						case 'Z':
							// scissors lose -> play rock
							sum += 7; // 6 + 1
							break;
					}
					break;
			}
	}

	fclose(fp);
	printf("%d\n", sum);
	return 0;
}
